///Propósito: Modulo de Carga de Lista general de Partes
///Fecha creación: 11/Marzo/16
///Creador: David Galvan
///Fecha modifiacción: 
///Modificó:
///Dependencias de conexiones e interfaces: 

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.Mvc;
using System.Configuration;
using System.IO;
using System.Data;
using DocumentFormat.OpenXml.Packaging;
using DocumentFormat.OpenXml.Spreadsheet;

using CMI.Track.Web.Models;
using CMI.Track.Web.Data;
using System.Text.RegularExpressions;

namespace CMI.Track.Web.Controllers
{
   public class ListaGeneralController: Controller
   {
       public ActionResult Index()
       {          
           return View();
       }

       /// <summary>
       /// Se valida la informacion del archivo, creando una tabla de respuesta para poder indicar donde estan los errores del archivo.
       /// </summary>
       /// <param name="archivoListaGen"></param>
       /// <returns></returns>
       [HttpPost]
       public JsonResult ValidarInformacion(int idProyecto, int idEtapa, string archivoListaGen)
       {
            string pathArchivo = Server.MapPath("~/" + ConfigurationManager.AppSettings["PathArchivos"].ToString() + "ListaGeneral\\");
            string pathArchivoTem = Server.MapPath("~/" + ConfigurationManager.AppSettings["PathArchivosTem"].ToString());
            string xmlclaveDespiece = "";
            string cadenaCvc = "";
            bool error = false;

           try
           {
               //Se carga la informacion en data table y se valida 
                    // 1. No permite campos vacios
                    // 2. Los tipos de datos que sean numericos
               DataTable result = GetDataTableFromSpreadsheet(System.IO.File.OpenRead(pathArchivoTem + archivoListaGen), 
                                                               false,
                                                               out cadenaCvc,
                                                               out error);

               // En caso de algun error se regresa el formato del archivo en csv para ser desplegado en el xls 
               if (error)               
                   return Json(new { Success = false, Message = "Los datos del archivo no son validos.", excel = cadenaCvc });

               //Se agrupo solo por Plano y tipo de construccion para validar que existan en base de datos
               var planosTipo = (from row in result.AsEnumerable()
                             group row by new { plano = row[1], tipo = row[2] } into grp
                             select new
                             {
                                 codigoPlanoDespiece = grp.Key.plano,
                                 nombreTipoContruccion = grp.Key.tipo

                             }).ToList() ;

               foreach (var plano in planosTipo)               
                  xmlclaveDespiece += string.Format("<id>{0}</id>", plano.codigoPlanoDespiece);

               //Se valida la existencia de los planos que existan en base de datos.
               var lstPlanosDespiece = PlanosDespieceData.CargaExistenciaPlanoDespiece(xmlclaveDespiece, idEtapa);

               // Se toman los planos que no se encontraron en base de datos
               planosTipo.RemoveAll(x => lstPlanosDespiece.Exists(a => a.codigoPlanoDespiece.Trim() == x.codigoPlanoDespiece.ToString().Trim() && a.nombreTipoContruccion.Trim() == x.nombreTipoContruccion.ToString().Trim()));

               if (planosTipo.Count > 0)
               {
                   var cadenaCvcNoExiste = "PLANO_DESPIECE,TIPO_CONSTRUCCION,Error" + Environment.NewLine;
                   foreach (var plano in planosTipo)
                       cadenaCvcNoExiste += string.Format("{0},{1},No existe Catalogo Planos Despiece para el proyecto y etapa seleccionada", plano.codigoPlanoDespiece, plano.nombreTipoContruccion) + Environment.NewLine;

                   return Json(new { Success = false, Message = "Los Planos despiece no existen en base de datos.", excel = cadenaCvcNoExiste });
               }
               
               //La informacion del archivo es correcta y se guarda
               System.IO.File.WriteAllText(pathArchivo + archivoListaGen + "data.txt", cadenaCvc);
               
               //Guardar los Planos Despiece
               System.IO.File.WriteAllLines(pathArchivo + archivoListaGen + "pd.txt", (from plano in lstPlanosDespiece select plano.Serialize()));

               return Json(new { Success = true, numRegistros = result.Rows.Count });
           }
           catch (Exception exp)
           {
               return Json(new { Success = false, Message = exp.Message });
           }
       }

