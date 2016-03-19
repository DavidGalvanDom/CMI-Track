///Propósito:Controlador para la administracion de reportes
///Fecha creación: 02/Marzo/16
///Creador: David Jasso
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
    public class ReporteController: Controller
    {
        /// <summary>
        /// Vista principal para la categoria
        /// </summary>
        /// <returns>ActionResult</returns>
        public ActionResult Index()
        {
            return View();
        }

        /// <summary>
        /// Carga la coleccion de infor REquerimiento
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaInfoRequerimiento(int idProyecto, int idEtapa, int idRequerimiento)
        {
            try
            {
                var lstlistaRptRequerimientos = ReporteData.CargaInfoRequerimiento(idProyecto, idEtapa, idRequerimiento);

                return (Json(lstlistaRptRequerimientos, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Carga la coleccion de infor Requisicion
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaInfoRequisicion(int idProyecto, int idEtapa, int idRequerimiento)
        {
            try
            {
                var lstlistaRptRequisicion = ReporteData.CargaInfoRequisicion(idProyecto, idEtapa, idRequerimiento);

                return (Json(lstlistaRptRequisicion, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

    }
}
