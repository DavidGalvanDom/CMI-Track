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
