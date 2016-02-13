///Propósito:Controlador para la administracion de origenes
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
    public class OrigenRequisicionController: Controller
    {
        /// <summary>
        /// Vista principal para el origen de la req
        /// </summary>
        /// <returns>ActionResult</returns>
        public ActionResult Index()
        {
            return View();
        }

        /// <summary>
        /// Carga la coleccion de origenes
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaOrigenesRequisicion()
        {
            try
            {
                var lstOrigenReq = OrigenRequisicionData.CargaOrigenesRequisicion();

                return (Json(lstOrigenReq, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Carga la coleccion de origenes
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaOrigenesRequisicionActivas()
        {
            try
            {
                var lstOrigenReq = OrigenRequisicionData.CargaOrigenesReqActivas();

                return (Json(lstOrigenReq, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Define un nuevo origen
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public ActionResult Nuevo()
        {
            var objOrigenReq = new Models.OrigenRequisicion() { Estatus = "Activo" };
            ViewBag.Titulo = "Nuevo";
            return PartialView("_Nuevo", objOrigenReq);
        }

        /// <summary>
        /// Define un nuevo origen
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpPost]
        public JsonResult Nuevo(Models.OrigenRequisicion pobjModelo)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    var idOrigenReq = OrigenRequisicionData.Guardar(pobjModelo);
                    return Json(new { Success = true, id = idOrigenReq, Message = "Se guardo correctamente el origen de la requisicion " });
                }
                catch (Exception exp)
                {
                    return Json(new { Success = false, Message = exp.Message });
                }
            }

            return Json(new { Success = false, Message = "Informacion incompleta" });                     
        }


        /// <summary>
        /// Define un nuevo origen
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public ActionResult Actualiza(string id)
        {
            var idOrigenReq = OrigenRequisicionData.CargaOrigenRequisicion(id);
            return PartialView("_Actualiza", idOrigenReq);
        }

        /// <summary>
        /// Define un nuevo origen
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpPost]
        public JsonResult Actualiza(Models.OrigenRequisicion pobjModelo)
        {            
            if (ModelState.IsValid)
            {
                try
                {                   
                    OrigenRequisicionData.Actualiza(pobjModelo);
                    return Json(new { Success = true, id = pobjModelo.id, Message = "Se actualizo correctamente el origen de la requisicion " });
                }
                catch (Exception exp)
                {
                    return Json(new { Success = false, Message = exp.Message });
                }
            }

            return Json(new { Success = false, Message = "Información del origen esta incompleta" });
        }

        /// <summary>
        /// Define un nuevo origen
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public ActionResult Clonar(string id)
        {
            var objOrigenReq = OrigenRequisicionData.CargaOrigenRequisicion(id);
            objOrigenReq.id = 0;
            ViewBag.Titulo = "Clonar";

            return PartialView("_Nuevo", objOrigenReq);
        }


        /// <summary>
        /// Borra el origen
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpPost]
        public JsonResult Borrar(string id)
        {
            try
            {
                OrigenRequisicionData.Borrar(id);
                return Json(new { Success = true, Message = "Se borro correctamente el origen de la requisicion " });
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message });
            }
        }
    }
}
