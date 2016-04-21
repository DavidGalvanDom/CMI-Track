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
