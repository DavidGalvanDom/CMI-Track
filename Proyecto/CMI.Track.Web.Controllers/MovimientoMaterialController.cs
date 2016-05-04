///Propósito:Controlador para la administracion de movimientos de materiales
///Fecha creación: 02/Abril/16
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
    public class MovimientoMaterialController: Controller
    {
        /// <summary>
        /// Vista principal para movimeintos de material
        /// </summary>
        /// <returns>ActionResult</returns>
        public ActionResult Index()
        {
            return View();
        }

        /// <summary>
        /// Carga la coleccion de movimientos
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaMovimientos(string id)
        {
            try
            {
                var lstMovtos = MovimientoMaterialData.CargaMovimientos(id);

                return (Json(lstMovtos, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Carga la coleccion de movimientos
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaHeaderMovimientos(string id)
        {
            try
            {
                var lstMovtos = MovimientoMaterialData.CargaHeaderMovtos(id);

                return (Json(lstMovtos, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

         /// <summary>
        /// Carga la coleccion de movimientos
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaDocumentos()
        {
            try
            {
                var lstMovtos = MovimientoMaterialData.CargaDocumentos();

                return (Json(lstMovtos, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Carga la coleccion de tipos de movimientos
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaTiposMovimientos()
        {
            try
            {
                var lstMovtos = MovimientoMaterialData.CargaTiposMovimientos();

                return (Json(lstMovtos, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Define un nuevo 
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public ActionResult Nuevo()
        {
            var objMovtoM = new Models.MovimientoMaterial();
            ViewBag.Titulo = "Nuevo";
            return PartialView("_Nuevo", objMovtoM);

        }

        /// <summary>
        /// Define un nuevo 
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpPost]
        public JsonResult Nuevo(Models.MovimientoMaterial pobjModelo)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    var idMaterial = MovimientoMaterialData.Guardar(pobjModelo);
                    return Json(new { Success = true, id = idMaterial, Message = "Se guardo correctamente el material " });
                }
                catch (Exception exp)
                {
                    return Json(new { Success = false, Message = exp.Message });
                }
            }

            return Json(new { Success = false, Message = "Informacion incompleta" });                     
        }



    }
}
