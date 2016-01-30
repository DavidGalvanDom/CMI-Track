///Propósito: Autentificación del usuario
///Fecha creación: 28/Enero/2016
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
    public class UsuarioData
    {
        /// <summary>
        /// Se cargan los usuario que esten el la lista de perfiles
        /// </summary>
        /// <param name="plstPerfiles">formato 'DIR','RDE' </param>
        /// <returns></returns>
        public static List<Models.ListaUsuario> CargaUsuarioPerfil(string plstPerfiles)
        {
            var listaUsuarios = new List<Models.ListaUsuario>();
            object[] paramArray = new object[1];
            try
            {
                paramArray[0] = plstPerfiles;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarUsuariosPerfiles", paramArray))
                {
                    while (dataReader.Read())
                    {
                        listaUsuarios.Add(new Models.ListaUsuario()
                        {
                            id = Convert.ToInt32(dataReader["IdUsuario"]),
                            Nombre = Convert.ToString(dataReader["Nombre"]),
                            ApePaterno = Convert.ToString(dataReader["ApePaterno"]),
                            ApeMaterno = Convert.ToString(dataReader["ApeMaterno"]),
                            Perfil = Convert.ToString(dataReader["IdPerfil"]),
                            NombreUsuario = Convert.ToString(dataReader["NombreUsuario"])
                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }

            return listaUsuarios;
        }


        /// <summary>
        /// Se insertan las plazas a el usuario seleccionado
        /// </summary>
        /// <param name="idUsuario"></param>
        /// <param name="lstidPlaza"></param>
        /// <returns></returns>
        public static List<string> GuardarUsuarioPlazas(string idUsuario, List<string> lstidPlaza)
        {
            object[] paramArray = new object[2];
            List<string> lstPlazas = new List<string>();
            try
            {
                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                foreach (string idPlaza in lstidPlaza)
                {

                    paramArray[0] = idUsuario;
                    paramArray[1] = idPlaza;

                    try
                    {
                        var result = db.ExecuteNonQuery("usp_InsertarUsuarioPlaza", paramArray);

                        if (result == -1)
                        {
                            lstPlazas.Add(idPlaza);
                        }

                    }
                    catch (Exception) { }
                }

                return (lstPlazas);
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }


        /// <summary>
        /// Se borran las plazas a el usuario seleccionado
        /// </summary>
        /// <param name="idUsuario"></param>
        /// <param name="lstidPlaza"></param>
        /// <returns></returns>
        public static List<string> RemueveUsuarioPlazas(string idUsuario, List<string> lstidPlaza)
        {
            object[] paramArray = new object[2];
            List<string> lstPlazas = new List<string>();
            try
            {
                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                foreach (string idPlaza in lstidPlaza)
                {

                    paramArray[0] = idUsuario;
                    paramArray[1] = idPlaza;

                    try
                    {
                        var result = db.ExecuteNonQuery("usp_RemueveUsuarioPlaza", paramArray);

                        if (result == -1)
                        {
                            lstPlazas.Add(idPlaza);
                        }

                    }
                    catch (Exception) { }
                }

                return (lstPlazas);
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }


        /// <summary>
        /// Se carga el listado de usuarios
        /// </summary>
        /// <returns>Lista Usuarios</returns>
        public static List<Models.ListaUsuario> CargaUsuarios()
        {
            var listaUsuarios = new List<Models.ListaUsuario>();
            object[] paramArray = new object[1];
            try
            {
                paramArray[0] = null;
                
                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarUsuarios", paramArray))
                {
                    while (dataReader.Read())
                    {
                        listaUsuarios.Add(new Models.ListaUsuario()
                        {
                            id = Convert.ToInt32(dataReader["IdUsuario"]),
                            Nombre = Convert.ToString(dataReader["Nombre"]),
                            ApePaterno = Convert.ToString(dataReader["ApePaterno"]),
                            ApeMaterno = Convert.ToString(dataReader["ApeMaterno"]),
                            Estatus = Convert.ToString(dataReader["idEstatus"]),
                            NombreUsuario = Convert.ToString(dataReader["NombreUsuario"])
                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }

            return listaUsuarios;
        }


        /// <summary>
        /// Se carga el listado de usuarios
        /// </summary>
        /// <returns>Lista Usuarios</returns>
        public static Models.Usuario CargaUsuario(string idUsuario)
        {
            object[] paramArray = new object[1];
            try
            {
                paramArray[0] = idUsuario == "" ? null : idUsuario;
                
                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarUsuarios", paramArray))
                {
                    while (dataReader.Read())
                    {
                        var objUsuario = new Models.Usuario()
                        {
                            id = Convert.ToInt32(dataReader["IdUsuario"]),
                            Nombre = Convert.ToString(dataReader["Nombre"]),
                            ApePaterno = Convert.ToString(dataReader["ApePaterno"]),
                            ApeMaterno = Convert.ToString(dataReader["ApeMaterno"]),
                            Estatus = Convert.ToString(dataReader["IdEstatus"]),                           
                            Contrasena = Convert.ToString(dataReader["Contrasena"]),
                            Correo = Convert.ToString(dataReader["Correo"]),
                            NombreUsuario = Convert.ToString(dataReader["NombreUsuario"])
                        };

                        return objUsuario;
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
        /// Verifica que el usuario tenga permisos para entrar al sistema
        /// </summary>
        /// <param name="idusuario">Nombre del usuario</param>
        /// <returns>contrasena</returns>
        public static Models.Usuario AutentificaUsuario(string pnomusuario, string pstrEstatus)
        {
            try
            {
                Models.Usuario objUsuario = null;
                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_AutentificaUsuario", pnomusuario, pstrEstatus))
                {
                    while (dataReader.Read())
                    {
                        objUsuario = new Models.Usuario()
                        {
                            id = Convert.ToInt32(dataReader["IdUsuario"]),
                            Nombre = Convert.ToString(dataReader["Nombre"]),
                            ApePaterno = Convert.ToString(dataReader["ApePaterno"]),
                            ApeMaterno = Convert.ToString(dataReader["ApeMaterno"]),
                            Contrasena = Convert.ToString(dataReader["Contrasena"]),
                            NombreUsuario = Convert.ToString(dataReader["NombreUsuario"])
                        };
                    }
                }

                return (objUsuario);
            }

            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }

        /// <summary>
        /// Se guarda la informacion de un nuevo Usuario
        /// </summary>
        /// <param name="pobjModelo">Datos nuevo usurio</param>
        /// <returns>value</returns>
        public static string Guardar(Models.Usuario pobjModelo)
        {
            object[] paramArray = new object[6];
            try
            {             
                paramArray[0] = pobjModelo.Correo.ToUpper();
                paramArray[1] = pobjModelo.Nombre.ToUpper();
                paramArray[2] = pobjModelo.ApePaterno.ToUpper();
                paramArray[3] = pobjModelo.ApeMaterno.ToUpper();
                paramArray[4] = pobjModelo.NombreUsuario.ToUpper();
                paramArray[5] = pobjModelo.Contrasena;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteScalar("usp_InsertarUsuario", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }

        /// <summary>
        /// Se actuliza la informacion del Usuario
        /// </summary>
        /// <param name="pobjModelo">Datos del usurio</param>
        /// <returns>value</returns>
        public static string Actualiza(Models.Usuario pobjModelo)
        {
            object[] paramArray = new object[8];
            try
            {
                paramArray[0] = pobjModelo.id;
                paramArray[1] = pobjModelo.Estatus;
                paramArray[2] = pobjModelo.Correo.ToUpper();
                paramArray[3] = pobjModelo.Nombre.ToUpper();
                paramArray[4] = pobjModelo.ApePaterno.ToUpper();
                paramArray[5] = pobjModelo.ApeMaterno.ToUpper();
                paramArray[6] = pobjModelo.NombreUsuario.ToUpper();
                paramArray[7] = pobjModelo.Contrasena;                

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteNonQuery("usp_ActualizarUsuario", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }

        /// <summary>
        /// Remueve de base de datos elusuario 
        /// </summary>
        /// <param name="idUser"></param>
        /// <returns></returns>
        public static string Borrar(string idUser)
        {
            object[] paramArray = new object[1];
            try
            {
                paramArray[0] = idUser;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteNonQuery("usp_RemueveUsuario", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }

        /// <summary>
        /// Se valida si ya existe el nombre de usuario en base de datos.
        /// </summary>
        /// <param name="nomUsuario"></param>
        /// <returns></returns>
        public static bool ValidaNomUsuario(string nomUsuario, int? idUsuario)
        {
            object[] paramArray = new object[2];
            try
            {
                paramArray[0] = nomUsuario;
                paramArray[1] = idUsuario == -1 ? null : idUsuario;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteScalar("usp_BuscaNomUsuario", paramArray);

                if (result != null)
                {
                    return (result.ToString() != "" ? true : false);
                }
                else
                {
                    return (false);
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }

        /// <summary>
        /// Se carga la contraseña del usuario 
        /// </summary>
        /// <param name="idUsuario"></param>
        /// <returns></returns>
        public static string ContrasenaActual(string nomUsuario)
        {
            try
            {
                Models.Usuario objUsuario = null;
                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_AutentificaUsuario", nomUsuario, "ACT"))
                {
                    while (dataReader.Read())
                    {
                        objUsuario = new Models.Usuario()
                        {
                            Contrasena = Convert.ToString(dataReader["Contrasena"])
                        };
                    }
                }

                return (objUsuario != null ? objUsuario.Contrasena : "");
            }

            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }
    }
}
