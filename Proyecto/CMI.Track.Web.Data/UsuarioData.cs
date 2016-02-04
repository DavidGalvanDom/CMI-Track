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
                            id = Convert.ToInt32(dataReader["idUsuario"]),
                            NombreCompleto = string.Format("{0} {1} {2}", Convert.ToString(dataReader["nombreUsuario"]),
                                                                        Convert.ToString(dataReader["apePaternoUsuario"]),
                                                                        Convert.ToString(dataReader["apeMaternoUsuario"])),
                            NombreUsuario = Convert.ToString(dataReader["loginUsuario"]),
                            Correo = Convert.ToString(dataReader["emailUsuario"]),
                            idEstatus = Convert.ToInt32(dataReader["IdEstatus"]),                       
                            fechaCreacion= Convert.ToDateTime(dataReader["fechaCreacion"]).ToShortDateString()
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
                            id = Convert.ToInt32(dataReader["idUsuario"]),
                            Nombre = Convert.ToString(dataReader["nombreUsuario"]),
                            ApePaterno = Convert.ToString(dataReader["apePaternoUsuario"]),
                            ApeMaterno = Convert.ToString(dataReader["apeMaternoUsuario"]),
                            Contrasena = Convert.ToString(dataReader["passwordUsuario"]),
                            NombreUsuario = Convert.ToString(dataReader["loginUsuario"]),
                            Correo = Convert.ToString(dataReader["emailUsuario"]),
                            idEstatus = Convert.ToInt32(dataReader["IdEstatus"]),                            
                            puestoUsuario = Convert.ToString(dataReader["puestoUsuario"]),
                            areaUsuario = Convert.ToString(dataReader["areaUsuario"]),
                            autorizaRequisiciones = Convert.ToInt32(dataReader["autorizaRequisiciones"]) == 1 ? true : false,
                            idDepartamento = dataReader["idDepartamento"] == DBNull.Value ? 0 : Convert.ToInt32(dataReader["idDepartamento"]),
                            idProcesoDestino = dataReader["idProcesoDestino"] == DBNull.Value ? 0 : Convert.ToInt32(dataReader["idProcesoDestino"]),
                            idProcesoOrigen = dataReader["idProcesoOrigen"] == DBNull.Value ? 0 : Convert.ToInt32(dataReader["idProcesoOrigen"]),
                            fechaCreacion = dataReader["fechaCreacion"] == DBNull.Value ? "01/01/1900" : Convert.ToDateTime(dataReader["fechaCreacion"]).ToString("MM/dd/yyyy")
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
        public static Models.Usuario AutentificaUsuario(string pnomusuario, int idEstatus)
        {
            try
            {
                Models.Usuario objUsuario = null;
                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_AutentificaUsuario", pnomusuario, idEstatus))
                {
                    while (dataReader.Read())
                    {
                        objUsuario = new Models.Usuario()
                        {
                            id = Convert.ToInt32(dataReader["idUsuario"]),
                            Nombre = Convert.ToString(dataReader["nombreUsuario"]),
                            ApePaterno = Convert.ToString(dataReader["apePaternoUsuario"]),
                            ApeMaterno = Convert.ToString(dataReader["apeMaternoUsuario"]),
                            Contrasena = Convert.ToString(dataReader["passwordUsuario"]),
                            NombreUsuario = Convert.ToString(dataReader["loginUsuario"])                           
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
            object[] paramArray = new object[14];
            try
            {
                paramArray[0] = pobjModelo.idEstatus;
                paramArray[1] = pobjModelo.Correo.ToUpper();
                paramArray[2] = pobjModelo.Nombre.ToUpper();
                paramArray[3] = pobjModelo.ApePaterno.ToUpper();
                paramArray[4] = pobjModelo.ApeMaterno.ToUpper();
                paramArray[5] = pobjModelo.NombreUsuario.ToUpper();
                paramArray[6] = pobjModelo.Contrasena;
                paramArray[7] = pobjModelo.puestoUsuario.ToUpper();
                paramArray[8] = pobjModelo.areaUsuario.ToUpper();
                paramArray[9] = pobjModelo.idDepartamento;
                paramArray[10] = pobjModelo.autorizaRequisiciones ? 1 : 0;
                paramArray[11] = pobjModelo.idProcesoOrigen == 0 ? null : pobjModelo.idProcesoOrigen;
                paramArray[12] = pobjModelo.idProcesoDestino == 0 ? null : pobjModelo.idProcesoDestino;
                paramArray[13] = pobjModelo.usuarioCreacion ;

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
            object[] paramArray = new object[14];
            try
            {
                paramArray[0] = pobjModelo.id;
                paramArray[1] = pobjModelo.idEstatus;
                paramArray[2] = pobjModelo.Correo.ToUpper();
                paramArray[3] = pobjModelo.Nombre.ToUpper();
                paramArray[4] = pobjModelo.ApePaterno.ToUpper();
                paramArray[5] = pobjModelo.ApeMaterno.ToUpper();
                paramArray[6] = pobjModelo.NombreUsuario.ToUpper();
                paramArray[7] = pobjModelo.Contrasena;                
                paramArray[8] = pobjModelo.puestoUsuario.ToUpper();                
                paramArray[9] = pobjModelo.areaUsuario.ToUpper();         
                paramArray[10] = pobjModelo.idDepartamento;         
                paramArray[11] = pobjModelo.autorizaRequisiciones ? 1:0;
                paramArray[12] = pobjModelo.idProcesoOrigen == 0 ? null : pobjModelo.idProcesoOrigen;
                paramArray[13] = pobjModelo.idProcesoDestino == 0 ? null : pobjModelo.idProcesoDestino;         
                             

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
