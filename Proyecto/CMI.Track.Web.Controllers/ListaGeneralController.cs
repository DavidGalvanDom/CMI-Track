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

namespace CMI.Track.Web.Controllers
{
   public class ListaGeneralController: Controller
   {
       public ActionResult Index()
       {
          /* if (!ModelState.IsValid)
           {
               return View(model);
           }

           DataTable dt = GetDataTableFromSpreadsheet(model.MyExcelFile.InputStream, false);
           string strContent = "<p>Thanks for uploading the file</p>" + ConvertDataTableToHTMLTable(dt);
           model.MSExcelTable = strContent;
           return View(model);
           */
           return View();
       }

       /// <summary>
       /// Se valida la informacion del archivo, creando una tabla de respuesta para poder indicar donde estan los errores del archivo.
       /// </summary>
       /// <param name="archivoListaGen"></param>
       /// <returns></returns>
       [HttpPost]
       public JsonResult ValidarInformacion(string archivoListaGen)
       {
            string pathArchivo = ConfigurationManager.AppSettings["PathArchivos"].ToString() + "ListaGeneral\\";
            string pathArchivoTem = ConfigurationManager.AppSettings["PathArchivosTem"].ToString();
            int numeroRenglones = 0;
            int count = 0;
            string tablaErrores = "";

           try
           {
               DataTable result = GetDataTableFromSpreadsheet(System.IO.File.OpenRead(pathArchivoTem + archivoListaGen), false);

               //Valida el numero de columnas del archivo.
               if(result.Columns.Count != 18)
                  return Json(new { Success = false, Message = "El número de columnas del archivo deben ser 18. El archivo que quiere procesar tiene " + result.Columns.Count });

               numeroRenglones = result.Rows.Count;

               // Todos los datos son requeridos
               foreach (DataRow rowData in result.Rows)
               {
                   count++;
                   //Se valida columna por columna
                   foreach (DataColumn colum in result.Columns)
                   {
                       if (rowData[colum].ToString() == string.Empty)
                       {
                           tablaErrores += string.Format("Renglon {0} - {1} : {2}",count, colum.ColumnName, " No hay datos");
                       }
                   }          
               }


               // Tipo de datos
               // Que exista el Plano Despiece por tipo de construccion
               // Que exista la Etapa
               //
               
               //Insertar
               // Agrupar informacion
               //    Agrupar por Etapa
               //    Agrupar por Plano despiece y tipo construccion
               //    Agrupar por Marca
               // Generacion de querys


               return Json(new { Success = true});
           }
           catch (Exception exp)
           {
               return Json(new { Success = false, Message = exp.Message });
           }
       }

       [HttpPost]
       public JsonResult SubirInformacion()
       {
           try
           {

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
           string pathArchivo = ConfigurationManager.AppSettings["PathArchivosTem"].ToString();

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
       /// 
       /// </summary>
       /// <param name="MyExcelStream"></param>
       /// <param name="ReadOnly"></param>
       /// <returns></returns>
       public static DataTable GetDataTableFromSpreadsheet(Stream MyExcelStream, bool ReadOnly)
       {
           DataTable dt = new DataTable();
           using (SpreadsheetDocument sDoc = SpreadsheetDocument.Open(MyExcelStream, ReadOnly))
           {
               WorkbookPart workbookPart = sDoc.WorkbookPart;
               IEnumerable<Sheet> sheets = sDoc.WorkbookPart.Workbook.GetFirstChild<Sheets>().Elements<Sheet>();
               string relationshipId = sheets.First().Id.Value;
               WorksheetPart worksheetPart = (WorksheetPart)sDoc.WorkbookPart.GetPartById(relationshipId);
               Worksheet workSheet = worksheetPart.Worksheet;
               SheetData sheetData = workSheet.GetFirstChild<SheetData>();
               IEnumerable<Row> rows = sheetData.Descendants<Row>();

               foreach (Cell cell in rows.ElementAt(0))
               {
                   dt.Columns.Add(GetCellValue(sDoc, cell));
               }

               foreach (Row row in rows) //this will also include your header row...
               {
                   DataRow tempRow = dt.NewRow();

                   for (int i = 0; i < row.Descendants<Cell>().Count(); i++)
                   {
                       tempRow[i] = GetCellValue(sDoc, row.Descendants<Cell>().ElementAt(i));
                   }

                   dt.Rows.Add(tempRow);
               }
           }
           dt.Rows.RemoveAt(0);
           return dt;
       }

       public static string GetCellValue(SpreadsheetDocument document, Cell cell)
       {
           SharedStringTablePart stringTablePart = document.WorkbookPart.SharedStringTablePart;
           string value = cell.CellValue.InnerXml;

           if (cell.DataType != null && cell.DataType.Value == CellValues.SharedString)
           {
               return stringTablePart.SharedStringTable.ChildElements[Int32.Parse(value)].InnerText;
           }
           else
           {
               return value;
           }
       }

       public static string ConvertDataTableToHTMLTable(DataTable dt)
       {
           string ret = "";
           ret = "<table id=" + (char)34 + "tblExcel" + (char)34 + ">";
           ret += "<tr>";
           foreach (DataColumn col in dt.Columns)
           {
               ret += "<td class=" + (char)34 + "tdColumnHeader" + (char)34 + ">" + col.ColumnName + "</td>";
           }
           ret += "</tr>";
           foreach (DataRow row in dt.Rows)
           {
               ret += "<tr>";
               for (int i = 0; i < dt.Columns.Count; i++)
               {
                   ret += "<td class=" + (char)34 + "tdCellData" + (char)34 + ">" + row[i].ToString() + "</td>";
               }
               ret += "</tr>";
           }
           ret += "</table>";
           return ret;
       }
      


    }
}
