///Propósito: Datos Almacenes
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
    public class AlmacenData
    {
        /// <summary>
        /// Se carga el listado de Almacenes
        /// </summary>
        /// <returns>Lista Almacen</returns>
        public static List<Models.ListaAlmacen> CargaAlmacenes()
        {
            var listaAlmacenes = new List<Models.ListaAlmacen>();
            object[] paramArray = new object[2];
            try
            {
                paramArray[0] = null;
                paramArray[1] = null;
                
                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarAlmacenes", paramArray))
                {
                    while (dataReader.Read())
                    {
                        listaAlmacenes.Add(new Models.ListaAlmacen()
                        {
                            id = Convert.ToInt32(dataReader["idAlmacen"]),
                            nombreAlmacen = Convert.ToString(dataReader["nombreAlmacen"]),
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

            return listaAlmacenes;
        }
        
        /// <summary>
        /// Cargar un Almacen
        /// </summary>
        /// <returns>Un Almacen</returns>
        public static Models.Almacen CargaAlmacen(string idAlmacen)
        {
            object[] paramArray = new object[2];
            try
            {
                paramArray[0] = idAlmacen == "" ? null : idAlmacen;
                paramArray[1] = null;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarAlmacenes", paramArray))
                {
                    while (dataReader.Read())
                    {
                        var objAlmacen = new Models.Almacen()
                        {
                            id = Convert.ToInt32(dataReader["idAlmacen"]),
                            nombreAlmacen = Convert.ToString(dataReader["nombreAlmacen"]),
                            idEstatus = Convert.ToInt32(dataReader["idEstatus"])
                        };
                        return objAlmacen;
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
        /// Se carga el listado de Almacenes Activos
        /// </summary>
        /// <returns>Lista Almacen</returns>
        public static List<Models.ListaAlmacen> CargaAlmacenesActivos()
        {
            var listaAlmacenes = new List<Models.ListaAlmacen>();
            object[] paramArray = new object[2];
            try
            {
                paramArray[0] = null;
                paramArray[1] = 1;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarAlmacenes", paramArray))
                {
                    while (dataReader.Read())
                    {
                        listaAlmacenes.Add(new Models.ListaAlmacen()
                        {
                            id = Convert.ToInt32(dataReader["idAlmacen"]),
                            nombreAlmacen = Convert.ToString(dataReader["nombreAlmacen"]),
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

            return listaAlmacenes;
        }

        /// <summary>
        /// Se guarda la informacion de un nuevo Almacen
        /// </summary>
        /// <param name="pobjModelo">Datos nuevo Almacen</param>
        /// <returns>value</returns>
        public static string Guardar(Models.Almacen pobjModelo)
        {
            object[] paramArray = new object[2];
            try
            {
                paramArray[0] = pobjModelo.nombreAlmacen.ToUpper();
                paramArray[1] = pobjModelo.usuarioCreacion;
                                
                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteScalar("usp_InsertarAlmacen", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }

        /// <summary>
        /// Se actualiza la informacion del Almacen
        /// </summary>
        /// <param name="pobjModelo">Datos del Almacen</param>
        /// <returns>value</returns>
        public static string Actualiza(Models.Almacen pobjModelo)
        {
            object[] paramArray = new object[3];
            try
            {
                paramArray[0] = pobjModelo.id;
                paramArray[1] = pobjModelo.nombreAlmacen.ToUpper();
                paramArray[2] = pobjModelo.idEstatus;
                
                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteNonQuery("usp_ActualizarAlmacen", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }

        /// <summary>
        /// Remueve de base de datos el Almacen
        /// </summary>
        /// <param name="idAlmacen"></param>
        /// <returns></returns>
        public static string Borrar(string idAlmacen)
        {
            object[] paramArray = new object[1];
            try
            {
                paramArray[0] = idAlmacen;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteNonQuery("usp_RemueveAlmacen", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }
    }
}
