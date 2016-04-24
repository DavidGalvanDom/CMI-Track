///Propósito:Controlador para la administracion de tipos de movimeintos de material
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
    public class TipoMovtoMaterialController: Controller
    {
        /// <summary>
        /// Vista principal para el tipo de movimeinto de material
        /// </summary>
        /// <returns>ActionResult</returns>
        public ActionResult Index()
        {
            return View();
        }

        /// <summary>
        /// Carga la coleccion de tipos de movimientos de material
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaTiposMovtoMaterial()
        {
            try
            {
                var lstTiposMovtoMaterial = TipoMovtoMaterialData.CargaTiposMovtoMaterial();

                return (Json(lstTiposMovtoMaterial, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Carga la coleccion de tipos de movimientos de material
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaTiposMovtoMaterialActivos()
        {
            try
            {
                var lstTiposMovtoMaterial = TipoMovtoMaterialData.CargaTiposMovtoMaterialActivos();

                return (Json(lstTiposMovtoMaterial, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Define un nuevo tipo de movimiento de material
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public ActionResult Nuevo()
        {
            var objTipoMovtoMaterial = new Models.TipoMovtoMaterial();
            ViewBag.Titulo = "Nuevo";
            return PartialView("_Nuevo", objTipoMovtoMaterial);
        }

        /// <summary>
        /// Define un nuevo tipo de movimiento de material
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpPost]
        public JsonResult Nuevo(Models.TipoMovtoMaterial pobjModelo)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    var idTipoMovtoMAterial = TipoMovtoMaterialData.Guardar(pobjModelo);
                    return Json(new { Success = true, id = idTipoMovtoMAterial, Message = "Se guardo correctamente el tipo de movimiento de material " });
                }
                catch (Exception exp)
                {
                    return Json(new { Success = false, Message = exp.Message });
                }
            }

            return Json(new { Success = false, Message = "Informacion incompleta" });                     
        }


        /// <summary>
        /// Define un nuevo tipo de movimiento
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public ActionResult Actualiza(string id)
        {
            var objTipoMovtoMaterial = TipoMovtoMaterialData.CargaTipoMovtoMaterial(id);
            return PartialView("_Actualiza", objTipoMovtoMaterial);
        }

        /// <summary>
        /// Define un nuevo tipo de movimiento de material
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpPost]
        public JsonResult Actualiza(Models.TipoMovtoMaterial pobjModelo)
        {            
            if (ModelState.IsValid)
            {
                try
                {                   
                    TipoMovtoMaterialData.Actualiza(pobjModelo);
                    return Json(new { Success = true, id = pobjModelo.id, Message = "Se actualizo correctamente el tipo de movimiento de material " });
                }
                catch (Exception exp)
                {
                    return Json(new { Success = false, Message = exp.Message });
                }
            }

            return Json(new { Success = false, Message = "Información del tipo de movimiento de material esta incompleta" });
        }

        /// <summary>
        /// Define un nuevo tipo de movimiento de material
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public ActionResult Clonar(string id)
        {
            var objTipoMovtoMaterial = TipoMovtoMaterialData.CargaTipoMovtoMaterial(id);
            objTipoMovtoMaterial.id = 0;
            ViewBag.Titulo = "Clonar";

            return PartialView("_Nuevo", objTipoMovtoMaterial);
        }


        /// <summary>
        /// Borra el tipo de movimiento de material
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpPost]
        public JsonResult Borrar(string id)
        {
            try
            {
                TipoMovtoMaterialData.Borrar(id);
                return Json(new { Success = true, Message = "Se borro correctamente el tipo de movimiento de material " });
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message });
            }
        }
    }
}
