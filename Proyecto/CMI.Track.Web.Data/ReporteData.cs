///Propósito: Datos de Reprotes
///Fecha creación: 02/Marzo/2016
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
    public class ReporteData
    {
        /// <summary>
        /// Se carga el reporte de requerimiento
        /// </summary>
        /// <returns>Lista Requerimiento</returns>
        public static List<Models.ListaReporte> CargaInfoRequerimiento(int idProyecto, int idEtapa, int idRequerimiento)
        {
            var listaRptRequerimiento = new List<Models.ListaReporte>();
            object[] paramArray = new object[3];
            try
            {
                paramArray[0] = idProyecto;
                paramArray[1] = idEtapa;
                paramArray[2] = idRequerimiento;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarRptRequerimiento", paramArray))
                {
                    while (dataReader.Read())
                    {
                        listaRptRequerimiento.Add(new Models.ListaReporte()
                        {
                            id = Convert.ToInt32(dataReader["idProyecto"]),
                            NombreProyecto = Convert.ToString(dataReader["nombreProyecto"]),
                            idEtapa = Convert.ToInt32(dataReader["idEtapa"]),
                            NombreEtapa = Convert.ToString(dataReader["nombreEtapa"]),
                            FolioRequerimiento = Convert.ToString(dataReader["folioRequerimiento"]),
                            NombreDepto = Convert.ToString(dataReader["nombreDepartamento"]),
                            NomnreUsuario = Convert.ToString(dataReader["nombreUsuario"]),
                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }

            return listaRptRequerimiento;
        }

        /// <summary>
        /// Se carga el reporte de requisiciones
        /// </summary>
        /// <returns>Lista Requerimiento</returns>
        public static List<Models.ListaReporte> CargaInfoRequisicion(int idProyecto, int idEtapa, int idRequerimiento)
        {
            var listaRptRequerimiento = new List<Models.ListaReporte>();
            object[] paramArray = new object[3];
            try
            {
                paramArray[0] = idProyecto;
                paramArray[1] = idEtapa;
                paramArray[2] = idRequerimiento;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarRptRequisicion", paramArray))
                {
                    while (dataReader.Read())
                    {
                        listaRptRequerimiento.Add(new Models.ListaReporte()
                        {
                            id = Convert.ToInt32(dataReader["idProyecto"]),
                            NombreProyecto = Convert.ToString(dataReader["nombreProyecto"]),
                            idEtapa = Convert.ToInt32(dataReader["idEtapa"]),
                            NombreEtapa = Convert.ToString(dataReader["nombreEtapa"]),
                            FolioRequerimiento = Convert.ToString(dataReader["folioRequisicion"]),
                            NombreDepto = Convert.ToString(dataReader["nombreDepartamento"]),
                            NomnreUsuario = Convert.ToString(dataReader["nombreUsuario"]),
                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }

            return listaRptRequerimiento;
        }

       
    }
}
