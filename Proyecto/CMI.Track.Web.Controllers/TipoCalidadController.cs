///Propósito:Controlador para la administracion de Tipos de Calidad
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
    public class TipoCalidadController : Controller
    {
        /// <summary>
        /// Vista principal TipoCalidad
        /// </summary>
        /// <returns>ActionResult</returns>
        public ActionResult Index()
        {
            return View();
        }

        /// <summary>
        /// Carga la coleccion de TipoCalidad
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaTiposCalidad()
        {
            try
            {
                var lstTiposCalidad = TipoCalidadData.CargaTiposCalidad();

                return (Json(lstTiposCalidad, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Carga la coleccion de TipoCalidad
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaTiposCalidadActivos()
        {
            try
            {
                var lstTiposCalidad = TipoCalidadData.CargaTiposCalidadActivos();

                return (Json(lstTiposCalidad, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Define un nuevo TipoCalidad
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public ActionResult Nuevo()
        {
            var objTipoCalidad = new Models.TipoCalidad() { idEstatus = 1 };
            ViewBag.Titulo = "Nuevo";
            return PartialView("_Nuevo", objTipoCalidad);
        }

        /// <summary>
        /// Define un nuevo TipoCalidad
        /// </summary>
        /// <returns>JSonResult</returns>
        [HttpPost]
        public JsonResult Nuevo(Models.TipoCalidad pobjModelo)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    var idTipoCalidad = TipoCalidadData.Guardar(pobjModelo);
                    return Json(new { Success = true, id = idTipoCalidad, Message = "Se guardo correctamente el Tipo de Calidad " });
                }
                catch (Exception exp)
                {
                    return Json(new { Success = false, Message = exp.Message });
                }
            }

            return Json(new { Success = false, Message = "Informacion incompleta" });                     
        }


        /// <summary>
        /// Actualiza un TipoCalidad
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public ActionResult Actualiza(string id)
        {
            var objTipoCalidad = TipoCalidadData.CargaTipoCalidad(id);
            return PartialView("_Actualiza", objTipoCalidad);
        }

        /// <summary>
        /// Actualiza un TipoCalidad
        /// </summary>
        /// <returns>JSonResult</returns>
        [HttpPost]
        public JsonResult Actualiza(Models.TipoCalidad pobjModelo)
        {            
            if (ModelState.IsValid)
            {
                try
                {
                    TipoCalidadData.Actualiza(pobjModelo);
                    return Json(new { Success = true, id = pobjModelo.id, Message = "Se actualizo correctamente el Tipo de Calidad" });
                }
                catch (Exception exp)
                {
                    return Json(new { Success = false, Message = exp.Message });
                }
            }

            return Json(new { Success = false, Message = "Información del Tipo Calidad esta incompleta" });
        }

        /// <summary>
        /// Clona un TipoCalidad
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public ActionResult Clonar(string id)
        {
            var objTipoCalidad = TipoCalidadData.CargaTipoCalidad(id);
            objTipoCalidad.id = 0;
            ViewBag.Titulo = "Clonar";

            return PartialView("_Nuevo", objTipoCalidad);
        }

        /// <summary>
        /// Borra el TipoCalidad
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpPost]
        public JsonResult Borrar(string id)
        {
            try
            {
                TipoCalidadData.Borrar(id);
                return Json(new { Success = true, Message = "Se borro correctamente el Tipo de Calidad " });
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message });
            }
        }
    }
}
