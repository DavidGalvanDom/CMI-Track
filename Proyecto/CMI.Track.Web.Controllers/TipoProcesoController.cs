///Propósito:Controlador para la administracion de tipos de proceso
///Fecha creación: 02/Febrero/16
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
    public class TipoProcesoController: Controller
    {
        /// <summary>
        /// Vista principal para el tipo de proceso
        /// </summary>
        /// <returns>ActionResult</returns>
        public ActionResult Index()
        {
            return View();
        }

        /// <summary>
        /// Carga la coleccion de tipos de proceso
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaTiposProceso()
        {
            try
            {
                var lstTiposProceso = TipoProcesoData.CargaTiposProceso();

                return (Json(lstTiposProceso, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Carga la coleccion de tipos de proceso
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaTiposProcesoActivos()
        {
            try
            {
                var lstTiposProceso = TipoProcesoData.CargaTiposProcesoActivos();

                return (Json(lstTiposProceso, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Define un nuevo tipo de proceso
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public ActionResult Nuevo()
        {
            var objTipoProceso = new Models.TipoProceso() { Estatus = "Activo" };
            ViewBag.Titulo = "Nuevo";
            return PartialView("_Nuevo", objTipoProceso);
        }

        /// <summary>
        /// Define un nuevo tipo de proceso
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpPost]
        public JsonResult Nuevo(Models.TipoProceso pobjModelo)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    var idTipoProceso = TipoProcesoData.Guardar(pobjModelo);
                    return Json(new { Success = true, id = idTipoProceso, Message = "Se guardo correctamente el tipo de proceso " });
                }
                catch (Exception exp)
                {
                    return Json(new { Success = false, Message = exp.Message });
                }
            }

            return Json(new { Success = false, Message = "Informacion incompleta" });                     
        }


        /// <summary>
        /// Define un nuevo tipo de proceso
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public ActionResult Actualiza(string id)
        {
            var objTipoProceso = TipoProcesoData.CargaTipoProceso(id);
            return PartialView("_Actualiza", objTipoProceso);
        }

        /// <summary>
        /// Define un nuevo tipo de proceso
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpPost]
        public JsonResult Actualiza(Models.TipoProceso pobjModelo)
        {            
            if (ModelState.IsValid)
            {
                try
                {                   
                    TipoProcesoData.Actualiza(pobjModelo);
                    return Json(new { Success = true, id = pobjModelo.id, Message = "Se actualizo correctamente el tipo de proceso " });
                }
                catch (Exception exp)
                {
                    return Json(new { Success = false, Message = exp.Message });
                }
            }

            return Json(new { Success = false, Message = "Información del tipo de proceso esta incompleta" });
        }

        /// <summary>
        /// Define un nuevo tipo de proceso
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public ActionResult Clonar(string id)
        {
            var objTipoProceso = TipoProcesoData.CargaTipoProceso(id);
            objTipoProceso.id = 0;
            ViewBag.Titulo = "Clonar";

            return PartialView("_Nuevo", objTipoProceso);
        }


        /// <summary>
        /// Borra el tipo de proceso
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpPost]
        public JsonResult Borrar(string id)
        {
            try
            {
                TipoProcesoData.Borrar(id);
                return Json(new { Success = true, Message = "Se borro correctamente el tipo de proceso " });
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message });
            }
        }
    }
}
