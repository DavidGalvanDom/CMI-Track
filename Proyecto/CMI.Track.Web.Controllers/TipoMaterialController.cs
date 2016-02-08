///Propósito:Controlador para la administracion de Tipos de Material
///Fecha creación: 01/Febrero/16
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
    public class TipoMaterialController : Controller
    {
        /// <summary>
        /// Vista principal TipoMaterial
        /// </summary>
        /// <returns>ActionResult</returns>
        public ActionResult Index()
        {
            return View();
        }

        /// <summary>
        /// Carga la coleccion de TipoMaterial
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaTiposMaterial()
        {
            try
            {
                var lstTiposMaterial = TipoMaterialData.CargaTiposMaterial();

                return (Json(lstTiposMaterial, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Carga la coleccion de TipoMaterial
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaTiposMaterialActivos()
        {
            try
            {
                var lstTiposMaterial = TipoMaterialData.CargaTiposMaterialActivos();

                return (Json(lstTiposMaterial, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Define un nuevo TipoMaterial
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public ActionResult Nuevo()
        {
            var objTipoMaterial = new Models.TipoMaterial() { idEstatus = 1 };
            ViewBag.Titulo = "Nuevo";
            return PartialView("_Nuevo", objTipoMaterial);
        }

        /// <summary>
        /// Define un nuevo TipoMaterial
        /// </summary>
        /// <returns>JSonResult</returns>
        [HttpPost]
        public JsonResult Nuevo(Models.TipoMaterial pobjModelo)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    var idTipoMaterial = TipoMaterialData.Guardar(pobjModelo);
                    return Json(new { Success = true, id = idTipoMaterial, Message = "Se guardo correctamente el Tipo de Material " });
                }
                catch (Exception exp)
                {
                    return Json(new { Success = false, Message = exp.Message });
                }
            }

            return Json(new { Success = false, Message = "Informacion incompleta" });                     
        }


        /// <summary>
        /// Actualiza un TipoMaterial
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public ActionResult Actualiza(string id)
        {
            var objTipoMaterial = TipoMaterialData.CargaTipoMaterial(id);
            return PartialView("_Actualiza", objTipoMaterial);
        }

        /// <summary>
        /// Actualiza un TipoMaterial
        /// </summary>
        /// <returns>JSonResult</returns>
        [HttpPost]
        public JsonResult Actualiza(Models.TipoMaterial pobjModelo)
        {            
            if (ModelState.IsValid)
            {
                try
                {
                    TipoMaterialData.Actualiza(pobjModelo);
                    return Json(new { Success = true, id = pobjModelo.id, Message = "Se actualizo correctamente el Tipo de Material" });
                }
                catch (Exception exp)
                {
                    return Json(new { Success = false, Message = exp.Message });
                }
            }

            return Json(new { Success = false, Message = "Información del Tipo Material esta incompleta" });
        }

        /// <summary>
        /// Clona un TipoMaterial
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public ActionResult Clonar(string id)
        {
            var objTipoMaterial = TipoMaterialData.CargaTipoMaterial(id);
            objTipoMaterial.id = 0;
            ViewBag.Titulo = "Clonar";

            return PartialView("_Nuevo", objTipoMaterial);
        }

        /// <summary>
        /// Borra el TipoMaterial
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpPost]
        public JsonResult Borrar(string id)
        {
            try
            {
                TipoMaterialData.Borrar(id);
                return Json(new { Success = true, Message = "Se borro correctamente el Tipo de Material " });
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message });
            }
        }
    }
}
