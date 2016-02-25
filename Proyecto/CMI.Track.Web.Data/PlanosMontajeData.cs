///Propósito: Acceso a base de datos Planos Montaje
///Fecha creación: 20/Febrero/2016
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
    public class PlanosMontajeData
    {
        /// <summary>
        /// Se carga el listado de Planos Montaje
        /// </summary>
        /// <param name="idEtapa"></param>
        /// <param name="idEstatus"></param>
        /// <returns>Lista de Etapas</returns>
        public static List<Models.ListaPlanosMontaje> CargaPlanosMontaje(int idEtapa,  int? idEstatus)
        {
            var lstPlanosMontaje = new List<Models.ListaPlanosMontaje>();
            object[] paramArray = new object[3];
            try
            {
                paramArray[0] = idEtapa;
                paramArray[1] = null;
                paramArray[2] = idEstatus;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarPlanosMontaje", paramArray))
                {
                    while (dataReader.Read())
                    {
                        lstPlanosMontaje.Add(new Models.ListaPlanosMontaje()
                        {
                            id = Convert.ToInt32(dataReader["idPlanoMontaje"]),
                            nombrePlanoMontaje = Convert.ToString(dataReader["nombrePlanoMontaje"]),
                            nombreEstatus = Convert.ToString(dataReader["nombreEstatus"]),
                            fechaFin = Convert.ToString(dataReader["fechaFinPlanoMontaje"]),
                            fechaInicio = Convert.ToString(dataReader["fechaInicioPlanoMontaje"]),
                            archivoPlanoMontaje = Convert.ToString(dataReader["archivoPlanoMontaje"])
                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
            return lstPlanosMontaje;
        }

        /// <summary>
        /// Se carga el Plano montaje
        /// </summary>
        /// <param name="idEtapa"></param>
        /// <param name="idEstatus"></param>
        /// <returns>Objeto de Plano Montaje</returns>
        public static Models.PlanosMontaje CargaPlanoMontaje(int idPlanoMontaje)
        {
            var objPlanoMontaje = new Models.PlanosMontaje();
            object[] paramArray = new object[3];
            try
            {
                paramArray[0] = null;
                paramArray[1] = idPlanoMontaje;
                paramArray[2] = null;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarPlanosMontaje", paramArray))
                {
                    while (dataReader.Read())
                    {
                        objPlanoMontaje = new Models.PlanosMontaje()
                        {
                            id = Convert.ToInt32(dataReader["idPlanoMontaje"]),
                            nombrePlanoMontaje = Convert.ToString(dataReader["nombrePlanoMontaje"]),
                            idEstatus = Convert.ToInt32(dataReader["idEstatus"]),
                            idEtapa = Convert.ToInt32(dataReader["idEtapa"]),
                            fechaFin = Convert.ToString(dataReader["fechaFinPlanoMontaje"]),
                            fechaInicio = Convert.ToString(dataReader["fechaInicioPlanoMontaje"]),
                            fechaCreacion = Convert.ToString(dataReader["fechaCreacion"]),
                            archivoPlanoMontaje = Convert.ToString(dataReader["archivoPlanoMontaje"]),
                            infGeneralPlanoMontaje = Convert.ToString(dataReader["infGeneralPlanoMontaje"]),
                            codigoPlanoMontaje = Convert.ToString(dataReader["codigoPlanoMontaje"])
                        };

                        if (objPlanoMontaje.archivoPlanoMontaje != "")
                        {
                            objPlanoMontaje.nombreArchivo = objPlanoMontaje.archivoPlanoMontaje.Substring(33, objPlanoMontaje.archivoPlanoMontaje.Length - 33);
                        }
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
            return objPlanoMontaje;
        }

        /// <summary>
        /// Se guarda la informacion de un nuevo Plano montaje
        /// </summary>
        /// <param name="pobjModelo">Datos nuevo Plano montaje</param>
        /// <returns>value</returns>
        public static string Guardar(Models.PlanosMontaje pobjModelo)
        {
            object[] paramArray = new object[9];
            try
            {
                paramArray[0] = pobjModelo.idEstatus;
                paramArray[1] = pobjModelo.nombrePlanoMontaje.ToUpper();
                paramArray[2] = pobjModelo.fechaInicio.ToUpper();
                paramArray[3] = pobjModelo.fechaFin.ToUpper();
                paramArray[4] = pobjModelo.codigoPlanoMontaje.ToUpper();
                paramArray[5] = pobjModelo.infGeneralPlanoMontaje.ToUpper();
                paramArray[6] = pobjModelo.archivoPlanoMontaje.ToUpper();
                paramArray[7] = pobjModelo.idEtapa;
                paramArray[8] = pobjModelo.usuarioCreacion;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteScalar("usp_InsertarPlanoMontaje", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }

        /// <summary>
        /// Se actualiza la informacion del plano montaje
        /// </summary>
        /// <param name="pobjModelo">Datos nuevo plano montaje</param>
        /// <returns>value</returns>
        public static string Actualiza(Models.PlanosMontaje pobjModelo)
        {
            object[] paramArray = new object[9];
            try
            {
                paramArray[0] = pobjModelo.idEstatus;
                paramArray[1] = pobjModelo.nombrePlanoMontaje.ToUpper();
                paramArray[2] = pobjModelo.fechaInicio.ToUpper();
                paramArray[3] = pobjModelo.fechaFin.ToUpper();
                paramArray[4] = pobjModelo.codigoPlanoMontaje.ToUpper();
                paramArray[5] = pobjModelo.infGeneralPlanoMontaje.ToUpper();
                paramArray[6] = pobjModelo.archivoPlanoMontaje.ToUpper();
                paramArray[7] = pobjModelo.idEtapa;
                paramArray[8] = pobjModelo.id;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteNonQuery("usp_ActualizarPlanoMontaje", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }

        /// <summary>
        /// Se borra de la base de datos el Plano Montaje
        /// </summary>
        /// <param name="idPlanoMontaje"></param>
        /// <returns></returns>
        public static string Borrar(int idPlanoMontaje)
        {
            object[] paramArray = new object[1];
            try
            {
                paramArray[0] = idPlanoMontaje;
               
                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteNonQuery("usp_RemuevePlanoMontaje", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }

    }
}
