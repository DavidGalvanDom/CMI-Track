///Propósito: Datos Unidad de Medida
///Fecha creación: 01/Febrero/2016
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
    public class UnidadMedidaData
    {
        /// <summary>
        /// Se carga el listado de Unidades de Medida
        /// </summary>
        /// <returns>Lista UnidadMedida</returns>
        public static List<Models.ListaUnidadMedida> CargaUnidadesMedida()
        {
            var listaUnidadesMedida = new List<Models.ListaUnidadMedida>();
            object[] paramArray = new object[2];
            try
            {
                paramArray[0] = null;
                paramArray[1] = null;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarUnidadesMedida", paramArray))
                {
                    while (dataReader.Read())
                    {
                        listaUnidadesMedida.Add(new Models.ListaUnidadMedida()
                        {
                            id = Convert.ToInt32(dataReader["idUnidadMedida"]),
                            nombreCortoUnidadMedida = Convert.ToString(dataReader["nombreCortoUnidadMedida"]),
                            nombreUnidadMedida = Convert.ToString(dataReader["nombreUnidadMedida"]),
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

            return listaUnidadesMedida;
        }

        /// <summary>
        /// Cargar una unidad de medida
        /// </summary>
        /// <returns>Un Proceso</returns>
        public static Models.UnidadMedida CargaUnidadMedida(string idUnidadMedida)
        {
            object[] paramArray = new object[2];
            try
            {
                paramArray[0] = idUnidadMedida == "" ? null : idUnidadMedida;
                paramArray[1] = null;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarUnidadesMedida", paramArray))
                {
                    while (dataReader.Read())
                    {
                        var objUnidadMedida = new Models.UnidadMedida()
                        {
                            id = Convert.ToInt32(dataReader["idUnidadMedida"]),
                            nombreCortoUnidadMedida = Convert.ToString(dataReader["nombreCortoUnidadMedida"]),
                            nombreUnidadMedida = Convert.ToString(dataReader["nombreUnidadMedida"]),
                            idEstatus = Convert.ToInt32(dataReader["idEstatus"])
                        };
                        return objUnidadMedida;
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
        /// Cargar una unidad de medida
        /// </summary>
        /// <returns>Un Proceso</returns>
        public static List<Models.ListaUnidadMedida> CargaUnidadesMedidaActivas()
        {
            var listaUnidadesMedida = new List<Models.ListaUnidadMedida>();
            object[] paramArray = new object[2];
            try
            {
                paramArray[0] = null;
                paramArray[1] = 1;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarUnidadesMedida", paramArray))
                {
                    while (dataReader.Read())
                    {
                        listaUnidadesMedida.Add(new Models.ListaUnidadMedida()
                        {
                            id = Convert.ToInt32(dataReader["idUnidadMedida"]),
                            nombreCortoUnidadMedida = Convert.ToString(dataReader["nombreCortoUnidadMedida"]),
                            nombreUnidadMedida = Convert.ToString(dataReader["nombreUnidadMedida"]),
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

            return listaUnidadesMedida;
        }


        /// <summary>
        /// Se guarda la informacion de un nuevo Unidad de Medida
        /// </summary>
        /// <param name="pobjModelo">Datos nuevo Unidad de Medida</param>
        /// <returns>value</returns>
        public static string Guardar(Models.UnidadMedida pobjModelo)
        {
            object[] paramArray = new object[3];
            try
            {
                paramArray[0] = pobjModelo.nombreCortoUnidadMedida.ToUpper();
                paramArray[1] = pobjModelo.nombreUnidadMedida.ToUpper();
                paramArray[2] = pobjModelo.usuarioCreacion;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteScalar("usp_InsertarUnidadMedida", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }

        /// <summary>
        /// Se actualiza la informacion del Unidad de Medida
        /// </summary>
        /// <param name="pobjModelo">Datos del unidad de medida</param>
        /// <returns>value</returns>
        public static string Actualiza(Models.UnidadMedida pobjModelo)
        {
            object[] paramArray = new object[4];
            try
            {
                paramArray[0] = pobjModelo.id;
                paramArray[1] = pobjModelo.nombreCortoUnidadMedida.ToUpper();
                paramArray[2] = pobjModelo.nombreUnidadMedida.ToUpper();
                paramArray[3] = pobjModelo.idEstatus;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteNonQuery("usp_ActualizarUnidadMedida", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }

        /// <summary>
        /// Remueve de base de datos el Unidad Medida
        /// </summary>
        /// <param name="idUnidadMedida"></param>
        /// <returns></returns>
        public static string Borrar(string idUnidadMedida)
        {
            object[] paramArray = new object[1];
            try
            {
                paramArray[0] = idUnidadMedida;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteNonQuery("usp_RemueveUnidadMedida", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }
    }
}
