///Propósito:Controlador para la administracion de RutasFabricacion
///Fecha creación: 12/Febrero/16
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
    public class RutaFabricacionController : Controller
    {
        /// <summary>
        /// Vista principal RutaFabricacion
        /// </summary>
        /// <returns>ActionResult</returns>
        public ActionResult Index()
        {
            return View();
        }

        /// <summary>
        /// Carga la coleccion de RutasFabricacion
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaRutasFabricacion()
        {
            try
            {
                var lstRutasFabricacion = RutaFabricacionData.CargaRutasFabricacion();

                return (Json(lstRutasFabricacion, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Carga la coleccion de RutasFabricacion Activas
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaRutasFabricacionActivas()
        {
            try
            {
                var lstRutasFabricacion = RutaFabricacionData.CargaRutasFabricacionActivas();

                return (Json(lstRutasFabricacion, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Define un nuevo RutaFabricacion
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public ActionResult Nuevo()
        {
            var objRutaFabricacion = new Models.RutaFabricacion() { idEstatus = 1 };
            ViewBag.Titulo = "Nuevo";
            return PartialView("_Nuevo", objRutaFabricacion);
        }

        /// <summary>
        /// Define un nuevo RutaFabricacion
        /// </summary>
        /// <returns>JSonResult</returns>
        [HttpPost]
        public JsonResult Nuevo(Models.RutaFabricacion pobjModelo)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    var idRutaFabricacion = RutaFabricacionData.Guardar(pobjModelo);
                    return Json(new { Success = true, id = idRutaFabricacion, Message = "Se guardo correctamente la Ruta de Fabricacion " });
                }
                catch (Exception exp)
                {
                    return Json(new { Success = false, Message = exp.Message });
                }
            }

            return Json(new { Success = false, Message = "Informacion incompleta" });                     
        }


        /// <summary>
        /// Actualiza un RutaFabricacion
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public ActionResult Actualiza(string id)
        {
            var objRutaFabricacion = RutaFabricacionData.CargaRutaFabricacion(id);
            return PartialView("_Actualiza", objRutaFabricacion);
        }

        /// <summary>
        /// Actualiza un RutaFabricacion
        /// </summary>
        /// <returns>JSonResult</returns>
        [HttpPost]
        public JsonResult Actualiza(Models.RutaFabricacion pobjModelo)
        {            
            if (ModelState.IsValid)
            {
                try
                {
                    RutaFabricacionData.Actualiza(pobjModelo);
                    return Json(new { Success = true, id = pobjModelo.id, Message = "Se actualizo correctamente la Ruta de Fabricacion" });
                }
                catch (Exception exp)
                {
                    return Json(new { Success = false, Message = exp.Message });
                }
            }

            return Json(new { Success = false, Message = "Información de la Ruta de Fabricacion esta incompleta" });
        }

        /// <summary>
        /// Clona un RutaFabricacion
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public ActionResult Clonar(string id)
        {
            var objRutaFabricacion = RutaFabricacionData.CargaRutaFabricacion(id);
            objRutaFabricacion.id = 0;
            ViewBag.Titulo = "Clonar";

            return PartialView("_Nuevo", objRutaFabricacion);
        }

        /// <summary>
        /// Borra la RutaFabricacion
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpPost]
        public JsonResult Borrar(string id)
        {
            try
            {
                ProcesoData.Borrar(id);
                return Json(new { Success = true, Message = "Se borro correctamente la Ruta de Fabricacion " });
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message });
            }
        }
    }
}
