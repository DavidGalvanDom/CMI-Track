///Propósito: Datos Tipos de Calidad
///Fecha creación: 02/Febrero/2016
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
    public class TipoCalidadData
    {
        /// <summary>
        /// Se carga el listado de Tipos de Calidad
        /// </summary>
        /// <returns>Lista TipoCalidad</returns>
        public static List<Models.ListaTipoCalidad> CargaTiposCalidad()
        {
            var listaTiposCalidad = new List<Models.ListaTipoCalidad>();
            object[] paramArray = new object[2];
            try
            {
                paramArray[0] = null;
                paramArray[1] = null;
                
                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarTiposCalidad", paramArray))
                {
                    while (dataReader.Read())
                    {
                        listaTiposCalidad.Add(new Models.ListaTipoCalidad()
                        {
                            id = Convert.ToInt32(dataReader["idTipoCalidad"]),
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

            return listaTiposCalidad;
        }
        
        /// <summary>
        /// Cargar un Tipo de Calidad
        /// </summary>
        /// <returns>Un Tipo de Calidad</returns>
        public static Models.TipoCalidad CargaTipoCalidad(string idTipoCalidad)
        {
            object[] paramArray = new object[2];
            try
            {
                paramArray[0] = idTipoCalidad == "" ? null : idTipoCalidad;
                paramArray[1] = null;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarTiposCalidad", paramArray))
                {
                    while (dataReader.Read())
                    {
                        var objTipoCalidad = new Models.TipoCalidad()
                        {
                            id = Convert.ToInt32(dataReader["idTipoCalidad"]),
                            nombreTipoCalidad = Convert.ToString(dataReader["nombreTipoCalidad"]),
                            idEstatus = Convert.ToInt32(dataReader["idEstatus"])
                        };
                        return objTipoCalidad;
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
        /// Se carga el listado de Tipos de Calidad Activos
        /// </summary>
        /// <returns>Lista TipoCalidad</returns>
        public static List<Models.ListaTipoCalidad> CargaTiposCalidadActivos()
        {
            var listaTiposCalidad = new List<Models.ListaTipoCalidad>();
            object[] paramArray = new object[2];
            try
            {
                paramArray[0] = null;
                paramArray[1] = 1;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarTiposCalidad", paramArray))
                {
                    while (dataReader.Read())
                    {
                        listaTiposCalidad.Add(new Models.ListaTipoCalidad()
                        {
                            id = Convert.ToInt32(dataReader["idTipoCalidad"]),
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

            return listaTiposCalidad;
        }

        /// <summary>
        /// Se guarda la informacion de un nuevo Tipo de Calidad
        /// </summary>
        /// <param name="pobjModelo">Datos nuevo TipoCalidad</param>
        /// <returns>value</returns>
        public static string Guardar(Models.TipoCalidad pobjModelo)
        {
            object[] paramArray = new object[2];
            try
            {
                paramArray[0] = pobjModelo.nombreTipoCalidad.ToUpper();
                paramArray[1] = pobjModelo.usuarioCreacion;
                                
                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteScalar("usp_InsertarTipoCalidad", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }

        /// <summary>
        /// Se actualiza la informacion del TipoCalidad
        /// </summary>
        /// <param name="pobjModelo">Datos del TipoCalidad</param>
        /// <returns>value</returns>
        public static string Actualiza(Models.TipoCalidad pobjModelo)
        {
            object[] paramArray = new object[3];
            try
            {
                paramArray[0] = pobjModelo.id;
                paramArray[1] = pobjModelo.nombreTipoCalidad.ToUpper();
                paramArray[2] = pobjModelo.idEstatus;
                
                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteNonQuery("usp_ActualizarTipoCalidad", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }

        /// <summary>
        /// Remueve de base de datos el TipoCalidad
        /// </summary>
        /// <param name="idTipoCalidad"></param>
        /// <returns></returns>
        public static string Borrar(string idTipoCalidad)
        {
            object[] paramArray = new object[1];
            try
            {
                paramArray[0] = idTipoCalidad;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteNonQuery("usp_RemueveTipoCalidad", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }
    }
}
