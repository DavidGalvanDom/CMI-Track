///Propósito: Acceso a base de datos Etapas
///Fecha creación: 19/Febrero/2016
///Creador: Juan Lopepe
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
    public  class OrdenProduccionData
    {

        /// <summary>
        /// Se carga el detalle de una Orden de Produccion
        /// </summary>
        /// <param name="idEtapa"></param>
        /// <param name="idEstatusEtapa"></param>
        /// <param name="idEstatus"></param>
        /// <param name="clase"></param>
        /// <returns>Listado del Detalle de una Orden de Produccion</returns>
        public static List<Models.ListaDetalleOrdenProduccion> CargaDetalleOrdenProduccion(int idEtapa, int? idEstatusEtapa, int? idEstatus, string clase)
        {
            var lstDetalleOrdenProduccion = new List<Models.ListaDetalleOrdenProduccion>();
            object[] paramArray = new object[4];
            try
            {
                paramArray[0] = idEtapa;
                paramArray[1] = idEstatusEtapa;
                paramArray[2] = idEstatus;
                paramArray[3] = clase;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarDetalleOrdenProduccion", paramArray))
                {
                    while (dataReader.Read())
                    {
                        lstDetalleOrdenProduccion.Add(new Models.ListaDetalleOrdenProduccion()
                        {
                            seccion     = Convert.ToString(dataReader["seccion"]),
                            tipo        = Convert.ToString(dataReader["tipo"]),
                            pieza       = Convert.ToInt32(dataReader["pieza"]),
                            marca       = Convert.ToString(dataReader["marca"]),
                            serie       = Convert.ToString(dataReader["serie"]),
                            submarca    = Convert.ToString(dataReader["submarca"]),
                            perfil      = Convert.ToString(dataReader["perfil"]),
                            piezas      = Convert.ToInt32(dataReader["piezas"]),
                            numCorte    = Convert.ToString(dataReader["numCorte"]),
                            longitud    = Convert.ToDouble(dataReader["longitud"]),
                            ancho       = Convert.ToDouble(dataReader["ancho"]),
                            grado       = Convert.ToString(dataReader["grado"]),
                            kgm         = Convert.ToDouble(dataReader["kgm"]),
                            totalLA     = Convert.ToDouble(dataReader["totalLA"]),
                            total       = Convert.ToDouble(dataReader["total"]),
                            numPlano    = Convert.ToString(dataReader["numPlano"]),
                            peso        = Convert.ToDouble(dataReader["peso"])
                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
            return lstDetalleOrdenProduccion;
        }
    }
}
