///Propósito:Controlador para la administracion de reportes de Produccion
///Fecha creación: 04/Abril/16
///Creador: Juan Lopepe
///Fecha modifiacción: 
///Modificó:
///Dependencias de conexiones e interfaces: 

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.IO;

using CMI.Track.Web.Models;
using CMI.Track.Web.Data;


namespace CMI.Track.Web.Controllers
{
    public class ReportesProduccionController: Controller
    {
        /// <summary>
        /// Vista principal
        /// </summary>
        /// <returns>ActionResult</returns>
        public ActionResult Index()
        {
            return View();
        }

        /// <summary>
        /// Carga Reporte Calidad
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargarReporteProduccionCalidad(int idProyecto, string fechaInicio, string fechaFin)
        {
            try
            {
                var lstReporteProduccionCalidad = ReportesProduccionData.CargarReporteProduccionCalidad(idProyecto, fechaInicio, fechaFin);

                return (Json(lstReporteProduccionCalidad, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Carga Reporte Produccion por Persona
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargarReporteProduccionPorPersona(int idProyecto, string fechaInicio, string fechaFin)
        {
            try
            {
                var lstReporteProduccionPorPersona = ReportesProduccionData.CargarReporteProduccionPorPersona(idProyecto, fechaInicio, fechaFin);

                return (Json(lstReporteProduccionPorPersona, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Carga Reporte Produccion Semanal
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargarReporteProduccionSemanal(int idProyecto, string fechaInicio, string fechaFin)
        {
            try
            {
                var lstReporteProduccionSemanal = ReportesProduccionData.CargarReporteProduccionSemanal(idProyecto, fechaInicio, fechaFin);

                return (Json(lstReporteProduccionSemanal, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Carga Reporte Produccion Dias Proceso
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargarReporteProduccionDiasProceso(int idProyecto, string fechaInicio, string fechaFin)
        {
            try
            {
                var lstReporteProduccionDiasProceso = ReportesProduccionData.CargarReporteProduccionDiasProceso(idProyecto, fechaInicio, fechaFin);

                return (Json(lstReporteProduccionDiasProceso, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Carga Reporte Produccion Estatus Proyecto
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargarReporteProduccionEstatusProyecto(int idProyecto)
        {
            try
            {
                var lstReporteProduccionEstatusProyecto = ReportesProduccionData.CargarReporteProduccionEstatusProyecto(idProyecto);

                return (Json(lstReporteProduccionEstatusProyecto, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Carga Reporte Produccion Avance Proyecto
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargarReporteProduccionAvanceProyecto(int idProyecto)
        {
            try
            {
                var lstReporteProduccionAvanceProyecto = ReportesProduccionData.CargarReporteProduccionAvanceProyecto(idProyecto);

                return (Json(lstReporteProduccionAvanceProyecto, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

    }


}
