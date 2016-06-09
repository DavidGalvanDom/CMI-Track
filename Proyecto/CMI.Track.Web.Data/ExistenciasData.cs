///Propósito: Datos de Kardex
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
    public class ExistenciasData
    {
        /// <summary>
        /// Se carga el listado de kardex
        /// </summary>
        /// <returns>Lista categorias</returns>
        public static List<Models.ListaExistencias> CargaExistencias(string idMaterial, string idAlmacen)
        {
            var listaExistencias = new List<Models.ListaExistencias>();
            object[] paramArray = new object[2];
            try
            {
                paramArray[0] = idMaterial == "" ? null : idMaterial;
                paramArray[1] = idAlmacen == "" ? null : idAlmacen;
                
                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarExistencias", paramArray))
                {
                    while (dataReader.Read())
                    {
                        listaExistencias.Add(new Models.ListaExistencias()
                        {
                            id = Convert.ToInt32(dataReader["rank"]),
                            NombreGrupo = Convert.ToString(dataReader["nombreGrupo"]),
                            idMaterial = Convert.ToInt32(dataReader["idMaterial"]),
                            NombreMaterial = Convert.ToString(dataReader["nombreMaterial"]),
                            Ancho = Convert.ToDouble(dataReader["anchoMaterial"]),
                            UMAncho = Convert.ToString(dataReader["nombreCortoUnidadMedidaAncho"]),
                            Largo = Convert.ToDouble(dataReader["largoMaterial"]),
                            UMLargo = Convert.ToString(dataReader["nombreCortoUnidadMedidaLargo"]),
                            Calidad = Convert.ToString(dataReader["calidadMaterial"]),
                            Inventario = Convert.ToInt32(dataReader["cantidadInventario"]),
                            
                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }

            return listaExistencias;
        }

       
    }
}
