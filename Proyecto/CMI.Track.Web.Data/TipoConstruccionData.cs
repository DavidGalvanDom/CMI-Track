///Propósito: Datos de tipos de construccion
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
    public class TipoConstruccionData
    {
        /// <summary>
        /// Se carga el listado de tipos de construccion
        /// </summary>
        /// <returns>Lista tipos de construccion</returns>
        public static List<Models.ListaTipoConstruccion> CargaTiposConstruccion()
        {
            var listaTiposConstruccion = new List<Models.ListaTipoConstruccion>();
            object[] paramArray = new object[2];
            try
            {
                paramArray[0] = null;
                paramArray[1] = null;
                
                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarTiposConstruccion", paramArray))
                {
                    while (dataReader.Read())
                    {
                        listaTiposConstruccion.Add(new Models.ListaTipoConstruccion()
                        {
                            id = Convert.ToInt32(dataReader["idTipoConstruccion"]),
                            NombreTipoConstruccion = Convert.ToString(dataReader["nombreTipoConstruccion"]),
                            Estatus = Convert.ToString(dataReader["nombreEstatus"]),
                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }

            return listaTiposConstruccion;
        }

        /// <summary>
        /// Se carga el listado de tipos de construccion
        /// </summary>
        /// <returns>Lista tipos de construccion</returns>
        public static List<Models.ListaTipoConstruccion> CargaTiposConstruccionActivos()
        {
            var listaTiposConstruccion = new List<Models.ListaTipoConstruccion>();
            object[] paramArray = new object[2];
            try
            {
                paramArray[0] = null;
                paramArray[1] = 1;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarTiposConstruccion", paramArray))
                {
                    while (dataReader.Read())
                    {
                        listaTiposConstruccion.Add(new Models.ListaTipoConstruccion()
                        {
                            id = Convert.ToInt32(dataReader["idTipoConstruccion"]),
                            NombreTipoConstruccion = Convert.ToString(dataReader["nombreTipoConstruccion"]),
                            Estatus = Convert.ToString(dataReader["nombreEstatus"]),
                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }

            return listaTiposConstruccion;
        }


        /// <summary>
        /// Se carga el listado de tipos de construccion
        /// </summary>
        /// <returns>Lista Tipos de construccion</returns>
        public static Models.TipoConstruccion CargaTipoConstruccion(string idTipoConstruccion)
        {
            object[] paramArray = new object[2];
            try
            {
                paramArray[0] = idTipoConstruccion == "" ? null : idTipoConstruccion;
                paramArray[1] = null;
                
                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarTiposConstruccion", paramArray))
                {
                    while (dataReader.Read())
                    {
                        var objTipoConstruccion = new Models.TipoConstruccion()
                        {
                            id = Convert.ToInt32(dataReader["idTipoConstruccion"]),
                            NombreTipoConstruccion = Convert.ToString(dataReader["nombreTipoConstruccion"]),
                            Estatus = Convert.ToString(dataReader["nombreEstatus"]),                           
                        };

                        return objTipoConstruccion;
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
        /// Se guarda la informacion de un nuevo tipo de construccion
        /// </summary>
        /// <param name="pobjModelo">Datos nuevo tipo de construccion</param>
        /// <returns>value</returns>
        public static string Guardar(Models.TipoConstruccion pobjModelo)
        {
            object[] paramArray = new object[2];
            try
            {             
                paramArray[0] = pobjModelo.NombreTipoConstruccion.ToUpper();
                paramArray[1] = pobjModelo.usuarioCreacion;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteScalar("usp_InsertarTipoConstruccion", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }

        /// <summary>
        /// Se actuliza la informacion del tipo de construccion
        /// </summary>
        /// <param name="pobjModelo">Datos del tipo de construccion</param>
        /// <returns>value</returns>
        public static string Actualiza(Models.TipoConstruccion pobjModelo)
        {
            object[] paramArray = new object[3];
            try
            {
                paramArray[0] = pobjModelo.id;
                paramArray[1] = pobjModelo.Estatus;
                paramArray[2] = pobjModelo.NombreTipoConstruccion.ToUpper();             

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteNonQuery("usp_ActualizarTipoConstruccion", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }

        /// <summary>
        /// Remueve de base de datos el tipo de construccion 
        /// </summary>
        /// <param name="idTipoCOnstruccion"></param>
        /// <returns></returns>
        public static string Borrar(string idTipoConstruccion)
        {
            object[] paramArray = new object[1];
            try
            {
                paramArray[0] = idTipoConstruccion;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteNonQuery("usp_RemueveTipoConstruccion", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }

       
    }
}
