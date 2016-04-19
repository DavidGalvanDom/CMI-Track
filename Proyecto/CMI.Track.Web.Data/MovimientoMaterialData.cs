///Propósito: Datos de Movimientos Materiales
///Fecha creación: 02/Abril/2016
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
    public class MovimientoMaterialData
    {
        /// <summary>
        /// Se carga el listado de categorias
        /// </summary>
        /// <returns>Lista categorias</returns>
        public static List<Models.ListaMovimientoMaterial> CargaMovimientos(string id)
        {
            var listaMovimientos = new List<Models.ListaMovimientoMaterial>();
            object[] paramArray = new object[1];
            try
            {
                paramArray[0] = id == "undefined" ? null : id;
                
                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarMovimientosMaterial", paramArray))
                {
                    while (dataReader.Read())
                    {
                        listaMovimientos.Add(new Models.ListaMovimientoMaterial()
                        {
                            id = Convert.ToInt32(dataReader["idMovimientoMaterial"]),
                            idMaterialM = Convert.ToInt32(dataReader["idMaterial"]),
                            Material = Convert.ToString(dataReader["nombreMaterial"]),
                            idDocumento = Convert.ToInt32(dataReader["documentoMovimientoMaterial"]),
                            Existencia = Convert.ToDouble(dataReader["cantidadInventario"]),
                            Cantidad = Convert.ToDouble(dataReader["cantidadMovimientoMaterial"]),
                            TipoMovto = Convert.ToString(dataReader["tipoMovtoMaterial"]),
                            Almacen = Convert.ToString(dataReader["nombreAlmacen"]),
                            Calidad = Convert.ToString(dataReader["calidadMaterial"]),
                            Largo = Convert.ToDouble(dataReader["largoMaterial"]),
                            Ancho = Convert.ToDouble(dataReader["anchoMaterial"]),
                            
                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }

            return listaMovimientos;
        }

        /// <summary>
        /// Se carga el listado de categorias
        /// </summary>
        /// <returns>Lista categorias</returns>
        public static List<Models.ListaMovimientoMaterial> CargaHeaderMovtos(string id)
        {
            var listaMovimientos = new List<Models.ListaMovimientoMaterial>();
            object[] paramArray = new object[1];
            try
            {
                paramArray[0] = id == "" ? null : id;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarHeaderMovtosMaterial", paramArray))
                {
                    while (dataReader.Read())
                    {
                        listaMovimientos.Add(new Models.ListaMovimientoMaterial()
                        {

                           
                            idDocumento = Convert.ToInt32(dataReader["documentoMovimientoMaterial"]),
                            TipoMovto = Convert.ToString(dataReader["nombreTipoMovtoMaterial"]),

                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }

            return listaMovimientos;
        }

        /// <summary>
        /// Se carga el listado de categorias
        /// </summary>
        /// <returns>Lista Categorias</returns>
        //public static Models.MovimientoMaterial CargaMovimientosDocumento(int idDocumento)
        //{
        //    object[] paramArray = new object[1];
        //    try
        //    {
        //        paramArray[0] = idDocumento;
                            
        //        var db = DatabaseFactory.CreateDatabase("SQLStringConn");

        //        using (IDataReader dataReader = db.ExecuteReader("usp_CargarMovimientosMaterial", paramArray))
        //        {
        //            while (dataReader.Read())
        //            {
        //                var objMovtos = new Models.MovimientoMaterial()
        //                {
        //                    id = Convert.ToInt32(dataReader["idMovimientoMaterial"]),
        //                    idMaterialM = Convert.ToInt32(dataReader["idMaterial"]),
        //                    Material = Convert.ToString(dataReader["nombreMaterial"]),
        //                    idDocumento = Convert.ToInt32(dataReader["documentoMovimientoMaterial"]),
        //                    Existencia = Convert.ToDouble(dataReader["cantidadInventario"]),
        //                    Cantidad = Convert.ToDouble(dataReader["cantidadMovimientoMaterial"]),
        //                    TipoMovto = Convert.ToString(dataReader["tipoMovtoMaterial"]),                         
        //                };

        //                return objMovtos;
        //            }
        //        }
        //    }
        //    catch (Exception exp)
        //    {
        //        throw new ApplicationException(exp.Message, exp);
        //    }

        //    return null;

        //}

        /// <summary>
        /// Se carga el listado de categorias
        /// </summary>
        /// <returns>Lista categorias</returns>
        public static List<Models.ListaMovimientoMaterial> CargaDocumentos()
        {
            var listaMovimientos = new List<Models.ListaMovimientoMaterial>();
            try
            {

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarDocumentos"))
                {
                    while (dataReader.Read())
                    {
                        listaMovimientos.Add(new Models.ListaMovimientoMaterial()
                        {
                            idDocumento = Convert.ToInt32(dataReader["documentoMovimientoMaterial"]),

                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }

            return listaMovimientos;
        }

        /// <summary>
        /// Se carga el listado de categorias
        /// </summary>
        /// <returns>Lista categorias</returns>
        public static List<Models.ListaMovimientoMaterial> CargaTiposMovimientos()
        {
            var listaMovimientos = new List<Models.ListaMovimientoMaterial>();
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
                        listaMovimientos.Add(new Models.ListaMovimientoMaterial()
                        {
                            id = Convert.ToInt32(dataReader["idTipoMovtoMaterial"]),
                            TipoMovto = Convert.ToString(dataReader["tipoMovtoMaterial"]),

                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }

            return listaMovimientos;
        }

        /// <summary>
        /// Se guarda la informacion de una nueva categora
        /// </summary>
        /// <param name="pobjModelo">Datos nueva Categoria</param>
        /// <returns>value</returns>
        public static string Guardar(Models.MovimientoMaterial pobjModelo)
        {
            object[] paramArray = new object[6];
            try
            {
                paramArray[0] = pobjModelo.idMaterialM;
                paramArray[1] = pobjModelo.idAlmacen;
                paramArray[2] = pobjModelo.Cantidad;
                paramArray[3] = pobjModelo.TipoMovto;
                paramArray[4] = pobjModelo.idDocumento;
                paramArray[5] = pobjModelo.usuarioCreacion;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteScalar("usp_InsertarMovimientosMaterial", paramArray);

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
        public static string Actualiza(Models.Categoria pobjModelo)
        {
            object[] paramArray = new object[3];
            try
            {
                paramArray[0] = pobjModelo.id;
                paramArray[1] = pobjModelo.Estatus;
                paramArray[2] = pobjModelo.NombreCategoria.ToUpper();             

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteNonQuery("usp_ActualizarCategoria", paramArray);

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

       
    }
}
