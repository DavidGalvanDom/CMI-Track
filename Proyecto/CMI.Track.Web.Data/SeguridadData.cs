///Propósito: Acceso a datos del modulo de Seguridad
///Fecha creación: 01/Febrero/2016
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
    public class SeguridadData
    {
        /// <summary>
        /// Se actulizan los permisos del usuario
        /// </summary>
        /// <param name="lstModulos"></param>
        /// <param name="idUsuario"></param>
        /// <param name="usuarioCreacion"></param>
        public static void GuardaSeguridad(List<ListaModulo> lstModulos, int idUsuario,
                                            int usuarioCreacion)
        {
            object[] paramArray = new object[8];
            try
            {
                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                foreach (var modulo in lstModulos)
                {
                    paramArray[0] = idUsuario;
                    paramArray[1] = modulo.id;
                    paramArray[2] = modulo.lecturaPermisos;
                    paramArray[3] = modulo.escrituraPermisos;
                    paramArray[4] = modulo.borradoPermisos;
                    paramArray[5] = modulo.clonadoPermisos;
                    paramArray[6] = 1;
                    paramArray[7] = usuarioCreacion;

                     db.ExecuteNonQuery("usp_RegistraPermisos", paramArray);
                }
                
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }

        }

        /// <summary>
        /// Se cargan los modulos a los que tiene acceso el usuario 
        /// </summary>
        /// <param name="idUsuario"></param>
        /// <returns></returns>
        public static List<MenuGrupo> CargaUsuarioPermisos(int idUsuario)
        {
            var listaMenuGrupo = new List<Models.MenuGrupo>();
            MenuGrupo grupo = null;

            try
            {
                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarUsuarioPermisos", idUsuario))
                {
                    while (dataReader.Read())
                    {
                        grupo = listaMenuGrupo.Find(menuGrupo => menuGrupo.idMenuGrupo == Convert.ToInt32(dataReader["idMenuGrupo"]));

                        if (grupo == null)
                        {
                            grupo = new MenuGrupo()
                            {
                                idMenuGrupo = Convert.ToInt32(dataReader["idMenuGrupo"]),
                                nombreGrupo = Convert.ToString(dataReader["nombreMenuGrupo"]),
                                iconGrupo = Convert.ToString(dataReader["iconGrupo"]),
                            };
                            grupo.lstPermisos = new List<Permisos>();
                            listaMenuGrupo.Add(grupo);
                        }
                        
                        grupo.lstPermisos.Add(new Models.Permisos()
                            {
                                idModulo = Convert.ToInt32(dataReader["idModulo"]),                            
                                borradoPermisos = dataReader["borradoPermiso"] == DBNull.Value ? 0 : Convert.ToInt32(dataReader["borradoPermiso"]),
                                lecturaPermisos = dataReader["lecturaPermiso"] == DBNull.Value ? 0 : Convert.ToInt32(dataReader["lecturaPermiso"]),
                                clonadoPermisos = dataReader["clonadoPermiso"] == DBNull.Value ? 0 : Convert.ToInt32(dataReader["clonadoPermiso"]),
                                escrituraPermisos = dataReader["escrituraPermiso"] == DBNull.Value ? 0 : Convert.ToInt32(dataReader["escrituraPermiso"]),
                                urlModulo = Convert.ToString(dataReader["urlModulo"]),
                                nombreModulo = Convert.ToString(dataReader["nombreModulo"])
                            });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }

            
            
            return listaMenuGrupo;
        }

        /// <summary>
        /// Se carga el listado de usuarios
        /// </summary>
        /// <returns>Lista Usuarios</returns>
        public static List<Models.ListaModulo> CargarModulos(int idUsuario)
        {
            var listaModulos = new List<Models.ListaModulo>();
            
            try
            {
                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarModulosSeguridad", idUsuario))
                {
                    while (dataReader.Read())
                    {
                        listaModulos.Add(new Models.ListaModulo()
                        {
                            id = Convert.ToInt32(dataReader["idModulo"]),
                            nombreModulo = Convert.ToString(dataReader["nombreModulo"]),
                            borradoPermisos = dataReader["borradoPermiso"]  == DBNull.Value ? 0 : Convert.ToInt32(dataReader["borradoPermiso"]),
                            lecturaPermisos = dataReader["lecturaPermiso"] == DBNull.Value ? 0 : Convert.ToInt32(dataReader["lecturaPermiso"]),
                            clonadoPermisos = dataReader["clonadoPermiso"] == DBNull.Value ? 0 : Convert.ToInt32(dataReader["clonadoPermiso"]),
                            escrituraPermisos = dataReader["escrituraPermiso"] == DBNull.Value ? 0 : Convert.ToInt32(dataReader["escrituraPermiso"]),
                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }

            return listaModulos;
        }
    }
}
