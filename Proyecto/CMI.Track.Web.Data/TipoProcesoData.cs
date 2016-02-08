///Propósito: Datos de tipos de proceso
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
    public class TipoProcesoData
    {
        /// <summary>
        /// Se carga el listado de tipos de proceso
        /// </summary>
        /// <returns>Lista tipos de proceso</returns>
        public static List<Models.ListaTipoProceso> CargaTiposProceso()
        {
            var listaTiposProceso = new List<Models.ListaTipoProceso>();
            object[] paramArray = new object[2];
            try
            {
                paramArray[0] = null;
                paramArray[1] = null;
                
                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarTiposProceso", paramArray))
                {
                    while (dataReader.Read())
                    {
                        listaTiposProceso.Add(new Models.ListaTipoProceso()
                        {
                            id = Convert.ToInt32(dataReader["idTipoProceso"]),
                            NombreTipoProceso = Convert.ToString(dataReader["nombreTipoProceso"]),
                            Estatus = Convert.ToString(dataReader["nombreEstatus"]),
                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }

            return listaTiposProceso;
        }

        /// <summary>
        /// Se carga el listado de tipos de proceso
        /// </summary>
        /// <returns>Lista tipos de proceso</returns>
        public static List<Models.ListaTipoProceso> CargaTiposProcesoActivos()
        {
            var listaTiposProceso = new List<Models.ListaTipoProceso>();
            object[] paramArray = new object[2];
            try
            {
                paramArray[0] = null;
                paramArray[1] = 1;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarTiposProceso", paramArray))
                {
                    while (dataReader.Read())
                    {
                        listaTiposProceso.Add(new Models.ListaTipoProceso()
                        {
                            id = Convert.ToInt32(dataReader["idTipoProceso"]),
                            NombreTipoProceso = Convert.ToString(dataReader["nombreTipoProceso"]),
                            Estatus = Convert.ToString(dataReader["nombreEstatus"]),
                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }

            return listaTiposProceso;
        }


        /// <summary>
        /// Se carga el listado de tipos de proceso
        /// </summary>
        /// <returns>Lista Tipos de proceso</returns>
        public static Models.TipoProceso CargaTipoProceso(string idTipoProceso)
        {
            object[] paramArray = new object[2];
            try
            {
                paramArray[0] = idTipoProceso == "" ? null : idTipoProceso;
                paramArray[1] = null;
                
                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarTiposProceso", paramArray))
                {
                    while (dataReader.Read())
                    {
                        var objTipoProceso = new Models.TipoProceso()
                        {
                            id = Convert.ToInt32(dataReader["idTipoProceso"]),
                            NombreTipoProceso = Convert.ToString(dataReader["nombreTipoProceso"]),
                            Estatus = Convert.ToString(dataReader["nombreEstatus"]),                           
                        };

                        return objTipoProceso;
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
        /// Se guarda la informacion de un nuevo tipo de proceso
        /// </summary>
        /// <param name="pobjModelo">Datos nuevo tipo de proceso</param>
        /// <returns>value</returns>
        public static string Guardar(Models.TipoProceso pobjModelo)
        {
            object[] paramArray = new object[2];
            try
            {             
                paramArray[0] = pobjModelo.NombreTipoProceso.ToUpper();
                paramArray[1] = pobjModelo.usuarioCreacion;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteScalar("usp_InsertarTipoProceso", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }

        /// <summary>
        /// Se actuliza la informacion del tipo de proceso
        /// </summary>
        /// <param name="pobjModelo">Datos del tipo de proceso</param>
        /// <returns>value</returns>
        public static string Actualiza(Models.TipoProceso pobjModelo)
        {
            object[] paramArray = new object[3];
            try
            {
                paramArray[0] = pobjModelo.id;
                paramArray[1] = pobjModelo.Estatus;
                paramArray[2] = pobjModelo.NombreTipoProceso.ToUpper();             

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteNonQuery("usp_ActualizarTipoProceso", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }

        /// <summary>
        /// Remueve de base de datos el tipo de proceso 
        /// </summary>
        /// <param name="idTipoProceso"></param>
        /// <returns></returns>
        public static string Borrar(string idTipoProceso)
        {
            object[] paramArray = new object[1];
            try
            {
                paramArray[0] = idTipoProceso;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteNonQuery("usp_RemueveTipoProceso", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }

       
    }
}
