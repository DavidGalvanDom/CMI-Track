///Propósito: Datos de Origen Requisicion
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
    public class OrigenRequisicionData
    {
        /// <summary>
        /// Se carga el listado de Origen Requisicion
        /// </summary>
        /// <returns>Lista categorias</returns>
        public static List<Models.ListaOrigenRequisicion> CargaOrigenesRequisicion()
        {
            var listaOrigenesRequisicion = new List<Models.ListaOrigenRequisicion>();
            object[] paramArray = new object[2];
            try
            {
                paramArray[0] = null;
                paramArray[1] = null;
                
                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarOrigenReq", paramArray))
                {
                    while (dataReader.Read())
                    {
                        listaOrigenesRequisicion.Add(new Models.ListaOrigenRequisicion()
                        {
                            id = Convert.ToInt32(dataReader["idOrigenRequisicion"]),
                            NombreOrigenRequisicion = Convert.ToString(dataReader["nombreOrigenRequisicion"]),
                            Estatus = Convert.ToString(dataReader["nombreEstatus"]),
                            
                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }

            return listaOrigenesRequisicion;
        }

        /// <summary>
        /// Se carga el listado de origenes de requisicion
        /// </summary>
        /// <returns>Lista origenes requisicion</returns>
        public static List<Models.ListaOrigenRequisicion> CargaOrigenesReqActivas()
        {
            var listaOrigenesRequisicion = new List<Models.ListaOrigenRequisicion>();
            object[] paramArray = new object[2];
            try
            {
                paramArray[0] = null;
                paramArray[1] = 1;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarOrigenReq", paramArray))
                {
                    while (dataReader.Read())
                    {
                        listaOrigenesRequisicion.Add(new Models.ListaOrigenRequisicion()
                        {
                            id = Convert.ToInt32(dataReader["idOrigenRequisicion"]),
                            NombreOrigenRequisicion = Convert.ToString(dataReader["nombreOrigenRequisicion"]),
                            Estatus = Convert.ToString(dataReader["nombreEstatus"]),

                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }

            return listaOrigenesRequisicion;
        }


        /// <summary>
        /// Se carga el listado de origenes
        /// </summary>
        /// <returns>Lista Origenes requisicion</returns>
        public static Models.OrigenRequisicion CargaOrigenRequisicion(string idOrigenRequisicion)
        {
            object[] paramArray = new object[2];
            try
            {
                paramArray[0] = idOrigenRequisicion == "" ? null : idOrigenRequisicion;
                paramArray[1] = null;
                            
                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarOrigenReq", paramArray))
                {
                    while (dataReader.Read())
                    {
                        var objOrigenRequisicion = new Models.OrigenRequisicion()
                        {
                            id = Convert.ToInt32(dataReader["idOrigenRequisicion"]),
                            NombreOrigenRequisicion = Convert.ToString(dataReader["nombreOrigenRequisicion"]),
                            Estatus = Convert.ToString(dataReader["nombreEstatus"]),                          
                        };

                        return objOrigenRequisicion;
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
        /// Se guarda la informacion de una nueva origen de req
        /// </summary>
        /// <param name="pobjModelo">Datos nueva Origen req</param>
        /// <returns>value</returns>
        public static string Guardar(Models.OrigenRequisicion pobjModelo)
        {
            object[] paramArray = new object[2];
            try
            {             
                paramArray[0] = pobjModelo.NombreOrigenRequisicion.ToUpper();
                paramArray[1] = pobjModelo.usuarioCreacion;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteScalar("usp_InsertarOrigenReq", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }

        /// <summary>
        /// Se actuliza la informacion del origen de la req
        /// </summary>
        /// <param name="pobjModelo">Datos del Origen de la Req</param>
        /// <returns>value</returns>
        public static string Actualiza(Models.OrigenRequisicion pobjModelo)
        {
            object[] paramArray = new object[3];
            try
            {
                paramArray[0] = pobjModelo.id;
                paramArray[1] = pobjModelo.Estatus;
                paramArray[2] = pobjModelo.NombreOrigenRequisicion.ToUpper();             

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteNonQuery("usp_ActualizarOrigenReq", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }

        /// <summary>
        /// Remueve de base de datos el origen de la req
        /// </summary>
        /// <param name="idOrigenRequisicion"></param>
        /// <returns></returns>
        public static string Borrar(string idOrigenRequisicion)
        {
            object[] paramArray = new object[1];
            try
            {
                paramArray[0] = idOrigenRequisicion;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteNonQuery("usp_RemueveOrigenReq", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }

       
    }
}
