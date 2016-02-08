///Propósito: Datos Grupos
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
    public class GrupoData
    {
        /// <summary>
        /// Se carga el listado de Grupos
        /// </summary>
        /// <returns>Lista Grupo</returns>
        public static List<Models.ListaGrupo> CargaGrupos()
        {
            var listaGrupos = new List<Models.ListaGrupo>();
            object[] paramArray = new object[2];
            try
            {
                paramArray[0] = null;
                paramArray[1] = null;
                
                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarGrupos", paramArray))
                {
                    while (dataReader.Read())
                    {
                        listaGrupos.Add(new Models.ListaGrupo()
                        {
                            id = Convert.ToInt32(dataReader["idGrupo"]),
                            nombreGrupo = Convert.ToString(dataReader["nombreGrupo"]),
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

            return listaGrupos;
        }
        
        /// <summary>
        /// Cargar un Grupo
        /// </summary>
        /// <returns>Un Grupo</returns>
        public static Models.Grupo CargaGrupo(string idGrupo)
        {
            object[] paramArray = new object[2];
            try
            {
                paramArray[0] = idGrupo == "" ? null : idGrupo;
                paramArray[1] = null;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarGrupos", paramArray))
                {
                    while (dataReader.Read())
                    {
                        var objGrupo = new Models.Grupo()
                        {
                            id = Convert.ToInt32(dataReader["idGrupo"]),
                            nombreGrupo = Convert.ToString(dataReader["nombreGrupo"]),
                            idEstatus = Convert.ToInt32(dataReader["idEstatus"])
                        };
                        return objGrupo;
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
        /// Se carga el listado de Grupos Activos
        /// </summary>
        /// <returns>Lista Grupo</returns>
        public static List<Models.ListaGrupo> CargaGruposActivos()
        {
            var listaGrupos = new List<Models.ListaGrupo>();
            object[] paramArray = new object[2];
            try
            {
                paramArray[0] = null;
                paramArray[1] = 1;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarGrupos", paramArray))
                {
                    while (dataReader.Read())
                    {
                        listaGrupos.Add(new Models.ListaGrupo()
                        {
                            id = Convert.ToInt32(dataReader["idGrupo"]),
                            nombreGrupo = Convert.ToString(dataReader["nombreGrupo"]),
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

            return listaGrupos;
        }

        /// <summary>
        /// Se guarda la informacion de un nuevo Grupo
        /// </summary>
        /// <param name="pobjModelo">Datos nuevo Grupo</param>
        /// <returns>value</returns>
        public static string Guardar(Models.Grupo pobjModelo)
        {
            object[] paramArray = new object[2];
            try
            {
                paramArray[0] = pobjModelo.nombreGrupo.ToUpper();
                paramArray[1] = pobjModelo.usuarioCreacion;
                                
                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteScalar("usp_InsertarGrupo", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }

        /// <summary>
        /// Se actualiza la informacion del Grupo
        /// </summary>
        /// <param name="pobjModelo">Datos del Grupo</param>
        /// <returns>value</returns>
        public static string Actualiza(Models.Grupo pobjModelo)
        {
            object[] paramArray = new object[3];
            try
            {
                paramArray[0] = pobjModelo.id;
                paramArray[1] = pobjModelo.nombreGrupo.ToUpper();
                paramArray[2] = pobjModelo.idEstatus;
                
                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteNonQuery("usp_ActualizarGrupo", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }

        /// <summary>
        /// Remueve de base de datos el Grupo
        /// </summary>
        /// <param name="idGrupo"></param>
        /// <returns></returns>
        public static string Borrar(string idGrupo)
        {
            object[] paramArray = new object[1];
            try
            {
                paramArray[0] = idGrupo;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteNonQuery("usp_RemueveGrupo", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }
    }
}
