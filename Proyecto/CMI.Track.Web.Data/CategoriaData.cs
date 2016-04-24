///Propósito: Datos de Categorias
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
    public class CategoriaData
    {
        /// <summary>
        /// Se carga el listado de categorias
        /// </summary>
        /// <returns>Lista categorias</returns>
        public static List<Models.ListaCategoria> CargaCategorias()
        {
            var listaCategorias = new List<Models.ListaCategoria>();
            object[] paramArray = new object[2];
            try
            {
                paramArray[0] = null;
                paramArray[1] = null;
                
                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarCategorias", paramArray))
                {
                    while (dataReader.Read())
                    {
                        listaCategorias.Add(new Models.ListaCategoria()
                        {
                            id = Convert.ToInt32(dataReader["idCategoria"]),
                            NombreCategoria = Convert.ToString(dataReader["nombreCategoria"]),
                            Estatus = Convert.ToString(dataReader["nombreEstatus"]),
                            
                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }

            return listaCategorias;
        }

        /// <summary>
        /// Se carga el listado de categorias
        /// </summary>
        /// <returns>Lista categorias</returns>
        public static List<Models.ListaCategoria> CargaCategoriasActivas()
        {
            var listaCategorias = new List<Models.ListaCategoria>();
            object[] paramArray = new object[2];
            try
            {
                paramArray[0] = null;
                paramArray[1] = 1;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarCategorias", paramArray))
                {
                    while (dataReader.Read())
                    {
                        listaCategorias.Add(new Models.ListaCategoria()
                        {
                            id = Convert.ToInt32(dataReader["idCategoria"]),
                            NombreCategoria = Convert.ToString(dataReader["nombreCategoria"]),
                            Estatus = Convert.ToString(dataReader["nombreEstatus"]),

                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }

            return listaCategorias;
        }


        /// <summary>
        /// Se carga el listado de categorias
        /// </summary>
        /// <returns>Lista Categorias</returns>
        public static Models.Categoria CargaCategoria(string idCategoria)
        {
            object[] paramArray = new object[2];
            try
            {
                paramArray[0] = idCategoria == "" ? null : idCategoria;
                paramArray[1] = null;
                            
                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarCategorias", paramArray))
                {
                    while (dataReader.Read())
                    {
                        var objCategoria = new Models.Categoria()
                        {
                            id = Convert.ToInt32(dataReader["idCategoria"]),
                            NombreCategoria = Convert.ToString(dataReader["nombreCategoria"]),
                            Estatus = Convert.ToString(dataReader["idEstatus"]),                           
                        };

                        return objCategoria;
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
        /// Se guarda la informacion de una nueva categora
        /// </summary>
        /// <param name="pobjModelo">Datos nueva Categoria</param>
        /// <returns>value</returns>
        public static string Guardar(Models.Categoria pobjModelo)
        {
            object[] paramArray = new object[2];
            try
            {             
                paramArray[0] = pobjModelo.NombreCategoria.ToUpper();
                paramArray[1] = pobjModelo.usuarioCreacion;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteScalar("usp_InsertarCategoria", paramArray);

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
