///Propósito: Datos de REcepcion Requicision Compra
///Fecha creación: 28/Marzo/2016
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
    public class RecepcionRequisicionData
    {
        /// <summary>
        /// Se carga el listado del detalle de la requisicion
        /// </summary>
        /// <returns>Lista Detalle</returns>
        public static List<Models.ListaRecepcionRequisicion> CargaDetalleRequisicion(int idProyecto, int idEtapa, int idRequerimiento, int idRequisicion)
        {
            var listaDetalleRequisicion = new List<Models.ListaRecepcionRequisicion>();
            object[] paramArray = new object[4];
            try
            {
                paramArray[0] = idProyecto;
                paramArray[1] = idEtapa;
                paramArray[2] = idRequerimiento;
                paramArray[3] = idRequisicion;
                
                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarRecepcionCompra", paramArray))
                {
                    while (dataReader.Read())
                    {
                        listaDetalleRequisicion.Add(new Models.ListaRecepcionRequisicion()
                        {
                            id = Convert.ToInt32(dataReader["idDetalleRequisicion"]),
                            idMaterial = Convert.ToInt32(dataReader["idMaterial"]),
                            nombreMaterial = Convert.ToString(dataReader["nombreMaterial"]),
                            UM = Convert.ToString(dataReader["nombreCortoUnidadMedida"]),
                            Calidad = Convert.ToString(dataReader["calidadMaterial"]),
                            Ancho = Convert.ToInt32(dataReader["anchoMaterial"]),
                            Largo = Convert.ToInt32(dataReader["largoMaterial"]),
                            cantidadSol = Convert.ToInt32(dataReader["cantidadSolicitada"]),
                            Existencia = Convert.ToInt32(dataReader["cantidadInventario"]),
                            cantidadRecibida = Convert.ToInt32(dataReader["cantidadRecibida"]),
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

            return listaDetalleRequisicion;
        }

        /// <summary>
        /// Se actuliza la informacion de la requisicion
        /// </summary>
        /// <param name="pobjModelo">Datos de la requisicion</param>
        /// <returns>value</returns>
        public static string Actualiza(Models.RecepcionRequisicion pobjModelo)
        {
            object[] paramArray = new object[10];
            try
            {
                paramArray[0] = pobjModelo.idMaterialR;
                paramArray[1] = pobjModelo.cantidadRecibida;
                paramArray[2] = pobjModelo.Serie.ToUpper();
                paramArray[3] = pobjModelo.Factura.ToUpper();
                paramArray[4] = pobjModelo.Proveedor.ToUpper();
                paramArray[5] = pobjModelo.FechaFac.ToUpper();
                paramArray[6] = pobjModelo.idRequerimiento;
                paramArray[7] = pobjModelo.idRequisicionF;
                paramArray[8] = pobjModelo.idItem;
                paramArray[9] = pobjModelo.usuarioCreacion;  

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteNonQuery("usp_ActualizarCantidadRecibida", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }      
    }
}
