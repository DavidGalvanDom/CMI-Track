///Propósito: Acceso a base de datos Proyecto
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
    public class ProyectoData
    {

        /// <summary>
        /// Se carga el detalle del proyecto 
        /// </summary>
        /// <param name="idProyecto"></param>
        /// <param name="revision"></param>
        /// <returns></returns>
        public static Proyecto CargaProyecto (int idProyecto, string revision)
        {
            Proyecto proyecto = new Proyecto();
            object[] paramArray = new object[3];

            try
            {
                paramArray[0] = idProyecto;
                paramArray[1] = revision;
                paramArray[2] = null;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarProyectos", paramArray))
                {
                    while (dataReader.Read())
                    {
                       proyecto = new Proyecto()
                        {                           
                            id = Convert.ToInt32(dataReader["idProyecto"]),
                            nombreProyecto = Convert.ToString(dataReader["nombreProyecto"]),
                            revisionProyecto = Convert.ToString(dataReader["revisionProyecto"]),
                            codigoProyecto = Convert.ToString(dataReader["codigoProyecto"]),
                            idEstatus = Convert.ToInt32(dataReader["idEstatus"]),
                            fechaFin = Convert.ToString(dataReader["fechaFinProyecto"]),
                            fechaInicio = Convert.ToString(dataReader["fechaInicioProyecto"]),
                            estatusProyecto = Convert.ToInt32(dataReader["estatusProyecto"]),
                            idCategoria = Convert.ToInt32(dataReader["idCategoria"]),
                            idCliente = Convert.ToInt32(dataReader["idCliente"]),
                            archivoPlanoProyecto = Convert.ToString(dataReader["archivoPlanoProyecto"]),                            
                            infoGeneral = Convert.ToString(dataReader["infGeneralProyecto"]),
                            contactoCliente = Convert.ToString(dataReader["contactoCliente"]),
                            direccionCliente = Convert.ToString(dataReader["direccionCliente"]),
                            nombreCliente = Convert.ToString(dataReader["nombreCliente"]),
                            fechaCreacion = Convert.ToString(dataReader["fechaCreacion"]),
                            fechaRevision = Convert.ToString(dataReader["fechaRevision"])
                        };

                       if (proyecto.archivoPlanoProyecto != "")
                       {
                           proyecto.nombreArchivo = proyecto.archivoPlanoProyecto.Substring(33, proyecto.archivoPlanoProyecto.Length - 33);
                       }
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }

            return proyecto;
        }

        /// <summary>
        /// Se carga el listado de Proyectos
        /// </summary>
        /// <returns>Lista Usuarios</returns>
        public static List<Models.ListaProyectos> CargaProyectos(int? idEstatus)
        {
            var lstProyectos = new List<Models.ListaProyectos>();
            object[] paramArray = new object[3];
            try
            {
                paramArray[0] = null;
                paramArray[1] = null;
                paramArray[2] = idEstatus;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarProyectos", paramArray))
                {
                    while (dataReader.Read())
                    {
                        lstProyectos.Add(new Models.ListaProyectos()
                        {
                            id = dataReader["idProyecto"].ToString() + dataReader["revisionProyecto"].ToString(),
                            idProyecto = Convert.ToInt32(dataReader["idProyecto"]),
                            NombreProyecto = Convert.ToString(dataReader["nombreProyecto"]),
                            Revision = Convert.ToString(dataReader["revisionProyecto"]),
                            CodigoProyecto = Convert.ToString(dataReader["codigoProyecto"]),
                            nombreEstatus = Convert.ToString(dataReader["nombreEstatus"]),
                            FechaFin = Convert.ToString(dataReader["fechaFinProyecto"]),
                            FechaInicio = Convert.ToString(dataReader["fechaInicioProyecto"])
                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }

            return lstProyectos;
        }

        /// <summary>
        /// Se guarda la informacion de un nuevo Proyecto
        /// </summary>
        /// <param name="pobjModelo">Datos nuevo Proyecto</param>
        /// <returns>value</returns>
        public static string Guardar(Models.Proyecto pobjModelo)
        {
            object[] paramArray = new object[13];
            try
            {
                paramArray[0] = pobjModelo.idEstatus;
                paramArray[1] = pobjModelo.nombreProyecto.ToUpper();
                paramArray[2] = pobjModelo.fechaInicio.ToUpper();
                paramArray[3] = pobjModelo.fechaFin.ToUpper();
                paramArray[4] = pobjModelo.codigoProyecto.ToUpper();
                paramArray[5] = pobjModelo.revisionProyecto.ToUpper();
                paramArray[6] = pobjModelo.fechaRevision.ToUpper();
                paramArray[7] = pobjModelo.idCategoria;
                paramArray[8] = pobjModelo.estatusProyecto;
                paramArray[9] = pobjModelo.idCliente;
                paramArray[10] = pobjModelo.infoGeneral.ToUpper();
                paramArray[11] = pobjModelo.archivoPlanoProyecto;                
                paramArray[12] = pobjModelo.usuarioCreacion;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteScalar("usp_InsertarProyecto", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }

        /// <summary>
        /// Se actualiza la informacion del proyecto
        /// </summary>
        /// <param name="pobjModelo">Datos nuevo usurio</param>
        /// <returns>value</returns>
        public static string Actualiza(Models.Proyecto pobjModelo)
        {
            object[] paramArray = new object[14];
            try
            {
                paramArray[0] = pobjModelo.idEstatus;
                paramArray[1] = pobjModelo.nombreProyecto.ToUpper();
                paramArray[2] = pobjModelo.fechaInicio.ToUpper();
                paramArray[3] = pobjModelo.fechaFin.ToUpper();
                paramArray[4] = pobjModelo.codigoProyecto.ToUpper();
                paramArray[5] = pobjModelo.revisionProyecto.ToUpper();
                paramArray[6] = pobjModelo.fechaRevision.ToUpper();
                paramArray[7] = pobjModelo.idCategoria;
                paramArray[8] = pobjModelo.estatusProyecto;
                paramArray[9] = pobjModelo.idCliente;
                paramArray[10] = pobjModelo.infoGeneral.ToUpper();
                paramArray[11] = pobjModelo.archivoPlanoProyecto;
                paramArray[12] = pobjModelo.usuarioCreacion;
                paramArray[13] = pobjModelo.id;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteNonQuery("usp_ActualizarProyecto", paramArray);

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
        /// <param name="idProyecto"></param>
        /// <param name="revision"></param>
        /// <returns></returns>
        public static string Borrar(int idProyecto, string revision)
        {

            object[] paramArray = new object[2];
            try
            {
                paramArray[0] = idProyecto;
                paramArray[1] = revision;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteNonQuery("usp_RemueveProyecto", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }
    }
}
