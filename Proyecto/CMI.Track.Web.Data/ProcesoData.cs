///Propósito: Datos Procesos
///Fecha creación: 10/Febrero/2016
///Creador: Juan Lopepe
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
    public class ProcesoData
    {
        /// <summary>
        /// Se carga el listado de Procesos
        /// </summary>
        /// <returns>Lista Proceso</returns>
        public static List<Models.ListaProceso> CargaProcesos()
        {
            var listaProcesos = new List<Models.ListaProceso>();
            object[] paramArray = new object[2];
            try
            {
                paramArray[0] = null;
                paramArray[1] = null;
                
                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarProcesos", paramArray))
                {
                    while (dataReader.Read())
                    {
                        listaProcesos.Add(new Models.ListaProceso()
                        {
                            id = Convert.ToInt32(dataReader["idProceso"]),
                            nombreProceso = Convert.ToString(dataReader["nombreProceso"]),
                            idEstatus = Convert.ToInt32(dataReader["idEstatus"]),
                            estatus = Convert.ToString(dataReader["nombreEstatus"]),
                            idTipoProceso = Convert.ToInt32(dataReader["idTipoProceso"]),
                            nombreTipoProceso = Convert.ToString(dataReader["nombreTipoProceso"])
                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }

            return listaProcesos;
        }
        
        /// <summary>
        /// Cargar un Proceso
        /// </summary>
        /// <returns>Un Proceso</returns>
        public static Models.Proceso CargaProceso(string idProceso)
        {
            object[] paramArray = new object[2];
            try
            {
                paramArray[0] = idProceso == "" ? null : idProceso;
                paramArray[1] = null;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarProcesos", paramArray))
                {
                    while (dataReader.Read())
                    {
                        var objProceso = new Models.Proceso()
                        {
                            id = Convert.ToInt32(dataReader["idProceso"]),
                            nombreProceso = Convert.ToString(dataReader["nombreProceso"]),
                            idEstatus = Convert.ToInt32(dataReader["idEstatus"]),
                            idTipoProceso = Convert.ToInt32(dataReader["idTipoProceso"])
                        };
                        return objProceso;
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
        /// Se carga el listado de Procesos Activos
        /// </summary>
        /// <returns>Lista Proceso</returns>
        public static List<Models.ListaProceso> CargaProcesosActivos()
        {
            var listaProcesos = new List<Models.ListaProceso>();
            object[] paramArray = new object[2];
            try
            {
                paramArray[0] = null;
                paramArray[1] = 1;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarProcesos", paramArray))
                {
                    while (dataReader.Read())
                    {
                        listaProcesos.Add(new Models.ListaProceso()
                        {
                            id = Convert.ToInt32(dataReader["idProceso"]),
                            nombreProceso = Convert.ToString(dataReader["nombreProceso"]),
                            idEstatus = Convert.ToInt32(dataReader["idEstatus"]),
                            estatus = Convert.ToString(dataReader["nombreEstatus"]),
                            idTipoProceso = Convert.ToInt32(dataReader["idTipoProceso"]),
                            nombreTipoProceso = Convert.ToString(dataReader["nombreTipoProceso"])
                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }

            return listaProcesos;
        }

        /// <summary>
        /// Se guarda la informacion de un nuevo Proceso
        /// </summary>
        /// <param name="pobjModelo">Datos nuevo Proceso</param>
        /// <returns>value</returns>
        public static string Guardar(Models.Proceso pobjModelo)
        {
            object[] paramArray = new object[3];
            try
            {
                paramArray[0] = pobjModelo.nombreProceso.ToUpper();
                paramArray[1] = pobjModelo.idTipoProceso;
                paramArray[2] = pobjModelo.usuarioCreacion;
                                
                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteScalar("usp_InsertarProceso", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }

        /// <summary>
        /// Se actualiza la informacion del Proceso
        /// </summary>
        /// <param name="pobjModelo">Datos del Proceso</param>
        /// <returns>value</returns>
        public static string Actualiza(Models.Proceso pobjModelo)
        {
            object[] paramArray = new object[4];
            try
            {
                paramArray[0] = pobjModelo.id;
                paramArray[1] = pobjModelo.nombreProceso.ToUpper();
                paramArray[2] = pobjModelo.idTipoProceso;
                paramArray[3] = pobjModelo.idEstatus;
                
                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteNonQuery("usp_ActualizarProceso", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }

        /// <summary>
        /// Remueve de base de datos el Proceso
        /// </summary>
        /// <param name="idProceso"></param>
        /// <returns></returns>
        public static string Borrar(string idProceso)
        {
            object[] paramArray = new object[1];
            try
            {
                paramArray[0] = idProceso;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteNonQuery("usp_RemueveProceso", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }
    }
}