       /// <summary>
       /// Se toman los archivos temporales y se genera una 
       /// lista que agrupa las Marcas en Submarcas para insertar en base datos
       /// </summary>
       /// <param name="idProyecto"></param>
       /// <param name="idEtapa"></param>
       /// <param name="archivoListaGen"></param>
       /// <param name="idUsuario"></param>
       /// <returns></returns>
       [HttpPost]
       public JsonResult SubirInformacion(int idProyecto, int idEtapa, 
                                        string archivoListaGen, int idUsuario)
       {
           string pathArchivo = Server.MapPath("~/" + ConfigurationManager.AppSettings["PathArchivos"].ToString() + "ListaGeneral\\");
           List<LGMMarcas> listMarcas = new List<LGMMarcas>();
           List<Models.ListaPlanosDespiece> listPlanosDes = new List<ListaPlanosDespiece>();
           string linea = "";
           
           try
           {
              //Se carga en una lista los planos despiece
              System.IO.StreamReader planosDespiece = new System.IO.StreamReader(pathArchivo +  archivoListaGen + "pd.txt");
               while((linea = planosDespiece.ReadLine()) != null)
               {
                   string[] arrRenglon = linea.Split('|');
                   listPlanosDes.Add(new ListaPlanosDespiece()
                   {                       
                       id = Convert.ToInt32(arrRenglon[0]), 
                       codigoPlanoDespiece= arrRenglon[1], 
                       idTipoConstruccion= Convert.ToInt32(arrRenglon[2]),
                       nombreTipoContruccion = arrRenglon[3]
                   });
               }
               
               linea = "";
               System.IO.StreamReader archivo = new System.IO.StreamReader(pathArchivo + archivoListaGen + "data.txt");
               linea = archivo.ReadLine();

               while ((linea = archivo.ReadLine()) != null)
               {                  
                   string[] arrLinea = linea.Split(',');

                  
                       var marca = listMarcas.Where(m => m.codigoMarca.Trim() == arrLinea[4].ToString().Trim()).ToList();

                       //En caso de que no exista la Marca
                       if (marca.Count == 0)
                       {
                           var lstSubMarcas = new List<LGMSubMarcas>();
                           lstSubMarcas.Add(new LGMSubMarcas()
                           {
                               codigoSubMarca = arrLinea[5].ToString(),
                               claseSubMarca = arrLinea[6].ToString(),
                               perfilSubMarca = arrLinea[7].ToString(),
                               piezasSubMarcas = Convert.ToInt32(arrLinea[8]),
                               corteSubMarcas = Convert.ToDouble(arrLinea[9]),
                               longitudSubMarcas = Convert.ToDouble(arrLinea[10]),
                               anchoSubMarcas = Convert.ToDouble(arrLinea[11]),
                               gradoSubMarcas = arrLinea[12].ToString(),
                               alturaSubMarcas = Convert.ToDouble(arrLinea[13]),
                               kgmSubMarcas = Convert.ToDouble(arrLinea[14]),
                               totalLASubMarcas = Convert.ToDouble(arrLinea[15]),
                               totalSubMarcas = Convert.ToDouble(arrLinea[16]),
                               pesoSubMarcas = Convert.ToDouble(arrLinea[17])
                           });

                           var objPlano = listPlanosDes.Where(plano => plano.codigoPlanoDespiece.Trim() == arrLinea[1].ToString().Trim() &&
                                                                       plano.nombreTipoContruccion.Trim() == arrLinea[2].ToString().Trim()).ToList();

                           if (objPlano.Count == 0)
                               throw new ApplicationException(string.Format("No se encontro el Plano despiece {0} - {1}", arrLinea[1], arrLinea[2]));

                           listMarcas.Add(new LGMMarcas()
                           {
                               codigoMarca = arrLinea[4].ToString(),
                               piezas = Convert.ToInt32(arrLinea[3]),
                               usuarioCreacion = Convert.ToInt32(idUsuario),
                               idPlanoDespiece = objPlano[0].id,
                               listaSubMarcas = lstSubMarcas
                           });

                       }
                       else
                       {
                           marca[0].listaSubMarcas.Add(new LGMSubMarcas()
                           {
                               codigoSubMarca = arrLinea[5].ToString(),
                               claseSubMarca = arrLinea[6].ToString(),
                               perfilSubMarca = arrLinea[7].ToString(),
                               piezasSubMarcas = Convert.ToInt32(arrLinea[8]),
                               corteSubMarcas = Convert.ToDouble(arrLinea[9]),
                               longitudSubMarcas = Convert.ToDouble(arrLinea[10]),
                               anchoSubMarcas = Convert.ToDouble(arrLinea[11]),
                               gradoSubMarcas = arrLinea[12].ToString(),
                               alturaSubMarcas = Convert.ToDouble(arrLinea[13]),
                               kgmSubMarcas = Convert.ToDouble(arrLinea[14]),
                               totalLASubMarcas = Convert.ToDouble(arrLinea[15]),
                               totalSubMarcas = Convert.ToDouble(arrLinea[16]),
                               pesoSubMarcas = Convert.ToDouble(arrLinea[17]),
                           });
                       }
               }

               archivo.Close();

               //Se guarda en base de datos la informacion del Archivo
               ListaGeneralData.GuardarInformacion(idProyecto, idEtapa, listMarcas, idUsuario);

               return Json(new { Success = true});
           }
           catch (Exception exp)
           {
               return Json(new { Success = false, Message = exp.Message });
           }
       }

