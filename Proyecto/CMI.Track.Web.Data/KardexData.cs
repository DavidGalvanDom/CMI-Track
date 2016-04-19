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
    public class KardexData
    {
        /// <summary>
        /// Se carga el listado de kardex
        /// </summary>
        /// <returns>Lista categorias</returns>
        public static List<Models.ListaKardex> CargaKardex(string idMaterial, string idAlmacen)
        {
            var listaKardex = new List<Models.ListaKardex>();
            object[] paramArray = new object[2];
            try
            {
                paramArray[0] = idMaterial == "" ? null : idMaterial;
                paramArray[1] = idAlmacen == "" ? null : idAlmacen;
                
                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarKardex", paramArray))
                {
                    while (dataReader.Read())
                    {
                        listaKardex.Add(new Models.ListaKardex()
                        {
                            id = Convert.ToInt32(dataReader["rank"]),
                            NombreGrupo = Convert.ToString(dataReader["nombreGrupo"]),
                            idMaterial = Convert.ToInt32(dataReader["idMaterial"]),
                            NombreMaterial = Convert.ToString(dataReader["nombreMaterial"]),
                            NombreAlmacen = Convert.ToString(dataReader["nombreAlmacen"]),
                            NomTipoMOvto = Convert.ToString(dataReader["nombreTipoMovtoMaterial"]),
                            TipoMovto = Convert.ToString(dataReader["tipoMovtoMaterial"]),
                            Cantidad = Convert.ToDouble(dataReader["cantidadKardex"]),
                            Fecha = Convert.ToString(dataReader["fechaCreacion"]),
                            Ancho = Convert.ToDouble(dataReader["anchoMaterial"]),
                            Largo = Convert.ToDouble(dataReader["largoMaterial"]),
                            
                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }

            return listaKardex;
        }

       
    }
}
