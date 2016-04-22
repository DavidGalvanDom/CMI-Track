///Propósito: Acceso a base de datos OrdenEmbarque
///Fecha creación: 20/Abril/2016
///Creador: David Galvan
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
    public class OrdenEmbarqueData
    {
        /// <summary>
        /// Se registra la Marca de acuerdo a la serie
        /// </summary>
        /// <param name="idDetaOrdenEmb"></param>
        /// <param name="idMarca"></param>
        /// <param name="serie"></param>
        /// <param name="origen"></param>
        /// <returns></returns>
        public static string  GenerarEmbarque (int idDetaOrdenEmb, int idMarca,
                                              string serie, string origen, int idUsuario)
        {
            string resultado = "";
            object[] paramArray = new object[5];
            try
            {
                paramArray[0] = idDetaOrdenEmb;
                paramArray[1] = idMarca;
                paramArray[2] = serie;
                paramArray[3] = origen;
                paramArray[4] = idUsuario;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteScalar("usp_RegistraEmbarque", paramArray);

                if (result != null)
                {
                    resultado = result.ToString();
                }

            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }

            return resultado;
        }

        /// <summary>
        /// Se carga la lista del detalle de Orden de Embarque
        /// </summary>
        /// <param name="idOrdenEmbarque"></param>
        /// <returns></returns>
        public static List<Models.DetalleOrdenEmbarque> CargarDetalleOrdenEmbarque(int idOrdenEmbarque)
        {
            var lstDetalleOrdEmbar = new List<Models.DetalleOrdenEmbarque>();
            object[] paramArray = new object[1];
            try
            {
                paramArray[0] = idOrdenEmbarque;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarDetalleOrdenEmbar", paramArray))
                {
                    while (dataReader.Read())
                    {

                        lstDetalleOrdEmbar.Add(new Models.DetalleOrdenEmbarque()
                        {
                            id = Convert.ToInt32(dataReader["idDetalleOrdenEmbarque"]),
                            idOrdenEmbarque = Convert.ToInt32(dataReader["idOrdenEmbarque"]),
                            idMarca = Convert.ToInt32(dataReader["idMarca"]),
                            claveEtapa = Convert.ToString(dataReader["claveEtapa"]),
                            nombreProyecto = Convert.ToString(dataReader["nombreProyecto"]),
                            nombreMarca = Convert.ToString(dataReader["codigoMarca"]),
                            nombrePlano = Convert.ToString(dataReader["codigoPlanoMontaje"]),
                            piezas = Convert.ToInt32(dataReader["piezasMarca"]),
                            piezasLeidas = Convert.ToInt32(dataReader["piezasLeidas"]),
                            peso = Convert.ToDouble(dataReader["pesoMarca"]),
                            pesoTotal = Convert.ToDouble(dataReader["pesoMarca"]) * Convert.ToInt32(dataReader["piezasMarca"]),
                            Saldo = Convert.ToInt32(dataReader["piezasMarca"]) - Convert.ToInt32(dataReader["piezasLeidas"])
                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }

            return lstDetalleOrdEmbar;
        }

        /// <summary>
        /// Se carga la lista de Ordenes de Embarque de acuerdo al criterio de busqueda
        /// </summary>
        /// <param name="idProyecto"></param>
        /// <param name="revision"></param>
        /// <param name="idEtapa"></param>
        /// <param name="idEstatus"></param>
        /// <returns></returns>
        public static List<Models.ListaOrdenEmbarque> CargarOrdenesEmbarque(int idProyecto, string revision, 
                                                                        int idEtapa, int? idEstatus)
        {
            var lstOrdenesEmbarque = new List<Models.ListaOrdenEmbarque>();
            object[] paramArray = new object[4];
            try
            {
                paramArray[0] = idProyecto;
                paramArray[1] = revision;
                paramArray[2] = idEtapa;
                paramArray[3] = idEstatus;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarOrdenesEmbarque", paramArray))
                {
                    while (dataReader.Read())
                    {

                        lstOrdenesEmbarque.Add(new Models.ListaOrdenEmbarque()
                        {
                            id = Convert.ToInt32(dataReader["idOrdenEmbarque"]),
                            idOrdenProduccion = Convert.ToInt32(dataReader["idOrdenProduccion"]),
                            observacionOrdenEmbarque = Convert.ToString(dataReader["observacionOrdenEmbarque"]),
                            fechaCreacion = Convert.ToString(dataReader["fechaCreacion"])
                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }

            return lstOrdenesEmbarque;
        }
    }
}
