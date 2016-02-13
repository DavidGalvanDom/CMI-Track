///Propósito: Datos CalidadProceso
///Fecha creación: 12/Febrero/2016
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
    public class CalidadProcesoData
    {
        /// <summary>
        /// Se carga el listado de CalidadesProceso
        /// </summary>
        /// <returns>ListaCalidadProceso</returns>
        public static List<Models.ListaCalidadProceso> CargaCalidadesProceso()
        {
            var listaCalidadesProceso = new List<Models.ListaCalidadProceso>();
            object[] paramArray = new object[3];
            try
            {
                paramArray[0] = null;
                paramArray[1] = null;
                paramArray[2] = null;
                
                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarCalidadesProceso", paramArray))
                {
                    while (dataReader.Read())
                    {
                        listaCalidadesProceso.Add(new Models.ListaCalidadProceso()
                        {
                            idProceso = Convert.ToInt32(dataReader["idProceso"]),
                            nombreProceso = Convert.ToString(dataReader["nombreProceso"]),
                            secuencia = Convert.ToInt32(dataReader["secuenciaCalidadProceso"]),
                            idTipoCalidad = Convert.ToInt32(dataReader["idTipoCalidad"]),
                            nombreTipoCalidad = Convert.ToString(dataReader["nombreTipoCalidad"]),
                            idEstatus = Convert.ToInt32(dataReader["idEstatus"]),
                            estatus = Convert.ToString(dataReader["nombreEstatus"])
                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }

            return listaCalidadesProceso;
        }
        
        /// <summary>
        /// Cargar una CalidadProceso
        /// </summary>
        /// <returns>Una CalidadProceso</returns>
        public static Models.CalidadProceso CargaCalidadProceso(string idProceso, string idTipoCalidad)
        {
            object[] paramArray = new object[3];
            try
            {
                paramArray[0] = idProceso == "" ? null : idProceso;
                paramArray[1] = idTipoCalidad == "" ? null : idTipoCalidad;
                paramArray[2] = null;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarCalidadesProceso", paramArray))
                {
                    while (dataReader.Read())
                    {
                        var objCalidadProceso = new Models.CalidadProceso()
                        {
                            idProceso = Convert.ToInt32(dataReader["idProceso"]),
                            secuencia = Convert.ToInt32(dataReader["secuenciaCalidadProceso"]),
                            idTipoCalidad = Convert.ToInt32(dataReader["idTipoCalidad"]),
                            idEstatus = Convert.ToInt32(dataReader["idEstatus"]),
                        };
                        return objCalidadProceso;
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
        /// Se carga el listado de CalidadesProceso Activas
        /// </summary>
        /// <returns>ListaCalidadProceso</returns>
        public static List<Models.ListaCalidadProceso> CargaCalidadesProcesoActivas()
        {
            var listaCalidadesProceso = new List<Models.ListaCalidadProceso>();
            object[] paramArray = new object[3];
            try
            {
                paramArray[0] = null;
                paramArray[1] = null;
                paramArray[2] = 1;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarCalidadesProceso", paramArray))
                {
                    while (dataReader.Read())
                    {
                        listaCalidadesProceso.Add(new Models.ListaCalidadProceso()
                        {
                            idProceso = Convert.ToInt32(dataReader["idProceso"]),
                            nombreProceso = Convert.ToString(dataReader["nombreProceso"]),
                            secuencia = Convert.ToInt32(dataReader["secuenciaCalidadProceso"]),
                            idTipoCalidad = Convert.ToInt32(dataReader["idTipoCalidad"]),
                            nombreTipoCalidad = Convert.ToString(dataReader["nombreTipoCalidad"]),
                            idEstatus = Convert.ToInt32(dataReader["idEstatus"]),
                            estatus = Convert.ToString(dataReader["nombreEstatus"])
                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }

            return listaCalidadesProceso;
        }

        /// <summary>
        /// Se guarda la informacion de una nueva CalidadProceso
        /// </summary>
        /// <param name="pobjModelo">Datos nueva CalidadProceso</param>
        /// <returns>value</returns>
        public static string Guardar(Models.CalidadProceso pobjModelo)
        {
            object[] paramArray = new object[4];
            try
            {
                paramArray[0] = pobjModelo.idProceso;
                paramArray[1] = pobjModelo.secuencia;
                paramArray[2] = pobjModelo.idTipoCalidad;
                paramArray[3] = pobjModelo.usuarioCreacion;
                                
                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteScalar("usp_InsertarCalidadProceso", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }

        /// <summary>
        /// Se actualiza la informacion de la CalidadProceso
        /// </summary>
        /// <param name="pobjModelo">Datos de la CalidadProceso</param>
        /// <returns>value</returns>
        public static string Actualiza(Models.CalidadProceso pobjModelo)
        {
            object[] paramArray = new object[4];
            try
            {
                paramArray[0] = pobjModelo.idProceso;
                paramArray[1] = pobjModelo.idTipoCalidad;
                paramArray[2] = pobjModelo.secuencia;
                paramArray[3] = pobjModelo.idEstatus;
                
                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteNonQuery("usp_ActualizarCalidadProceso", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }

        /// <summary>
        /// Remueve de base de datos la CalidadProceso
        /// </summary>
        /// <param name="idProceso, idTipoCalidad"></param>
        /// <returns></returns>
        public static string Borrar(string idProceso, string idTipoCalidad)
        {
            object[] paramArray = new object[2];
            try
            {
                paramArray[0] = idProceso;
                paramArray[1] = idTipoCalidad;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteNonQuery("usp_RemueveCalidadProceso", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }
    }
}
