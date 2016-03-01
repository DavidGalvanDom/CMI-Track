///Propósito: Acceso a base de datos Planos Despiece
///Fecha creación: 24/Febrero/2016
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
    public class PlanosDespieceData
    {
        /// <summary>
        /// Se carga el listado de Planos Despiece
        /// </summary>
        /// <param name="idPlanoMontaje"></param>
        /// <param name="idEstatus"></param>
        /// <returns>Lista de Etapas</returns>
        public static List<Models.ListaPlanosDespiece> CargaPlanosDespiece(int idPlanoMontaje, int? idEstatus)
        {
            var lstPlanosDespiece = new List<Models.ListaPlanosDespiece>();
            object[] paramArray = new object[3];
            try
            {
                paramArray[0] = idPlanoMontaje;
                paramArray[1] = null;
                paramArray[2] = idEstatus;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarPlanosDespiece", paramArray))
                {
                    while (dataReader.Read())
                    {
                        lstPlanosDespiece.Add(new Models.ListaPlanosDespiece()
                        {
                            id = Convert.ToInt32(dataReader["idPlanoDespiece"]),
                            nombrePlanoDespiece = Convert.ToString(dataReader["nombrePlanoDespiece"]),
                            codigoPlanoDespiece = Convert.ToString(dataReader["codigoPlanoDespiece"]),
                            nombreTipoContruccion = Convert.ToString(dataReader["nombreTipoConstruccion"]),
                            nombreEstatus = Convert.ToString(dataReader["nombreEstatus"]),                            
                            archivoPlanoDespiece = Convert.ToString(dataReader["archivoPlanoDespiece"])
                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
            return lstPlanosDespiece;
        }

        /// <summary>
        /// Se carga el Plano Despiece
        /// </summary>
        /// <param name="idPlanoDespiece"></param>        
        /// <returns>Objeto de Plano Despiece</returns>
        public static Models.PlanosDespiece CargaPlanoDespiece(int idPlanoDespiece)
        {
            var objPlanoMontaje = new Models.PlanosDespiece();
            object[] paramArray = new object[3];
            try
            {
                paramArray[0] = null;
                paramArray[1] = idPlanoDespiece;
                paramArray[2] = null;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarPlanosDespiece", paramArray))
                {
                    while (dataReader.Read())
                    {
                        objPlanoMontaje = new Models.PlanosDespiece()
                        {
                            id = Convert.ToInt32(dataReader["idPlanoDespiece"]),
                            nombrePlanoDespiece = Convert.ToString(dataReader["nombrePlanoDespiece"]),
                            idEstatus = Convert.ToInt32(dataReader["idEstatus"]),
                            idTipoConstruccion = Convert.ToInt32(dataReader["idTipoConstruccion"]),
                            idPlanoMontaje = Convert.ToInt32(dataReader["idPlanoMontaje"]),                            
                            fechaCreacion = Convert.ToString(dataReader["fechaCreacion"]),
                            archivoPlanoDespiece = Convert.ToString(dataReader["archivoPlanoDespiece"]),
                            infGeneralPlanoDespiece = Convert.ToString(dataReader["infGeneralPlanoDespiece"]),
                            codigoPlanoDespiece = Convert.ToString(dataReader["codigoPlanoDespiece"])
                        };

                        if (objPlanoMontaje.archivoPlanoDespiece != "")
                        {
                            objPlanoMontaje.nombreArchivo = objPlanoMontaje.archivoPlanoDespiece.Substring(33, objPlanoMontaje.archivoPlanoDespiece.Length - 33);
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
        public static string Guardar(Models.PlanosDespiece pobjModelo)
        {
            object[] paramArray = new object[8];
            try
            {
                paramArray[0] = pobjModelo.idEstatus;
                paramArray[1] = pobjModelo.nombrePlanoDespiece.ToUpper();                
                paramArray[2] = pobjModelo.codigoPlanoDespiece.ToUpper();
                paramArray[3] = pobjModelo.infGeneralPlanoDespiece.ToUpper();
                paramArray[4] = pobjModelo.archivoPlanoDespiece == null ? null : pobjModelo.archivoPlanoDespiece.ToUpper();
                paramArray[5] = pobjModelo.idTipoConstruccion;
                paramArray[6] = pobjModelo.idPlanoMontaje;
                paramArray[7] = pobjModelo.usuarioCreacion;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteScalar("usp_InsertarPlanoDespiece", paramArray);

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
        public static string Actualiza(Models.PlanosDespiece pobjModelo)
        {
            object[] paramArray = new object[8];
            try
            {
                paramArray[0] = pobjModelo.idEstatus;
                paramArray[1] = pobjModelo.nombrePlanoDespiece.ToUpper();
                paramArray[2] = pobjModelo.codigoPlanoDespiece.ToUpper();
                paramArray[3] = pobjModelo.infGeneralPlanoDespiece.ToUpper();                
                paramArray[4] = pobjModelo.archivoPlanoDespiece == null ? null : pobjModelo.archivoPlanoDespiece.ToUpper();
                paramArray[5] = pobjModelo.idTipoConstruccion;
                paramArray[6] = pobjModelo.idPlanoMontaje;
                paramArray[7] = pobjModelo.id;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteNonQuery("usp_ActualizarPlanoDespiece", paramArray);

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
        public static string Borrar(int idPlanoDespiece)
        {
            object[] paramArray = new object[1];
            try
            {
                paramArray[0] = idPlanoDespiece;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteNonQuery("usp_RemuevePlanoDespiece", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }
    }
}
