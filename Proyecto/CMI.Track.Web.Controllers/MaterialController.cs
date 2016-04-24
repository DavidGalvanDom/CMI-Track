///Propósito:Controlador para la administracion de materiales
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
    public class MaterialController: Controller
    {
        /// <summary>
        /// Vista principal para los materiales
        /// </summary>
        /// <returns>ActionResult</returns>
        public ActionResult Index()
        {
            return View();
        }

        /// <summary>
        /// Carga la coleccion de materiales
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaMateriales()
        {
            try
            {
                var lstMateriales = MaterialData.CargaMateriales();

                return (Json(lstMateriales, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Carga la coleccion de materiales
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaMaterialesActivos()
        {
            try
            {
                var lstMateriales = MaterialData.CargaMaterialesActivos();

                return (Json(lstMateriales, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Define un nuevo material
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public ActionResult Nuevo()
        {
            var objMaterial = new Models.Material();
            ViewBag.Titulo = "Nuevo";
            return PartialView("_Nuevo", objMaterial);
        }

        /// <summary>
        /// Define un nuevo material
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpPost]
        public JsonResult Nuevo(Models.Material pobjModelo)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    var idMaterial = MaterialData.Guardar(pobjModelo);
                    return Json(new { Success = true, id = idMaterial, Message = "Se guardo correctamente el material " });
                }
                catch (Exception exp)
                {
                    return Json(new { Success = false, Message = exp.Message });
                }
            }

            return Json(new { Success = false, Message = "Informacion incompleta" });                     
        }


        /// <summary>
        /// Define un nuevo material
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public ActionResult Actualiza(string id)
        {
            var objMaterial = MaterialData.CargaMaterial(id);
            return PartialView("_Actualiza", objMaterial);
        }

        /// <summary>
        /// Define un nuevo material
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpPost]
        public JsonResult Actualiza(Models.Material pobjModelo)
        {            
            if (ModelState.IsValid)
            {
                try
                {                   
                    MaterialData.Actualiza(pobjModelo);
                    return Json(new { Success = true, id = pobjModelo.id, Message = "Se actualizo correctamente el material " });
                }
                catch (Exception exp)
                {
                    return Json(new { Success = false, Message = exp.Message });
                }
            }

            return Json(new { Success = false, Message = "Información del material esta incompleta" });
        }

        /// <summary>
        /// Define un nuevo material
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public ActionResult Clonar(string id)
        {
            var objMaterial = MaterialData.CargaMaterial(id);
            objMaterial.id = 0;
            ViewBag.Titulo = "Clonar";

            return PartialView("_Nuevo", objMaterial);
        }


        /// <summary>
        /// Borra el material
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpPost]
        public JsonResult Borrar(string id)
        {
            try
            {
                MaterialData.Borrar(id);
                return Json(new { Success = true, Message = "Se borro correctamente el material " });
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message });
            }
        }

        /// <summary>
        /// Despliega ventana emergente con el grid de Matriales
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public ActionResult BuscarMaterial()
        {
            return PartialView("_buscaMaterial");
        }
    }
}
