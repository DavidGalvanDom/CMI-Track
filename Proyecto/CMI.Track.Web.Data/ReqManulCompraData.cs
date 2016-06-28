///Propósito: Datos de Categorias
///Fecha creación: 02/Febrero/2016
///Creador: David Jasso
///Fecha modifiacción: 
///Modificó:
///Dependencias de conexiones e interfaces: SQLServer

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Microsoft.Practices.EnterpriseLibrary.Data;
using CMI.Track.Web.Models;

namespace CMI.Track.Web.Data
{
    public class ReqManulCompraData
    {


        /// <summary>
        /// Se carga el listado de Marcas
        /// </summary>
        /// <param name="idRequerimiento"></param>
        /// <param name="idEstatus"></param>
        /// <returns>Lista de Marcas</returns>
        public static List<Models.ListaReqManualCompra> CargaMaterialesDetalle(int Item, int idRequerimiento)
        {
            var lstReqManualCompra = new List<Models.ListaReqManualCompra>();
            object[] paramArray = new object[3];
            try
            {
                paramArray[0] = Item;
                paramArray[1] = idRequerimiento;
                paramArray[2] = null;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarDetalleReqManual", paramArray))
                {
                    while (dataReader.Read())
                    {
                        lstReqManualCompra.Add(new Models.ListaReqManualCompra()
                        {
                            id = Convert.ToInt32(dataReader["idDetalleRequisicion"]),
                            idMaterialSelect = Convert.ToInt32(dataReader["idMaterial"]),
                            nombreMaterial = Convert.ToString(dataReader["nombreMaterial"]),
                            Calidad = Convert.ToString(dataReader["calidadMaterial"]),
                            Ancho = Convert.ToInt32(dataReader["anchoMaterial"]),
                            Largo = Convert.ToInt32(dataReader["largoMaterial"]),
                            Cantidad = Convert.ToInt32(dataReader["cantidadSolicitada"]),
                            Peso = Convert.ToInt32(dataReader["pesoMaterial"]),
                            Unidad = Convert.ToString(dataReader["nombreCortoUnidadMedida"])
                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
            return lstReqManualCompra;
        }

        /// <summary>
        /// Se carga el listado de Marcas
        /// </summary>
        /// <param name="idRequerimiento"></param>
        /// <param name="idEstatus"></param>
        /// <returns>Lista de Marcas</returns>
        public static Models.ReqManualCompra CargaMaterialesDetalles(int Item, int idRequerimiento, string idRequisicion)
        {
            object[] paramArray = new object[4];
            try
            {
                paramArray[0] = Item;
                paramArray[1] = idRequerimiento;
                paramArray[2] = null;
                paramArray[3] = idRequisicion == "" ? null : idRequisicion;


                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarDetalleReqManual", paramArray))
                {
                    while (dataReader.Read())
                    {
                        var objRequiMaterial = new Models.ReqManualCompra()
                        {

                            id = Convert.ToInt32(dataReader["idDetalleRequisicion"]),
                            idMaterialSelect = Convert.ToInt32(dataReader["idMaterial"]),
                            nombreMaterial = Convert.ToString(dataReader["nombreMaterial"]),
                            Calidad = Convert.ToString(dataReader["calidadMaterial"]),
                            Ancho = Convert.ToInt32(dataReader["anchoMaterial"]),
                            Largo = Convert.ToInt32(dataReader["largoMaterial"]),
                            Cantidad = Convert.ToInt32(dataReader["cantidadSolicitada"]),
                            Peso = Convert.ToInt32(dataReader["pesoMaterial"]),
                            Unidad = Convert.ToInt32(dataReader["idUnidadMedida"]),
                            Almacen = Convert.ToInt32(dataReader["idAlmacen"])
                        };

                        return objRequiMaterial;
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }

            return null;

        }
        /// <summary>
        /// Se carga el listado de Marcas
        /// </summary>
        /// <param name="idRequerimiento"></param>
        /// <param name="idEstatus"></param>
        /// <returns>Lista de Marcas</returns>
        public static List<Models.ListaReqManualCompra> CargaDetalleManual(int idRequerimiento, string idRequisicion, int? idEstatus)
        {
            var lstReqManualCompra = new List<Models.ListaReqManualCompra>();
            object[] paramArray = new object[4];
            try
            {
                paramArray[0] = null;
                paramArray[1] = idRequerimiento;
                paramArray[2] = 1;
                paramArray[3] = idRequisicion == "" ? null : idRequisicion;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarDetalleReqManual", paramArray))
                {
                    while (dataReader.Read())
                    {
                        lstReqManualCompra.Add(new Models.ListaReqManualCompra()
                        {
                            id = Convert.ToInt32(dataReader["idDetalleRequisicion"]),
                            idMaterialSelect = Convert.ToInt32(dataReader["idMaterial"]),
                            nombreMaterial = Convert.ToString(dataReader["nombreMaterial"]),
                            Calidad = Convert.ToString(dataReader["calidadMaterial"]),
                            Ancho = Convert.ToInt32(dataReader["anchoMaterial"]),
                            Largo = Convert.ToInt32(dataReader["largoMaterial"]),
                            Cantidad = Convert.ToInt32(dataReader["cantidadSolicitada"]),
                            Peso = Convert.ToInt32(dataReader["pesoMaterial"]),
                            Unidad = Convert.ToString(dataReader["nombreCortoUnidadMedida"])
                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
            return lstReqManualCompra;
        }

 
        /// <summary>
        /// Se carga el listado de requisiciones
        /// </summary>
        /// <param name="idEtapa"></param>
        /// <param name="idEstatus"></param>
        /// <returns>Lista de Etapas</returns>
        public static List<Models.ListaReqManualCompra> CargaRequisicionesGeneral(int idEtapa, int idProyecto, int idRequerimiento, int? idEstatus)
        {
            var listaRequisiciones = new List<Models.ListaReqManualCompra>();
            object[] paramArray = new object[4];
            try
            {
                paramArray[0] = idEtapa;
                paramArray[1] = idProyecto;
                paramArray[2] = idRequerimiento;
                paramArray[3] = 1;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarRequisiciones", paramArray))
                {
                    while (dataReader.Read())
                    {
                        listaRequisiciones.Add(new Models.ListaReqManualCompra()
                        {
                            id = Convert.ToInt32(dataReader["idRequisicion"]),
                            NombreOrigen = Convert.ToString(dataReader["nombreOrigenRequisicion"]),
                            Causa = Convert.ToString(dataReader["causaRequisicion"]),
                            Estatus = Convert.ToString(dataReader["Estatus"]),
                            Serie = Convert.ToString(dataReader["serieRequisicion"]),
                            Factura = Convert.ToString(dataReader["facturaRequisicion"]),
                            Proveedor = Convert.ToString(dataReader["proveedorRequisicion"]),
                            FechaFac = Convert.ToString(dataReader["fechaFacturaRequisicion"]),
                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
            return listaRequisiciones;
        }

        /// <summary>
        /// Se guarda la informacion de una nueva categora
        /// </summary>
        /// <param name="pobjModelo">Datos nueva Categoria</param>
        /// <returns>value</returns>
        public static string Guardar(Models.ReqManualCompra pobjModelo)
        {
            object[] paramArray = new object[10];
            string result = "";
            try
            {             
                paramArray[0] = pobjModelo.idRequerimiento;
                paramArray[1] = 1;
                paramArray[2] = pobjModelo.Origen;
                paramArray[3] = pobjModelo.Almacen;
                paramArray[4] = pobjModelo.usuarioCreacion;
                paramArray[5] = pobjModelo.idMaterialSelect;
                paramArray[6] = pobjModelo.Cantidad;
                paramArray[7] = pobjModelo.Causa;
                paramArray[8] = pobjModelo.Unidad;
                paramArray[9] = pobjModelo.idRequisicion;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var dbResult = db.ExecuteScalar("usp_InsertarRequisicion", paramArray);

                result = dbResult.ToString();

                if (result == "-3")
                    throw new ApplicationException("La requisicion inicial ya fue autorizada y no puede ser modificada.");

                return (result);
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }

        /// <summary>
        /// Se actuliza la informacion de la Requisicion
        /// </summary>
        /// <param name="pobjModelo">Datos de la requisicion</param>
        /// <returns>value</returns>
        public static string Autorizar(int Autoriza, int idRequisicion, int idRequerimiento)
        {
            object[] paramArray = new object[4];
            try
            {
                paramArray[0] = Autoriza;
                paramArray[1] = idRequisicion;
                paramArray[2] = idRequerimiento;
                paramArray[3] = 5;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteNonQuery("usp_AutorizarRequisicion", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }


        /// <summary>
        /// Se actuliza la informacion de la categoria
        /// </summary>
        /// <param name="pobjModelo">Datos de la categoria</param>
        /// <returns>value</returns>
        public static string Actualiza(Models.ReqManualCompra pobjModelo)
        {
            object[] paramArray = new object[6];
            string result = "";
            try
            {
                paramArray[0] = pobjModelo.idRequerimiento;
                paramArray[1] = pobjModelo.idMaterialSelect;
                paramArray[2] = pobjModelo.Cantidad;
                paramArray[3] = pobjModelo.Unidad;
                paramArray[4] = pobjModelo.id;
                paramArray[5] = pobjModelo.idRequisicion;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var DbResult = db.ExecuteScalar("usp_ActualizarRequiMateriales", paramArray);

                result = DbResult.ToString();

                if (result == "-3")
                    throw new ApplicationException("La requisicion ya fue autorizada y no puede ser modificada.");
                
                return (result);
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }


        /// <summary>
        /// Remueve de base de datos la el material de la requisicion
        /// </summary>
        /// <param name="idMatReq"></param>
        /// <returns></returns>
        public static string Borrar(string idMatReq, int idRequisicion)
        {
            object[] paramArray = new object[2];
            string result = "";
            try
            {
                paramArray[0] = idMatReq;
                paramArray[1] = idRequisicion;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var dbResult = db.ExecuteScalar("usp_RemueveMaterialRequisicion", paramArray);

                result = dbResult.ToString();

                if (result == "-3")
                    throw new ApplicationException("La requisicion ya fue autorizada y no puede ser modificada.");

                return (result);

            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }

        /// <summary>
        /// Se carga el reporte de requerimiento
        /// </summary>
        /// <returns>Lista Requerimiento</returns>
        public static List<Models.ListaReqManualCompra> CargaInfoRequerimiento(int idProyecto, int idEtapa, int idRequerimiento)
        {
            var listaRptRequerimiento = new List<Models.ListaReqManualCompra>();
            object[] paramArray = new object[3];
            try
            {
                paramArray[0] = idProyecto;
                paramArray[1] = idEtapa;
                paramArray[2] = idRequerimiento;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarRptRequerimiento", paramArray))
                {
                    while (dataReader.Read())
                    {
                        listaRptRequerimiento.Add(new Models.ListaReqManualCompra()
                        {
                            idProyecto = Convert.ToInt32(dataReader["idProyecto"]),
                            NombreProyecto = Convert.ToString(dataReader["nombreProyecto"]),
                            idEtapa = Convert.ToInt32(dataReader["idEtapa"]),
                            NombreEtapa = Convert.ToString(dataReader["nombreEtapa"]),
                            FolioRequerimiento = Convert.ToString(dataReader["folioRequerimiento"]),
                            NombreDepto = Convert.ToString(dataReader["nombreDepartamento"]),
                            NomnreUsuario = Convert.ToString(dataReader["nombreUsuario"]),
                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }

            return listaRptRequerimiento;
        }

        /// <summary>
        /// Se carga el reporte de requisiciones
        /// </summary>
        /// <returns>Lista Requerimiento</returns>
        public static List<Models.ListaReqManualCompra> CargaInfoRequisicion(int idProyecto, int idEtapa, int idRequerimiento)
        {
            var listaRptRequerimiento = new List<Models.ListaReqManualCompra>();
            object[] paramArray = new object[3];
            try
            {
                paramArray[0] = idProyecto;
                paramArray[1] = idEtapa;
                paramArray[2] = idRequerimiento;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarRptRequisicion", paramArray))
                {
                    while (dataReader.Read())
                    {
                        listaRptRequerimiento.Add(new Models.ListaReqManualCompra()
                        {
                            idProyecto = Convert.ToInt32(dataReader["idProyecto"]),
                            NombreProyecto = Convert.ToString(dataReader["nombreProyecto"]),
                            idEtapa = Convert.ToInt32(dataReader["idEtapa"]),
                            NombreEtapa = Convert.ToString(dataReader["nombreEtapa"]),
                            FolioRequerimiento = Convert.ToString(dataReader["folioRequisicion"]),
                            NombreDepto = Convert.ToString(dataReader["nombreDepartamento"]),
                            NomnreUsuario = Convert.ToString(dataReader["nombreUsuario"]),
                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }

            return listaRptRequerimiento;
        }

       
    }
}
