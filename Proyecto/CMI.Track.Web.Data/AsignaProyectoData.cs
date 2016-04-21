﻿///Propósito: Datos de Asiganr Materiales por proyecto
///Fecha creación: 30/Marzo/2016
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
    public class AsignaProyectoData
    {
        /// <summary>
        /// Se carga el listado de materiales por proyecto
        /// </summary>
        /// <returns>Lista Materiales Proyecto</returns>
        public static List<Models.ListaAsignaProyecto> CargaMaterialesProyecto(int idProyecto, int idEtapa)
        {
            var listaMaterialesP = new List<Models.ListaAsignaProyecto>();
            object[] paramArray = new object[3];
            try
            {
                paramArray[0] = idProyecto;
                paramArray[1] = idEtapa;
                paramArray[2] = null;
                
                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarMaterialesProyecto", paramArray))
                {
                    while (dataReader.Read())
                    {
                        listaMaterialesP.Add(new Models.ListaAsignaProyecto()
                        {
                            id = Convert.ToInt32(dataReader["idMaterialProyecto"]),
                            idMaterial = Convert.ToInt32(dataReader["idMaterial"]),
                            nombreMat = Convert.ToString(dataReader["nombreMaterial"]),
                            UM = Convert.ToString(dataReader["nombreCortoUnidadMedida"]),
                            Existencia = Convert.ToDouble(dataReader["cantidadInventario"]),
                            Cantidad = Convert.ToDouble(dataReader["cantidadEntrega"]),
                            Calidad = Convert.ToString(dataReader["calidadMaterial"]),
                            Ancho = Convert.ToDouble(dataReader["anchoMaterial"]),
                            Largo = Convert.ToDouble(dataReader["largoMaterial"]),
                            LongArea = Convert.ToDouble(dataReader["LongArea"]),
                            Peso = Convert.ToDouble(dataReader["pesoMaterial"]),
                            Total = Convert.ToDouble(dataReader["Total"]),
                            
                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }

            return listaMaterialesP;
        }


        /// <summary>
        /// Se carga el listado de categorias
        /// </summary>
        /// <returns>Lista Categorias</returns>
        public static Models.AsignaProyecto CargaMaterialProyecto(int idProyecto, int idEtapa, string id)
        {
            object[] paramArray = new object[3];
            try
            {
                paramArray[0] = idProyecto;
                paramArray[1] = idEtapa;
                paramArray[2] = id == "" ? null : id;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarMaterialesProyecto", paramArray))
                {
                    while (dataReader.Read())
                    {
                        var objMaterialPro = new Models.AsignaProyecto()
                        {
                           // id = Convert.ToInt32(dataReader["idCategoria"]),
                          //  NombreCategoria = Convert.ToString(dataReader["nombreCategoria"]),
                           // Estatus = Convert.ToString(dataReader["nombreEstatus"]),
                        };

                        return objMaterialPro;
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
        /// Se carga el listado de materiales por proyecto
        /// </summary>
        /// <returns>Lista Materiales Proyecto</returns>
        public static List<Models.ListaAsignaProyecto> CargaMaterialesAsignados(int idProyecto, int idEtapa, int idRequerimiento, int idAlmacen)
        {
            var listaMaterialesP = new List<Models.ListaAsignaProyecto>();
            object[] paramArray = new object[4];
            try
            {
                paramArray[0] = idProyecto;
                paramArray[1] = idEtapa;
                paramArray[2] = idRequerimiento;
                paramArray[3] = idAlmacen;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarMaterialesAsignados", paramArray))
                {
                    while (dataReader.Read())
                    {
                        listaMaterialesP.Add(new Models.ListaAsignaProyecto()
                        {
                            id = Convert.ToInt32(dataReader["idDetalleRequisicion"]),
                            idMaterial = Convert.ToInt32(dataReader["idMaterial"]),
                            nombreMat = Convert.ToString(dataReader["nombreMaterial"]),
                            UM = Convert.ToString(dataReader["nombreCortoUnidadMedida"]),
                            Existencia = Convert.ToDouble(dataReader["cantidadInventario"]),
                            Cantidad = Convert.ToDouble(dataReader["cantidadEntrega"]),
                            Calidad = Convert.ToString(dataReader["calidadMaterial"]),
                            Ancho = Convert.ToDouble(dataReader["anchoMaterial"]),
                            Largo = Convert.ToDouble(dataReader["largoMaterial"]),
                            LongArea = Convert.ToDouble(dataReader["LongArea"]),
                            Peso = Convert.ToDouble(dataReader["pesoMaterial"]),
                            Total = Convert.ToDouble(dataReader["Total"]),

                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }

            return listaMaterialesP;
        }

        /// <summary>
        /// Se guarda la informacion de una nueva categora
        /// </summary>
        /// <param name="pobjModelo">Datos nueva Categoria</param>
        /// <returns>value</returns>
        public static string Guardar(Models.AsignaProyecto pobjModelo)
        {
            object[] paramArray = new object[6];
            try
            {
                paramArray[0] = pobjModelo.idProyecto;
                paramArray[1] = pobjModelo.idEtapa;
                paramArray[2] = pobjModelo.idReq;
                paramArray[3] = pobjModelo.idAlmacen;
                paramArray[4] = pobjModelo.Revision;
                paramArray[5] = pobjModelo.usuarioCreacion;


                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteScalar("usp_InsertarMaterialesProyecto", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }

        /// <summary>
        /// Se guarda la informacion de una nueva categora
        /// </summary>
        /// <param name="pobjModelo">Datos nueva Categoria</param>
        /// <returns>value</returns>
        public static string GuardarM(Models.AsignaProyecto pobjModelo)
        {
            object[] paramArray = new object[8];
            try
            {
                paramArray[0] = pobjModelo.idProyecto;
                paramArray[1] = pobjModelo.idEtapa;
                paramArray[2] = pobjModelo.idAlmacen;
                paramArray[3] = pobjModelo.idMaterialSelect;
                paramArray[4] = pobjModelo.idOrigen;
                paramArray[5] = pobjModelo.Unidad;
                paramArray[6] = pobjModelo.Revision;
                paramArray[7] = pobjModelo.usuarioCreacion;


                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteScalar("usp_InsertarMaterialesProyectoM", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }

        /// <summary>
        /// Se actuliza la informacion de la categoria
        /// </summary>
        /// <param name="pobjModelo">Datos de la categoria</param>
        /// <returns>value</returns>
        public static string Actualiza(Models.AsignaProyecto pobjModelo)
        {
            object[] paramArray = new object[5];
            try
            {
                paramArray[0] = pobjModelo.id;
                paramArray[1] = pobjModelo.idMaterialSelect;
                paramArray[2] = pobjModelo.idAlmacen;
                paramArray[3] = pobjModelo.cantEntrega;
                paramArray[4] = pobjModelo.usuarioCreacion;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteNonQuery("usp_ActualizarMaterialesProyecto", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }


        /// <summary>
        /// Remueve de base de datos la categoria
        /// </summary>
        /// <param name="idCategoria"></param>
        /// <returns></returns>
        public static string Borrar(string idCategoria)
        {
            object[] paramArray = new object[1];
            try
            {
                paramArray[0] = idCategoria;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteNonQuery("usp_RemueveCategoria", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }

        /// <summary>
        /// Se carga el listado de Marcas
        /// </summary>
        /// <param name="idRequerimiento"></param>
        /// <param name="idEstatus"></param>
        /// <returns>Lista de Marcas</returns>
        public static List<Models.ListaAsignaProyecto> CargaDetalleMaterialesProyecto(int idRequerimiento, int idEtapa, int idProyecto)
        {
            var lstAsignaMat = new List<Models.ListaAsignaProyecto>();
            object[] paramArray = new object[3];
            try
            {
                paramArray[0] = idRequerimiento;
                paramArray[1] = idEtapa;
                paramArray[2] = idProyecto;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarDetalleMaterialesProyecto", paramArray))
                {
                    while (dataReader.Read())
                    {
                        lstAsignaMat.Add(new Models.ListaAsignaProyecto()
                        {
                            id = Convert.ToInt32(dataReader["Row"]),
                            nombreMaterial = Convert.ToString(dataReader["Nombre"]),
                            Ancho = Convert.ToDouble(dataReader["Ancho"]),
                            Largo = Convert.ToDouble(dataReader["Long"]),
                            Cantidad = Convert.ToDouble(dataReader["recpie"]),
                            Peso = Convert.ToDouble(dataReader["reckgs"]),
                            Solpie = Convert.ToDouble(dataReader["solpie"]),
                            Solkgs = Convert.ToDouble(dataReader["solkgs"]),
                            Reqpie = Convert.ToDouble(dataReader["reqpie"]),
                            Reqkgs = Convert.ToDouble(dataReader["reqkgs"]),
                            Matpie = Convert.ToDouble(dataReader["matpie"]),
                            Matkgs = Convert.ToDouble(dataReader["matkgs"])
                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
            return lstAsignaMat;
        }

       
    }
}