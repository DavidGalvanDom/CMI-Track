///Propósito: Acceso a base de datos Reportes Produccion
///Fecha creación: 04/Abril/2016
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
    public  class ReportesProduccionData
    {

        /// <summary>
        /// Se carga el reporte de Calidad
        /// </summary>
        /// <param name="idProyecto"></param>
        /// <param name="fechaInicio"></param>
        /// <param name="fechaFin"></param>
        /// <returns>Reporte Calidad</returns>
        public static List<Models.ListaReporteProduccionCalidad> CargarReporteProduccionCalidad(int idProyecto, string fechaInicio, string fechaFin)
        {
            var lstReporteCalidad = new List<Models.ListaReporteProduccionCalidad>();
            object[] paramArray = new object[3];
            try
            {
                paramArray[0] = idProyecto;
                paramArray[1] = fechaInicio;
                paramArray[2] = fechaFin;
                
                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarReporteProduccionCalidad", paramArray))
                {
                    while (dataReader.Read())
                    {
                        lstReporteCalidad.Add(new Models.ListaReporteProduccionCalidad()
                        {
                            id = Convert.ToString(dataReader["idRegistroCalidad"]),
                            fecha = Convert.ToString(dataReader["fechaRegistroCalidad"]),
                            proyecto = Convert.ToString(dataReader["nombreProyecto"]),
                            etapa = Convert.ToString(dataReader["nombreEtapa"]),
                            marca = Convert.ToString(dataReader["nombreMarca"]),
                            serie = Convert.ToString(dataReader["idSerie"]),
                            piezas = "1",
                            peso = Convert.ToString(dataReader["pesoMarca"]),
                            proceso = Convert.ToString(dataReader["nombreProceso"]),
                            usuario = Convert.ToString(dataReader["nombreUsuario"]),
                            longitud = Convert.ToString(dataReader["longitudRegistroCalidad"]),
                            barrenacion = Convert.ToString(dataReader["barrenacionRegistroCalidad"]),
                            placa = Convert.ToString(dataReader["placaRegistroCalidad"]),
                            soldadura = Convert.ToString(dataReader["soldaduraRegistroCalidad"]),
                            pintura = Convert.ToString(dataReader["pinturaRegistroCalidad"]),
                            estatus = Convert.ToString(dataReader["nombreEstatus"]),
                            observaciones = Convert.ToString(dataReader["observacionesRegistroCalidad"])
                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
            return lstReporteCalidad;
        }

        /// <summary>
        /// Se carga el reporte de Produccion por Persona
        /// </summary>
        /// <param name="idProyecto"></param>
        /// <param name="fechaInicio"></param>
        /// <param name="fechaFin"></param>
        /// <returns>Reporte Produccion por Persona</returns>
        public static List<Models.ListaReporteProduccionPorPersona> CargarReporteProduccionPorPersona(int idProyecto, string fechaInicio, string fechaFin)
        {
            var lstReporteProduccionPorPersona = new List<Models.ListaReporteProduccionPorPersona>();
            object[] paramArray = new object[3];
            try
            {
                paramArray[0] = idProyecto;
                paramArray[1] = fechaInicio;
                paramArray[2] = fechaFin;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarReporteProduccionPorPersona", paramArray))
                {
                    while (dataReader.Read())
                    {
                        lstReporteProduccionPorPersona.Add(new Models.ListaReporteProduccionPorPersona()
                        {
                            id = Convert.ToString(dataReader["id"]),
                            fecha = Convert.ToString(dataReader["fecha"]),
                            idUsuario = Convert.ToInt32(dataReader["idUsuario"]),
                            usuario = Convert.ToString(dataReader["nombreUsuario"]),
                            idProyecto = Convert.ToInt32(dataReader["idProyecto"]),
                            proyecto = Convert.ToString(dataReader["nombreProyecto"]),
                            etapa = Convert.ToString(dataReader["nombreEtapa"]),
                            clase = Convert.ToString(dataReader["clase"]),
                            elemento = Convert.ToString(dataReader["nombreElemento"]),
                            idSerie = Convert.ToString(dataReader["idSerie"]),
                            proceso = Convert.ToString(dataReader["nombreProceso"]),
                            piezas = Convert.ToInt32(dataReader["piezas"]),
                            peso = Convert.ToString(dataReader["peso"])
                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
            return lstReporteProduccionPorPersona;
        }

        /// <summary>
        /// Se carga el reporte de Produccion Semanal
        /// </summary>
        /// <param name="idProyecto"></param>
        /// <param name="fechaInicio"></param>
        /// <param name="fechaFin"></param>
        /// <returns>Reporte Produccion por Persona</returns>
        public static List<Models.ListaReporteProduccionSemanal> CargarReporteProduccionSemanal(int idProyecto, string fechaInicio, string fechaFin)
        {
            var lstReporteProduccionSemanal = new List<Models.ListaReporteProduccionSemanal>();
            object[] paramArray = new object[3];
            try
            {
                paramArray[0] = idProyecto;
                paramArray[1] = fechaInicio;
                paramArray[2] = fechaFin;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarReporteProduccionSemanal", paramArray))
                {
                    while (dataReader.Read())
                    {
                        lstReporteProduccionSemanal.Add(new Models.ListaReporteProduccionSemanal()
                        {
                            id = Convert.ToString(dataReader["id"]),
                            fecha = Convert.ToString(dataReader["fecha"]),
                            idProyecto = Convert.ToInt32(dataReader["idProyecto"]),
                            proyecto = Convert.ToString(dataReader["nombreProyecto"]),
                            etapa = Convert.ToString(dataReader["nombreEtapa"]),
                            clase = Convert.ToString(dataReader["clase"]),
                            elemento = Convert.ToString(dataReader["nombreElemento"]),
                            idSerie = Convert.ToString(dataReader["idSerie"]),
                            proceso = Convert.ToString(dataReader["nombreProceso"]),
                            piezas = Convert.ToInt32(dataReader["piezas"]),
                            peso = Convert.ToString(dataReader["peso"])
                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
            return lstReporteProduccionSemanal;
        }

        /// <summary>
        /// Se carga el reporte de Produccion Dias Proceso
        /// </summary>
        /// <param name="idProyecto"></param>
        /// <param name="fechaInicio"></param>
        /// <param name="fechaFin"></param>
        /// <returns>Reporte Produccion por Persona</returns>
        public static List<Models.ListaReporteProduccionDiasProceso> CargarReporteProduccionDiasProceso(int idProyecto, string fechaInicio, string fechaFin)
        {
            var lstReporteProduccionDiasProceso = new List<Models.ListaReporteProduccionDiasProceso>();
            object[] paramArray = new object[3];
            try
            {
                paramArray[0] = idProyecto;
                paramArray[1] = fechaInicio;
                paramArray[2] = fechaFin;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarReporteProduccionDiasProceso", paramArray))
                {
                    while (dataReader.Read())
                    {
                        lstReporteProduccionDiasProceso.Add(new Models.ListaReporteProduccionDiasProceso()
                        {
                            id = Convert.ToString(dataReader["IdRegistro"]),
                            idProyecto = Convert.ToInt32(dataReader["IdProyecto"]),
                            proyecto = Convert.ToString(dataReader["NombreProyecto"]),
                            idEtapa = Convert.ToInt32(dataReader["IdEtapa"]),
                            etapa = Convert.ToString(dataReader["NombreEtapa"]),
                            clase = Convert.ToString(dataReader["Clase"]),
                            idElemento = Convert.ToInt32(dataReader["IdMarca_Submarca"]),
                            elemento = Convert.ToString(dataReader["NombreElemento"]),
                            idSerie = Convert.ToString(dataReader["IdSerie"]),
                            piezas = 1,
                            diasProceso = Convert.ToInt32(dataReader["DiasProceso"]),
                            fechaInicio = Convert.ToString(dataReader["FechaInicio"]),
                            peso = Convert.ToString(dataReader["Peso"]),
                            corte = ReportesProduccionData.HasColumn(dataReader, "CORTE") ? Convert.ToString(dataReader["CORTE"]) : "",
                            pantografo = ReportesProduccionData.HasColumn(dataReader, "PANTOGRAFO") ? Convert.ToString(dataReader["PANTOGRAFO"]) : "",
                            ensamble = ReportesProduccionData.HasColumn(dataReader, "ENSAMBLE") ? Convert.ToString(dataReader["ENSAMBLE"]) : "",
                            calidadEnsamble = ReportesProduccionData.HasColumn(dataReader, "CALIDAD ENSAMBLE") ? Convert.ToString(dataReader["CALIDAD ENSAMBLE"]) : "",
                            soldadura = ReportesProduccionData.HasColumn(dataReader, "SOLDADURA") ? Convert.ToString(dataReader["SOLDADURA"]) : "",
                            calidadSoldadura = ReportesProduccionData.HasColumn(dataReader, "CALIDAD SOLDADURA") ? Convert.ToString(dataReader["CALIDAD SOLDADURA"]) : "",
                            limpieza = ReportesProduccionData.HasColumn(dataReader, "LIMPIEZA") ? Convert.ToString(dataReader["LIMPIEZA"]) : "",
                            pintura = ReportesProduccionData.HasColumn(dataReader, "PINTURA") ? Convert.ToString(dataReader["PINTURA"]) : "",
                            calidadFinal = ReportesProduccionData.HasColumn(dataReader, "CALIDAD FINAL") ? Convert.ToString(dataReader["CALIDAD FINAL"]) : ""
                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
            return lstReporteProduccionDiasProceso;
        }

        /// <summary>
        /// Se carga el reporte de Produccion Estatus Proyecto
        /// </summary>
        /// <param name="idProyecto"></param>
        /// <returns>Reporte Produccion por Persona</returns>
        public static List<Models.ListaReporteProduccionEstatusProyecto> CargarReporteProduccionEstatusProyecto(int idProyecto)
        {
            var lstReporteProduccionEstatusProyecto = new List<Models.ListaReporteProduccionEstatusProyecto>();
            object[] paramArray = new object[1];
            try
            {
                paramArray[0] = idProyecto;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarReporteProduccionEstatusProyecto", paramArray))
                {
                    while (dataReader.Read())
                    {
                        lstReporteProduccionEstatusProyecto.Add(new Models.ListaReporteProduccionEstatusProyecto()
                        {
                            id = Convert.ToString(dataReader["id"]),
                            proceso = Convert.ToString(dataReader["proceso"]),
                            categoria = Convert.ToString(dataReader["categoria"]),
                            proyecto = Convert.ToString(dataReader["proyecto"]),
                            etapa = Convert.ToString(dataReader["etapa"]),
                            planoMontaje = Convert.ToString(dataReader["planoMontaje"]),
                            planoDespiece = Convert.ToString(dataReader["planoDespiece"]),
                            marca = Convert.ToString(dataReader["marca"]),
                            serie = Convert.ToString(dataReader["serie"]),
                            diasProceso = Convert.ToString(dataReader["diasProceso"]),
                            piezas = Convert.ToString(dataReader["piezas"]),
                            peso = Convert.ToString(dataReader["peso"])
                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
            return lstReporteProduccionEstatusProyecto;
        }

        /// <summary>
        /// Se carga el reporte de Produccion Avance Proyecto
        /// </summary>
        /// <param name="idProyecto"></param>
        /// <returns>Reporte Produccion por Persona</returns>
        public static List<Models.ListaReporteProduccionAvanceProyecto> CargarReporteProduccionAvanceProyecto(int idProyecto)
        {
            var lstReporteProduccionAvanceProyecto = new List<Models.ListaReporteProduccionAvanceProyecto>();
            object[] paramArray = new object[1];
            try
            {
                paramArray[0] = idProyecto;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarReporteProduccionAvanceProyecto", paramArray))
                {
                    while (dataReader.Read())
                    {
                        lstReporteProduccionAvanceProyecto.Add(new Models.ListaReporteProduccionAvanceProyecto()
                        {
                            id = Convert.ToString(dataReader["IdRegistro"]),
                            etapa = Convert.ToString(dataReader["NombreEtapa"]),
                            planoMontaje = Convert.ToString(dataReader["NombrePlanoMontaje"]),
                            avance = Convert.ToString(dataReader["Avance"]) + "%",
                            fechaIni = Convert.ToDouble(dataReader["Avance"]) == 0 ? "" : Convert.ToString(dataReader["FechaInicio"]),
                            fechaFin = Convert.ToDouble(dataReader["Avance"]) < 100 ? "" : Convert.ToString(dataReader["FechaFin"])
                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
            return lstReporteProduccionAvanceProyecto;
        }

        public static bool HasColumn(IDataReader Reader, string ColumnName) {
            foreach (DataRow row in Reader.GetSchemaTable().Rows) {
                if (row["ColumnName"].ToString() == ColumnName) return true;
            } 
            return false;
        }

    }
}
