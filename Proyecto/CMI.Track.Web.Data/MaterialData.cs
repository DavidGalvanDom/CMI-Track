///Propósito: Datos de Materiales
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
    public class MaterialData
    {
        /// <summary>
        /// Se carga el listado de materiales
        /// </summary>
        /// <returns>Lista Materiales</returns>
        public static List<Models.ListaMaterial> CargaMateriales()
        {
            var listaMateriales = new List<Models.ListaMaterial>();
            object[] paramArray = new object[2];
            try
            {
                paramArray[0] = null;
                paramArray[1] = null;
                
                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarMateriales", paramArray))
                {
                    while (dataReader.Read())
                    {
                        listaMateriales.Add(new Models.ListaMaterial()
                        {
                            id = Convert.ToInt32(dataReader["idMaterial"]),
                            NombreMaterial = Convert.ToString(dataReader["nombreMaterial"]),
                            AnchoMaterial = Convert.ToInt32(dataReader["anchoMaterial"]),
                            AnchoUM = Convert.ToString(dataReader["NomUMAncho"]),
                            LargoMaterial = Convert.ToInt32(dataReader["largoMaterial"]),
                            LargoUM = Convert.ToString(dataReader["NomUMLargo"]),
                            PesoMaterial = Convert.ToInt32(dataReader["pesoMaterial"]),
                            PesoUM = Convert.ToString(dataReader["NomUMPeso"]),
                            CalidadMaterial = Convert.ToString(dataReader["calidadMaterial"]),
                            TipoMaterial = Convert.ToString(dataReader["nombreTipoMaterial"]),
                            Grupo = Convert.ToString(dataReader["nombreGrupo"]),
                            Observaciones = Convert.ToString(dataReader["observacionesMaterial"]),
                            Estatus = Convert.ToString(dataReader["nombreEstatus"]),
                            
                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }

            return listaMateriales;
        }

        /// <summary>
        /// Se carga el listado de materiales
        /// </summary>
        /// <returns>Lista mamateriales</returns>
        public static List<Models.ListaMaterial> CargaMaterialesActivos()
        {
            var listaMateriales = new List<Models.ListaMaterial>();
            object[] paramArray = new object[2];
            try
            {
                paramArray[0] = null;
                paramArray[1] = 1;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarMateriales", paramArray))
                {
                    while (dataReader.Read())
                    {
                        listaMateriales.Add(new Models.ListaMaterial()
                        {
                            id = Convert.ToInt32(dataReader["idMaterial"]),
                            NombreMaterial = Convert.ToString(dataReader["nombreMaterial"]),
                            AnchoMaterial = Convert.ToInt32(dataReader["anchoMaterial"]),
                            AnchoUM = Convert.ToString(dataReader["idUMAncho"]),
                            LargoMaterial = Convert.ToInt32(dataReader["largoMaterial"]),
                            LargoUM = Convert.ToString(dataReader["idUMLargo"]),
                            PesoMaterial = Convert.ToInt32(dataReader["pesoMaterial"]),
                            PesoUM = Convert.ToString(dataReader["idUMPeso"]),
                            CalidadMaterial = Convert.ToString(dataReader["calidadMaterial"]),
                            TipoMaterial = Convert.ToString(dataReader["idTipoMaterial"]),
                            Grupo = Convert.ToString(dataReader["idGrupo"]),
                            Observaciones = Convert.ToString(dataReader["observacionesMaterial"]),
                            Estatus = Convert.ToString(dataReader["nombreEstatus"]),

                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }

            return listaMateriales;
        }


        /// <summary>
        /// Se carga el listado de materiales
        /// </summary>
        /// <returns>Lista Materiales</returns>
        public static Models.Material CargaMaterial(string idMaterial)
        {
            object[] paramArray = new object[2];
            try
            {
                paramArray[0] = idMaterial == "" ? null : idMaterial;
                paramArray[1] = null;
                            
                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarMateriales", paramArray))
                {
                    while (dataReader.Read())
                    {
                        var objMaterial = new Models.Material()
                        {
                            id = Convert.ToInt32(dataReader["idMaterial"]),
                            NombreMaterial = Convert.ToString(dataReader["nombreMaterial"]),
                            AnchoMaterial = Convert.ToInt32(dataReader["anchoMaterial"]),
                            AnchoUM = Convert.ToInt32(dataReader["idUMAncho"]),
                            LargoMaterial = Convert.ToInt32(dataReader["largoMaterial"]),
                            LargoUM = Convert.ToInt32(dataReader["idUMLargo"]),
                            PesoMaterial = Convert.ToInt32(dataReader["pesoMaterial"]),
                            PesoUM = Convert.ToInt32(dataReader["idUMPeso"]),
                            CalidadMaterial = Convert.ToString(dataReader["calidadMaterial"]),
                            TipoMaterial = Convert.ToInt32(dataReader["idTipoMaterial"]),
                            Grupo = Convert.ToInt32(dataReader["idGrupo"]),
                            Observaciones = Convert.ToString(dataReader["observacionesMaterial"]),
                            Estatus = Convert.ToString(dataReader["idEstatus"]),                          
                        };

                        return objMaterial;
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
        /// Se guarda la informacion de un nuevo material
        /// </summary>
        /// <param name="pobjModelo">Datos nuevo material</param>
        /// <returns>value</returns>
        public static string Guardar(Models.Material pobjModelo)
        {
            object[] paramArray = new object[12];
            try
            {             
                paramArray[0] = pobjModelo.NombreMaterial.ToUpper();
                paramArray[1] = pobjModelo.AnchoMaterial;
                paramArray[2] = pobjModelo.AnchoUM;
                paramArray[3] = pobjModelo.LargoMaterial;
                paramArray[4] = pobjModelo.LargoUM;
                paramArray[5] = pobjModelo.PesoMaterial;
                paramArray[6] = pobjModelo.PesoUM;
                paramArray[7] = pobjModelo.CalidadMaterial.ToUpper();
                paramArray[8] = pobjModelo.TipoMaterial;
                paramArray[9] = pobjModelo.Grupo;
                paramArray[10] = pobjModelo.Observaciones.ToUpper();
                paramArray[11] = pobjModelo.usuarioCreacion;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteScalar("usp_InsertarMaterial", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }

        /// <summary>
        /// Se actuliza la informacion del material
        /// </summary>
        /// <param name="pobjModelo">Datos del material</param>
        /// <returns>value</returns>
        public static string Actualiza(Models.Material pobjModelo)
        {
            object[] paramArray = new object[13];
            try
            {
                paramArray[0] = pobjModelo.id;
                paramArray[1] = pobjModelo.Estatus;
                paramArray[2] = pobjModelo.NombreMaterial.ToUpper();
                paramArray[3] = pobjModelo.AnchoMaterial;
                paramArray[4] = pobjModelo.AnchoUM;
                paramArray[5] = pobjModelo.LargoMaterial;
                paramArray[6] = pobjModelo.LargoUM;
                paramArray[7] = pobjModelo.PesoMaterial;
                paramArray[8] = pobjModelo.PesoUM;
                paramArray[9] = pobjModelo.CalidadMaterial.ToUpper();
                paramArray[10] = pobjModelo.TipoMaterial;
                paramArray[11] = pobjModelo.Grupo;
                paramArray[12] = pobjModelo.Observaciones.ToUpper();           

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteNonQuery("usp_ActualizarMaterial", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }

        /// <summary>
        /// Remueve de base de datos el material
        /// </summary>
        /// <param name="idMaterial"></param>
        /// <returns></returns>
        public static string Borrar(string idMaterial)
        {
            object[] paramArray = new object[1];
            try
            {
                paramArray[0] = idMaterial;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteNonQuery("usp_RemueveMaterial", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }

       
    }
}
