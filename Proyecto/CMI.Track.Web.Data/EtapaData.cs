///Propósito: Acceso a base de datos Etapas
///Fecha creación: 18/Febrero/2016
///Creador: David Galvan
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
    public  class EtapaData
    {

        /// <summary>
        /// Se carga el listado de Etapas
        /// </summary>
        /// <param name="idProyecto"></param>
        /// <param name="revision"></param>
        /// <param name="idEstatus"></param>
        /// <returns>Lista de Etapas</returns>
        public static List<Models.ListaEtapas> CargaEtapas(int idProyecto, string revision,
                                                            int? idEstatus)
        {
            var lstEtapas = new List<Models.ListaEtapas>();
            object[] paramArray = new object[4];
            try
            {
                paramArray[0] = idProyecto;
                paramArray[1] = revision;
                paramArray[2] = null;
                paramArray[3] = idEstatus;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarEtapas", paramArray))
                {
                    while (dataReader.Read())
                    {
                        lstEtapas.Add(new Models.ListaEtapas()
                        {
                            id = Convert.ToInt32(dataReader["idEtapa"]),
                            claveEtapa = Convert.ToString(dataReader["claveEtapa"]),   
                            nombreEtapa = Convert.ToString(dataReader["nombreEtapa"]),                            
                            nombreEstatus = Convert.ToString(dataReader["nombreEstatus"]),
                            fechaFin = Convert.ToString(dataReader["fechaFinEtapa"]),
                            fechaInicio = Convert.ToString(dataReader["fechaInicioEtapa"])
                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
            return lstEtapas;
        }

        /// <summary>
        /// Se carga el listado de Etapas
        /// </summary>
        /// <param name="idProyecto"></param>        
        /// <returns>Etapa</returns>
        public static Models.Etapa CargaEtapa(int idEtapa)
        {
            Etapa objEtapa = new Models.Etapa();
            object[] paramArray = new object[4];
            try
            {
                paramArray[0] = null;
                paramArray[1] = null;
                paramArray[2] = idEtapa;
                paramArray[3] = null;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarEtapas", paramArray))
                {
                    while (dataReader.Read())
                    {
                        objEtapa = new Models.Etapa()
                        {
                            id = Convert.ToInt32(dataReader["idEtapa"]),
                            claveEtapa = Convert.ToString(dataReader["claveEtapa"]),   
                            nombreEtapa = Convert.ToString(dataReader["nombreEtapa"]),                           
                            fechaFin = Convert.ToString(dataReader["fechaFinEtapa"]),
                            fechaInicio = Convert.ToString(dataReader["fechaInicioEtapa"]),
                            infoGeneral = Convert.ToString(dataReader["infGeneralEtapa"]),
                            idProyecto = Convert.ToInt32(dataReader["idProyecto"]),
                            revisionProyecto = Convert.ToString(dataReader["revisionProyecto"]),
                            fechaCreacion = Convert.ToString(dataReader["fechaCreacion"]),
                            estatusEtapa = Convert.ToInt32(dataReader["estatusEtapa"])
                        };                        
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }

            return objEtapa;
        }

        /// <summary>
        /// Se guarda la informacion de una nueva Etapa
        /// </summary>
        /// <param name="pobjModelo">Datos de la nueva Etapa</param>
        /// <returns>value</returns>
        public static string Guardar(Models.Etapa pobjModelo)
        {
            object[] paramArray = new object[9];
            try
            {
                paramArray[0] = pobjModelo.estatusEtapa;
                paramArray[1] = pobjModelo.nombreEtapa.ToUpper();
                paramArray[2] = pobjModelo.fechaInicio.ToUpper();
                paramArray[3] = pobjModelo.fechaFin.ToUpper();
                paramArray[4] = pobjModelo.idProyecto;
                paramArray[5] = pobjModelo.revisionProyecto.ToUpper();                
                paramArray[6] = pobjModelo.infoGeneral.ToUpper();
                paramArray[7] = pobjModelo.claveEtapa.ToUpper();
                paramArray[8] = pobjModelo.usuarioCreacion;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteScalar("usp_InsertarEtapa", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }
        
        /// <summary>
        /// Se Actualiza la informacion de una Etapa
        /// </summary>
        /// <param name="pobjModelo">Datos de la Etapa</param>
        /// <returns>value</returns>
        public static string Actualizar(Models.Etapa pobjModelo)
        {
            object[] paramArray = new object[7];
            try
            {
                paramArray[0] = pobjModelo.estatusEtapa;
                paramArray[1] = pobjModelo.nombreEtapa.ToUpper();
                paramArray[2] = pobjModelo.fechaInicio.ToUpper();
                paramArray[3] = pobjModelo.fechaFin.ToUpper();                
                paramArray[4] = pobjModelo.infoGeneral.ToUpper();
                paramArray[5] = pobjModelo.claveEtapa.ToUpper();
                paramArray[6] = pobjModelo.id;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteNonQuery("usp_ActualizarEtapa", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }

        /// <summary>
        /// Se borra de la base de datos el proyecto
        /// </summary>
        /// <param name="idEtapa"></param>
        /// <returns></returns>
        public static string Borrar(int idEtapa)
        {
            object[] paramArray = new object[1];
            try
            {
                paramArray[0] = idEtapa;
                
                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteNonQuery("usp_RemueveEtapa", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }

    }
}