       /// <summary>
       /// Metodo para subir los archivos del proyecto
       /// </summary>
       /// <returns></returns>
       [HttpPost]
       public JsonResult SubirArchivo()
       {
           string nombreArchivo = "";
           string pathArchivo = Server.MapPath("~/" +  ConfigurationManager.AppSettings["PathArchivosTem"].ToString());
            
           try
           {
               foreach (string file in Request.Files)
               {
                   var fileContent = Request.Files[file];
                   if (fileContent != null && fileContent.ContentLength > 0)
                   {
                       // get a stream
                       var stream = fileContent.InputStream;
                       var extension = Path.GetExtension(file);

                       if (extension != ".xlsx")
                           throw new ApplicationException("La extension del archivo valida es xlsx.");
                       
                       // and optionally write the file to disk
                       nombreArchivo = Path.GetFileName(file);
                       if (nombreArchivo.Length > 67)
                           nombreArchivo = nombreArchivo.Substring(nombreArchivo.Length - 67, 67);

                       nombreArchivo = string.Format("{0}-{1}", Guid.NewGuid().ToString("N"), nombreArchivo);
                       var path = Path.Combine(pathArchivo, nombreArchivo);
                       using (var fileStream = System.IO.File.Create(path))
                       {
                           stream.CopyTo(fileStream);
                       }
                   }
               }

               return Json(new { Success = true, Archivo = nombreArchivo });
           }
           catch (Exception exp)
           {
               return Json(new { Success = false, Message = exp.Message });
           }
       }

