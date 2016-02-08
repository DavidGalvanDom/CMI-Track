///Propósito: Datos Tipos de Material
///Fecha creación: 01/Febrero/2016
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
    public class TipoMaterialData
    {
        /// <summary>
        /// Se carga el listado de Tipos de Material
        /// </summary>
        /// <returns>Lista TipoMaterial</returns>
        public static List<Models.ListaTipoMaterial> CargaTiposMaterial()
        {
            var listaTiposMaterial = new List<Models.ListaTipoMaterial>();
            object[] paramArray = new object[2];
            try
            {
                paramArray[0] = null;
                paramArray[1] = null;
                
                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarTiposMaterial", paramArray))
                {
                    while (dataReader.Read())
                    {
                        listaTiposMaterial.Add(new Models.ListaTipoMaterial()
                        {
                            id = Convert.ToInt32(dataReader["idTipoMaterial"]),
                            nombreTipoMaterial = Convert.ToString(dataReader["nombreTipoMaterial"]),
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

            return listaTiposMaterial;
        }
        
        /// <summary>
        /// Cargar un Tipo de Material
        /// </summary>
        /// <returns>Un Tipo de Material</returns>
        public static Models.TipoMaterial CargaTipoMaterial(string idTipoMaterial)
        {
            object[] paramArray = new object[2];
            try
            {
                paramArray[0] = idTipoMaterial == "" ? null : idTipoMaterial;
                paramArray[1] = null;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarTiposMaterial", paramArray))
                {
                    while (dataReader.Read())
                    {
                        var objTipoMaterial = new Models.TipoMaterial()
                        {
                            id = Convert.ToInt32(dataReader["idTipoMaterial"]),
                            nombreTipoMaterial = Convert.ToString(dataReader["nombreTipoMaterial"]),
                            idEstatus = Convert.ToInt32(dataReader["idEstatus"])
                        };
                        return objTipoMaterial;
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
        /// Se carga el listado de Tipos de Material Activos
        /// </summary>
        /// <returns>Lista TipoMaterial</returns>
        public static List<Models.ListaTipoMaterial> CargaTiposMaterialActivos()
        {
            var listaTiposMaterial = new List<Models.ListaTipoMaterial>();
            object[] paramArray = new object[2];
            try
            {
                paramArray[0] = null;
                paramArray[1] = 1;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarTiposMaterial", paramArray))
                {
                    while (dataReader.Read())
                    {
                        listaTiposMaterial.Add(new Models.ListaTipoMaterial()
                        {
                            id = Convert.ToInt32(dataReader["idTipoMaterial"]),
                            nombreTipoMaterial = Convert.ToString(dataReader["nombreTipoMaterial"]),
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

            return listaTiposMaterial;
        }

        /// <summary>
        /// Se guarda la informacion de un nuevo Tipo de Material
        /// </summary>
        /// <param name="pobjModelo">Datos nuevo TipoMaterial</param>
        /// <returns>value</returns>
        public static string Guardar(Models.TipoMaterial pobjModelo)
        {
            object[] paramArray = new object[2];
            try
            {
                paramArray[0] = pobjModelo.nombreTipoMaterial.ToUpper();
                paramArray[1] = pobjModelo.usuarioCreacion;
                                
                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteScalar("usp_InsertarTipoMaterial", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }

        /// <summary>
        /// Se actualiza la informacion del TipoMaterial
        /// </summary>
        /// <param name="pobjModelo">Datos del TipoMaterial</param>
        /// <returns>value</returns>
        public static string Actualiza(Models.TipoMaterial pobjModelo)
        {
            object[] paramArray = new object[3];
            try
            {
                paramArray[0] = pobjModelo.id;
                paramArray[1] = pobjModelo.nombreTipoMaterial.ToUpper();
                paramArray[2] = pobjModelo.idEstatus;
                
                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteNonQuery("usp_ActualizarTipoMaterial", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }

        /// <summary>
        /// Remueve de base de datos el TipoMaterial
        /// </summary>
        /// <param name="idTipoMaterial"></param>
        /// <returns></returns>
        public static string Borrar(string idTipoMaterial)
        {
            object[] paramArray = new object[1];
            try
            {
                paramArray[0] = idTipoMaterial;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteNonQuery("usp_RemueveTipoMaterial", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }
    }
}
