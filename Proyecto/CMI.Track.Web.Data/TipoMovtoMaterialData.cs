///Propósito: Datos de tipos de movimiento de material
///Fecha creación: 02/Febrero/2016
///Creador: David Jasso
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
    public class TipoMovtoMaterialData
    {
        /// <summary>
        /// Se carga el listado de tipos de movimientos
        /// </summary>
        /// <returns>Lista tipos de movimientos</returns>
        public static List<Models.ListaTipoMovtoMaterial> CargaTiposMovtoMaterial()
        {
            var listaTiposMovtoMaterial = new List<Models.ListaTipoMovtoMaterial>();
            object[] paramArray = new object[2];
            try
            {
                paramArray[0] = null;
                paramArray[1] = null;
                
                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarTiposMovtoMaterial", paramArray))
                {
                    while (dataReader.Read())
                    {
                        listaTiposMovtoMaterial.Add(new Models.ListaTipoMovtoMaterial()
                        {
                            id = Convert.ToInt32(dataReader["idTipoMovtoMaterial"]),
                            NombreTipoMovtoMaterial = Convert.ToString(dataReader["nombreTipoMovtoMaterial"]),
                            TipoMovimiento = Convert.ToString(dataReader["tipoMovtoMaterial"]),
                            Estatus = Convert.ToString(dataReader["nombreEstatus"]),
                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }

            return listaTiposMovtoMaterial;
        }

        /// <summary>
        /// Se carga el listado de tipos de movimientos
        /// </summary>
        /// <returns>Lista tipos de movimientos</returns>
        public static List<Models.ListaTipoMovtoMaterial> CargaTiposMovtoMaterialActivos()
        {
            var listaTiposMovtoMaterial = new List<Models.ListaTipoMovtoMaterial>();
            object[] paramArray = new object[2];
            try
            {
                paramArray[0] = null;
                paramArray[1] = 1;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarTiposMovtoMaterial", paramArray))
                {
                    while (dataReader.Read())
                    {
                        listaTiposMovtoMaterial.Add(new Models.ListaTipoMovtoMaterial()
                        {
                            id = Convert.ToInt32(dataReader["idTipoMovtoMaterial"]),
                            NombreTipoMovtoMaterial = Convert.ToString(dataReader["nombreTipoMovtoMaterial"]),
                            TipoMovimiento = Convert.ToString(dataReader["tipoMovtoMaterial"]),
                            Estatus = Convert.ToString(dataReader["nombreEstatus"]),
                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }

            return listaTiposMovtoMaterial;
        }


        /// <summary>
        /// Se carga el listado de tipos de movimeintos de materiales
        /// </summary>
        /// <returns>Lista Tipos de movimientos</returns>
        public static Models.TipoMovtoMaterial CargaTipoMovtoMaterial(string idTipoMovtoMaterial)
        {
            object[] paramArray = new object[2];
            try
            {
                paramArray[0] = idTipoMovtoMaterial == "" ? null : idTipoMovtoMaterial;
                paramArray[1] = null;
                
                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarTiposMovtoMaterial", paramArray))
                {
                    while (dataReader.Read())
                    {
                        var objTipoMovtoMaterial = new Models.TipoMovtoMaterial()
                        {
                            id = Convert.ToInt32(dataReader["idTipoMovtoMaterial"]),
                            NombreTipoMovtoMaterial = Convert.ToString(dataReader["nombreTipoMovtoMaterial"]),
                            TipoMovimiento = Convert.ToString(dataReader["tipoMovtoMaterial"]),
                            Estatus = Convert.ToString(dataReader["nombreEstatus"]),                       
                        };

                        return objTipoMovtoMaterial;
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
        /// Se guarda la informacion de un nuevo tipo de movimiento de material
        /// </summary>
        /// <param name="pobjModelo">Datos nuevo tipo de movimiento de material</param>
        /// <returns>value</returns>
        public static string Guardar(Models.TipoMovtoMaterial pobjModelo)
        {
            object[] paramArray = new object[3];
            try
            {             
                paramArray[0] = pobjModelo.NombreTipoMovtoMaterial.ToUpper();
                paramArray[1] = pobjModelo.TipoMovimiento.ToUpper();
                paramArray[2] = pobjModelo.usuarioCreacion;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteScalar("usp_InsertarTipoMovtoMaterial", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }

        /// <summary>
        /// Se actuliza la informacion del tipo de movimiento de material
        /// </summary>
        /// <param name="pobjModelo">Datos del tipo de movimiento</param>
        /// <returns>value</returns>
        public static string Actualiza(Models.TipoMovtoMaterial pobjModelo)
        {
            object[] paramArray = new object[4];
            try
            {
                paramArray[0] = pobjModelo.id;
                paramArray[1] = pobjModelo.Estatus;
                paramArray[2] = pobjModelo.NombreTipoMovtoMaterial.ToUpper();
                paramArray[3] = pobjModelo.TipoMovimiento.ToUpper();    

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteNonQuery("usp_ActualizarTipoMovtoMaterial", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }

        /// <summary>
        /// Remueve de base de datos el tipo de movimiento de material 
        /// </summary>
        /// <param name="idTipoMovtoMaterial"></param>
        /// <returns></returns>
        public static string Borrar(string idTipoMovtoMaterial)
        {
            object[] paramArray = new object[1];
            try
            {
                paramArray[0] = idTipoMovtoMaterial;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteNonQuery("usp_RemueveTipoMovtoMaterial", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }

       
    }
}
