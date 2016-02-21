///Propósito: Acceso a base de datos Planos Montaje
///Fecha creación: 20/Febrero/2016
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
    public class PlanosMontajeData
    {
        /// <summary>
        /// Se carga el listado de Planos Montaje
        /// </summary>
        /// <param name="idEtapa"></param>
        /// <param name="idEstatus"></param>
        /// <returns>Lista de Etapas</returns>
        public static List<Models.ListaPlanosMontaje> CargaPlanosMontaje(int idEtapa,  int? idEstatus)
        {
            var lstPlanosMontaje = new List<Models.ListaPlanosMontaje>();
            object[] paramArray = new object[3];
            try
            {
                paramArray[0] = idEtapa;
                paramArray[1] = null;
                paramArray[2] = idEstatus;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarPlanosMontaje", paramArray))
                {
                    while (dataReader.Read())
                    {
                        lstPlanosMontaje.Add(new Models.ListaPlanosMontaje()
                        {
                            id = Convert.ToInt32(dataReader["idPlanoMontaje"]),
                            nombrePlanoMontaje = Convert.ToString(dataReader["nombrePlanoMontaje"]),
                            nombreEstatus = Convert.ToString(dataReader["nombreEstatus"]),
                            fechaFin = Convert.ToString(dataReader["fechaFinPlanoMontaje"]),
                            fechaInicio = Convert.ToString(dataReader["fechaInicioPlanoMontaje"]),
                            archivoPlanoMontaje = Convert.ToString(dataReader["archivoPlanoMontaje"])
                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
            return lstPlanosMontaje;
        }
    }
}
