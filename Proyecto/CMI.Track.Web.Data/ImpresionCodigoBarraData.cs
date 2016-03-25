///Propósito: Acceso a base de datos Codigos de Barra
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
    public  class ImpresionCodigoBarraData
    {

        /// <summary>
        /// Se carga el detalle de una Orden de Produccion
        /// </summary>
        /// <param name="idEtapa"></param>
        /// <param name="tipo"></param>
        /// <returns>Listado del Codigos de Barra</returns>
        public static List<Models.ListaImpresionCodigoBarra> CargaCodigosBarra(int idEtapa, string tipo)
        {
            var lstCodigosBarra = new List<Models.ListaImpresionCodigoBarra>();
            object[] paramArray = new object[2];
            try
            {
                paramArray[0] = idEtapa;
                paramArray[1] = tipo;
                
                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarCodigosBarra", paramArray))
                {
                    while (dataReader.Read())
                    {
                        lstCodigosBarra.Add(new Models.ListaImpresionCodigoBarra()
                        {
                            id          = Convert.ToString(dataReader["codigoBarra"]),
                            tipo        = Convert.ToString(dataReader["tipo"]),
                            idMS        = Convert.ToInt32(dataReader["id"]),
                            codigo      = Convert.ToString(dataReader["codigo"]),
                            serie       = Convert.ToString(dataReader["serie"]),
                            peso        = Convert.ToDouble(dataReader["peso"]),
                            codigoBarra = Convert.ToString(dataReader["codigoBarra"])
                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
            return lstCodigosBarra;
        }
    }
}