       /// <summary>
       /// Carga el excel en un data Table
       /// </summary>
       /// <param name="MyExcelStream"></param>
       /// <param name="ReadOnly"></param>
       /// <returns></returns>
       public static DataTable GetDataTableFromSpreadsheet(Stream MyExcelStream, bool ReadOnly, 
                                                            out string cadenaCvc, out bool error)
       {
           DataTable dataTable = new DataTable();
           using (SpreadsheetDocument sDoc = SpreadsheetDocument.Open(MyExcelStream, ReadOnly))
           {               
               string desError = "";
               string valor = "";
               WorkbookPart workbookPart = sDoc.WorkbookPart;
               IEnumerable<Sheet> sheets = sDoc.WorkbookPart.Workbook.GetFirstChild<Sheets>().Elements<Sheet>();
               string relationshipId = sheets.First().Id.Value;
               WorksheetPart worksheetPart = (WorksheetPart)sDoc.WorkbookPart.GetPartById(relationshipId);
               Worksheet workSheet = worksheetPart.Worksheet;
               SheetData sheetData = workSheet.GetFirstChild<SheetData>();
               IEnumerable<Row> rows = sheetData.Descendants<Row>();
               error = false;
               cadenaCvc = "";

               int numeroColumnas = rows.ElementAt(0).Count();

               if (numeroColumnas != 18)
                   throw new ApplicationException("El número de columnas del archivo deben ser 18. El archivo que quiere procesar tiene:" + numeroColumnas);               

               //Creacion de columnas para el datatable
               foreach (Cell cell in rows.ElementAt(0))
               {
                   var columName = GetCellValue(sDoc, cell);
                   cadenaCvc += columName + ",";
                   dataTable.Columns.Add(columName);
               }

               cadenaCvc += "Error";
               cadenaCvc += Environment.NewLine;
               
               foreach (Row row in rows) 
               {
                   if (row.RowIndex != 1)
                   {
                       DataRow tempRow = dataTable.NewRow();

                       for (int count = 0; count < row.Descendants<Cell>().Count(); count++)
                       {
                           tempRow[count] = GetCellValue(sDoc, row.Descendants<Cell>().ElementAt(count));
                           valor = tempRow[count].ToString();
                           cadenaCvc += string.Format("{0},",valor);

                           //Todas las columnas deben tener datos
                           if (valor == string.Empty)
                               desError += string.Format("{0} : No puede ir vacio.", dataTable.Columns[count].ColumnName);

                           //Se valida el tipo de dato
                           switch(count)
                           {
                               case 3: //Piezas Marca
                                   if (!valor.IsNumeric())               
                                       desError += string.Format("{0} : El valor debe ser numerico.", dataTable.Columns[count].ColumnName);
                                   else
                                   {
                                       if(Convert.ToInt32(valor) > 1295)
                                           desError += string.Format("{0} : El valor debe no debe ser mayor a 1295.", dataTable.Columns[count].ColumnName);
                                   }
                                   break;
                               case 8:
                               case 9:
                               case 10:
                               case 11:                               
                               case 13:
                               case 14:
                               case 15:
                               case 16:
                               case 17:
                                   if (!valor.IsNumeric())               
                                       desError += string.Format("{0} : El valor debe ser numerico.", dataTable.Columns[count].ColumnName);
                                   break;
                               case 6:
                                   if (!(valor == "C" || valor == "P"))               //Clase
                                       desError += string.Format("{0} : El valor debe ser C o P.", dataTable.Columns[count].ColumnName);
                                   break;
                           }
                           
                           error = desError != string.Empty ? true : error;
                       }

                       dataTable.Rows.Add(tempRow);

                       cadenaCvc += desError + Environment.NewLine;
                       desError = string.Empty;
                   }
               }
           }

           return dataTable;
       }

       /// <summary>
       /// Regresa el valor de la celda del archivo
       /// </summary>
       /// <param name="document"></param>
       /// <param name="cell"></param>
       /// <returns></returns>
       public static string GetCellValue(SpreadsheetDocument document, Cell cell)
       {
           SharedStringTablePart stringTablePart = document.WorkbookPart.SharedStringTablePart;
           string value = "";

           if (cell.CellValue != null)
               value = cell.CellValue.InnerXml;

           if (cell.DataType != null && cell.DataType.Value == CellValues.SharedString)
           {
               return stringTablePart.SharedStringTable.ChildElements[Int32.Parse(value)].InnerText;
           }
           else
           {
               return value;
           }
       }
      
    }

   public static class StringExtensions
   {
       public static bool IsNumeric(this string input)
       {
           float output;
           return float.TryParse(input, out output);           
       }
   }
}
