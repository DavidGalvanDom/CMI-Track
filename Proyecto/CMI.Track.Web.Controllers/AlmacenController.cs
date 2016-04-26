///Propósito:Controlador para la administracion de Almacenes
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
    public class AlmacenController : Controller
    {
        /// <summary>
        /// Vista principal Almacen
        /// </summary>
        /// <returns>ActionResult</returns>
        public ActionResult Index()
        {
            return View();
        }

        /// <summary>
        /// Carga la coleccion de Almacen
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaAlmacenes()
        {
            try
            {
                var lstAlmacenes = AlmacenData.CargaAlmacenes();

                return (Json(lstAlmacenes, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Carga la coleccion de Almacenes Activos
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaAlmacenesActivos()
        {
            try
            {
                var lstAlmacenes = AlmacenData.CargaAlmacenesActivos();

                return (Json(lstAlmacenes, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Define un nuevo Almacen
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public ActionResult Nuevo()
        {
            var objAlmacen = new Models.Almacen() { idEstatus = 1 };
            ViewBag.Titulo = "Nuevo";
            return PartialView("_Nuevo", objAlmacen);
        }

        /// <summary>
        /// Define un nuevo Almacen
        /// </summary>
        /// <returns>JSonResult</returns>
        [HttpPost]
        public JsonResult Nuevo(Models.Almacen pobjModelo)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    var idAlmacen = AlmacenData.Guardar(pobjModelo);
                    return Json(new { Success = true, id = idAlmacen, Message = "Se guardo correctamente el Almacen " });
                }
                catch (Exception exp)
                {
                    return Json(new { Success = false, Message = exp.Message });
                }
            }

            return Json(new { Success = false, Message = "Informacion incompleta" });
        }


        /// <summary>
        /// Actualiza un Almacen
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public ActionResult Actualiza(string id)
        {
            var objAlmacen = AlmacenData.CargaAlmacen(id);
            return PartialView("_Actualiza", objAlmacen);
        }

        /// <summary>
        /// Actualiza un Almacen
        /// </summary>
        /// <returns>JSonResult</returns>
        [HttpPost]
        public JsonResult Actualiza(Models.Almacen pobjModelo)
        {            
            if (ModelState.IsValid)
            {
                try
                {
                    AlmacenData.Actualiza(pobjModelo);
                    return Json(new { Success = true, id = pobjModelo.id, Message = "Se actualizo correctamente el Almacen" });
                }
                catch (Exception exp)
                {
                    return Json(new { Success = false, Message = exp.Message });
                }
            }

            return Json(new { Success = false, Message = "Información del Almacen esta incompleta" });
        }

        /// <summary>
        /// Clona un Almacen
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public ActionResult Clonar(string id)
        {
            var objAlmacen = AlmacenData.CargaAlmacen(id);
            objAlmacen.id = 0;
            ViewBag.Titulo = "Clonar";

            return PartialView("_Nuevo", objAlmacen);
        }

        /// <summary>
        /// Borra el Almacen
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpPost]
        public JsonResult Borrar(string id)
        {
            try
            {
                AlmacenData.Borrar(id);
                return Json(new { Success = true, Message = "Se borro correctamente el Almacen " });
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message });
            }
        }
    }
}
