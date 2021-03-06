﻿///Propósito:Controlador para Avances
///Fecha creación: 25/Marzo/16
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
using System.Configuration;

using CMI.Track.Web.Models;
using CMI.Track.Web.Data;

namespace CMI.Track.Web.Controllers
{
    public class AvanceController : Controller
    {
        /// <summary>
        /// Vista principal para Avances
        /// </summary>
        /// <returns>ActionResult</returns>
        public ActionResult Index()
        {
            return View();

        }

        /// <summary>
        /// Carga los elementos de Avance
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargarAvance(int idEtapa, int idProceso, string codigoBarras)
        {
            try
            {
                var lstAvance = AvanceData.CargarAvance(idEtapa, idProceso, codigoBarras);

                return (Json(lstAvance, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Carga los elementos de Revision
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargarRevision(int idEtapa, int idProceso, string codigoBarras)
        {
            try
            {
                var lstAvance = AvanceData.CargarRevision(idEtapa, idProceso, codigoBarras);

                return (Json(lstAvance, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Despliega ventana emergente con el elemento a Avanzar
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public ActionResult MostrarDarAvance()
        {
            return PartialView("_darAvance");
        }

        /// <summary>
        /// Despliega ventana emergente con el elemento a Revisar
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public ActionResult MostrarDarRegistroCalidad()
        {
            return PartialView("_darRegistroCalidad");
        }

        /// <summary>
        /// Da un Avance o un registro de calidad
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpPost]
        public JsonResult InsertarActividadProduccion(Models.ActividadProduccion pobjActividad)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    var resultado = AvanceData.InsertarActividadProduccion(pobjActividad);

                    return Json(new { Success = true, Message = "Se guardo correctamente el Registro de Actividad " });
                }
                catch (Exception exp)
                {
                    return Json(new { Success = false, Message = exp.Message });
                }
            }

            return Json(new { Success = false, Message = "La informacion del Registro de Actividad esta incompleta" });
        }
    }

}
