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
                            Existencia = Convert.ToInt32(dataReader["Saldo"]),
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
            var result = 0;
            try
            {
                

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
        

                foreach (var valor in pobjModelo.lstMS)
                {
          
                    paramArray[0] = valor.Split(',')[0]; //Material
                    paramArray[1] = valor.Split(',')[1]; //Cantidad Recibida
                    paramArray[2] = valor.Split(',')[2]; //Serie
                    paramArray[3] = valor.Split(',')[3]; //Factura
                    paramArray[4] = valor.Split(',')[4]; //Proveedro
                    paramArray[5] = valor.Split(',')[5]; //FechaFac
                    paramArray[6] = valor.Split(',')[6]; //idRequerimiento
                    paramArray[7] = valor.Split(',')[7]; //idRequisicion
                    paramArray[8] = valor.Split(',')[8]; //Item
                    paramArray[9] = valor.Split(',')[9]; //usuarioCreacion

                    result = db.ExecuteNonQuery("usp_ActualizarCantidadRecibida", paramArray);
                }

            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
            return (Convert.ToString(result));


        }      
    }
}
