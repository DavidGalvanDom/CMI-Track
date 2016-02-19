///Propósito: Acceso a base de datos Etapas
///Fecha creación: 18/Febrero/2016
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
    public  class EtapaData
    {

        /// <summary>
        /// Se carga el listado de Etapas
        /// </summary>
        /// <param name="idProyecto"></param>
        /// <param name="revision"></param>
        /// <param name="idEstatus"></param>
        /// <returns>Lista Usuarios</returns>
        public static List<Models.ListaEtapas> CargaEtapas(int idProyecto, string revision ,int? idEstatus)
        {
            var lstEtapas = new List<Models.ListaEtapas>();
            object[] paramArray = new object[4];
            try
            {
                paramArray[0] = idProyecto;
                paramArray[1] = revision;
                paramArray[2] = null;
                paramArray[3] = idEstatus;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarEtapas", paramArray))
                {
                    while (dataReader.Read())
                    {
                        lstEtapas.Add(new Models.ListaEtapas()
                        {
                            id = Convert.ToInt32(dataReader["idEtapa"]),
                            nombreEtapa = Convert.ToString(dataReader["nombreProyecto"]),                            
                            nombreEstatus = Convert.ToString(dataReader["nombreEstatus"]),
                            fechaFin = Convert.ToString(dataReader["fechaFinProyecto"]),
                            fechaInicio = Convert.ToString(dataReader["fechaInicioProyecto"])
                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }

            return lstEtapas;
        }

        /// <summary>
        /// Se guarda la informacion de una nueva Etapa
        /// </summary>
        /// <param name="pobjModelo">Datos de la nueva Etapa</param>
        /// <returns>value</returns>
        public static string Guardar(Models.Etapa pobjModelo)
        {
            object[] paramArray = new object[8];
            try
            {
                paramArray[0] = pobjModelo.estatusEtapa;
                paramArray[1] = pobjModelo.nombreEtapa.ToUpper();
                paramArray[2] = pobjModelo.fechaInicio.ToUpper();
                paramArray[3] = pobjModelo.fechaFin.ToUpper();
                paramArray[4] = pobjModelo.idProyecto;
                paramArray[5] = pobjModelo.revisionProyecto.ToUpper();                
                paramArray[6] = pobjModelo.infoGeneral.ToUpper();
                paramArray[7] = pobjModelo.usuarioCreacion;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteScalar("usp_InsertarEtapa", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }
    }
}
