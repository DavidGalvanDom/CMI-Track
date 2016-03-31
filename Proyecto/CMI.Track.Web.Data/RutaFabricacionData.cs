///Propósito: Datos Rutas Fabricacion
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
    public class RutaFabricacionData
    {
        /// <summary>
        /// Se carga el listado de Rutas de Fabricacion
        /// </summary>
        /// <returns>ListaRutaFabricacion</returns>
        public static List<Models.ListaRutaFabricacion> CargaRutasFabricacion()
        {
            var listaRutasFabricacion = new List<Models.ListaRutaFabricacion>();
            object[] paramArray = new object[2];
            try
            {
                paramArray[0] = null;
                paramArray[1] = null;
                
                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarRutasFabricacion", paramArray))
                {
                    while (dataReader.Read())
                    {
                        listaRutasFabricacion.Add(new Models.ListaRutaFabricacion()
                        {
                            id = Convert.ToInt32(dataReader["idRutaFabricacion"]),
                            idEstatus = Convert.ToInt32(dataReader["idEstatus"]),
                            estatus = Convert.ToString(dataReader["nombreEstatus"]),
                            idCategoria = Convert.ToInt32(dataReader["idCategoria"]),
                            nombreCategoria = Convert.ToString(dataReader["nombreCategoria"]),
                            secuencia = Convert.ToInt32(dataReader["secuenciaRutaFabricacion"]),
                            idProceso = Convert.ToInt32(dataReader["idProceso"]),
                            nombreProceso = Convert.ToString(dataReader["nombreProceso"])
                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }

            return listaRutasFabricacion;
        }
        
        /// <summary>
        /// Cargar una Ruta de Fabricacion
        /// </summary>
        /// <returns>Una RutaFabricacion</returns>
        public static Models.RutaFabricacion CargaRutaFabricacion(string idRutaFabricacion)
        {
            object[] paramArray = new object[2];
            try
            {
                paramArray[0] = idRutaFabricacion == "" ? null : idRutaFabricacion;
                paramArray[1] = null;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarRutasFabricacion", paramArray))
                {
                    while (dataReader.Read())
                    {
                        var objRutaFabricacion = new Models.RutaFabricacion()
                        {
                            id = Convert.ToInt32(dataReader["idRutaFabricacion"]),
                            idEstatus = Convert.ToInt32(dataReader["idEstatus"]),
                            idCategoria = Convert.ToInt32(dataReader["idCategoria"]),
                            secuencia = Convert.ToInt32(dataReader["secuenciaRutaFabricacion"]),
                            idProceso = Convert.ToInt32(dataReader["idProceso"])
                            
                        };
                        return objRutaFabricacion;
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
        /// Se carga el listado de Rutas de Fabricacion Activas
        /// </summary>
        /// <returns>ListaRutaFabricacion</returns>
        public static List<Models.ListaRutaFabricacion> CargaRutasFabricacionActivas()
        {
            var listaRutasFabricacion = new List<Models.ListaRutaFabricacion>();
            object[] paramArray = new object[2];
            try
            {
                paramArray[0] = null;
                paramArray[1] = 1;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarRutasFabricacion", paramArray))
                {
                    while (dataReader.Read())
                    {
                        listaRutasFabricacion.Add(new Models.ListaRutaFabricacion()
                        {
                            id = Convert.ToInt32(dataReader["idRutaFabricacion"]),
                            idEstatus = Convert.ToInt32(dataReader["idEstatus"]),
                            estatus = Convert.ToString(dataReader["nombreEstatus"]),
                            idCategoria = Convert.ToInt32(dataReader["idCategoria"]),
                            nombreCategoria = Convert.ToString(dataReader["nombreCategoria"]),
                            secuencia = Convert.ToInt32(dataReader["secuenciaRutaFabricacion"]),
                            idProceso = Convert.ToInt32(dataReader["idProceso"]),
                            nombreProceso = Convert.ToString(dataReader["nombreProceso"])
                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }

            return listaRutasFabricacion;
        }

        /// <summary>
        /// Se guarda la informacion de una nueva RutaFabricacion
        /// </summary>
        /// <param name="pobjModelo">Datos nueva RutaFabricacion</param>
        /// <returns>value</returns>
        public static string Guardar(Models.RutaFabricacion pobjModelo)
        {
            object[] paramArray = new object[4];
            try
            {
                paramArray[0] = pobjModelo.idCategoria;
                paramArray[1] = pobjModelo.secuencia;
                paramArray[2] = pobjModelo.idProceso;
                paramArray[3] = pobjModelo.usuarioCreacion;
                                
                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteScalar("usp_InsertarRutaFabricacion", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }

        /// <summary>
        /// Se actualiza la informacion de la RutaFabricacion
        /// </summary>
        /// <param name="pobjModelo">Datos de la RutaFabricacion</param>
        /// <returns>value</returns>
        public static string Actualiza(Models.RutaFabricacion pobjModelo)
        {
            object[] paramArray = new object[5];
            try
            {
                paramArray[0] = pobjModelo.id;
                paramArray[1] = pobjModelo.idCategoria;
                paramArray[2] = pobjModelo.secuencia;
                paramArray[3] = pobjModelo.idProceso;
                paramArray[4] = pobjModelo.idEstatus;
                
                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteNonQuery("usp_ActualizarRutaFabricacion", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }

        /// <summary>
        /// Remueve de base de datos la Ruta Fabricacion
        /// </summary>
        /// <param name="idRutaFabricacion"></param>
        /// <returns></returns>
        public static string Borrar(string idRutaFabricacion)
        {
            object[] paramArray = new object[1];
            try
            {
                paramArray[0] = idRutaFabricacion;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteNonQuery("usp_RemueveRutaFabricacion", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }

        /// <summary>
        /// Se carga el siguiente Proceso siguiendo la Ruta de Fabricacion
        /// </summary>
        /// <returns>Proceso</returns>
        /// /// <summary>
        public static Models.Proceso CargarSiguienteProcesoRutaFabricacion(int idProyecto, int idProceso)
        {
            object[] paramArray = new object[2];
            try
            {
                paramArray[0] = idProyecto;
                paramArray[1] = idProceso;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarSiguienteProcesoRutaFabricacion", paramArray))
                {
                    while (dataReader.Read())
                    {
                        var objProceso = new Models.Proceso()
                        {
                            id = Convert.ToInt32(dataReader["idProceso"]),
                            nombreProceso = Convert.ToString(dataReader["nombreProceso"]),
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
    }
}
