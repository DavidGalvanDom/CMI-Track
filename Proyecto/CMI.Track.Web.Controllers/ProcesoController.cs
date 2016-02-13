///Propósito:Controlador para la administracion de Procesos
///Fecha creación: 10/Febrero/16
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
    public class ProcesoController : Controller
    {
        /// <summary>
        /// Vista principal Proceso
        /// </summary>
        /// <returns>ActionResult</returns>
        public ActionResult Index()
        {
            return View();
        }

        /// <summary>
        /// Carga la coleccion de Proceso
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaProcesos()
        {
            try
            {
                var lstProcesos = ProcesoData.CargaProcesos();

                return (Json(lstProcesos, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Carga la coleccion de Procesos Activos
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaProcesosActivos()
        {
            try
            {
                var lstProcesos = ProcesoData.CargaProcesosActivos();

                return (Json(lstProcesos, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Define un nuevo Proceso
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public ActionResult Nuevo()
        {
            var objProceso = new Models.Proceso() { idEstatus = 1 };
            ViewBag.Titulo = "Nuevo";
            return PartialView("_Nuevo", objProceso);
        }

        /// <summary>
        /// Define un nuevo Proceso
        /// </summary>
        /// <returns>JSonResult</returns>
        [HttpPost]
        public JsonResult Nuevo(Models.Proceso pobjModelo)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    var idProceso = ProcesoData.Guardar(pobjModelo);
                    return Json(new { Success = true, id = idProceso, Message = "Se guardo correctamente el Proceso " });
                }
                catch (Exception exp)
                {
                    return Json(new { Success = false, Message = exp.Message });
                }
            }

            return Json(new { Success = false, Message = "Informacion incompleta" });                     
        }


        /// <summary>
        /// Actualiza un Proceso
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public ActionResult Actualiza(string id)
        {
            var objProceso = ProcesoData.CargaProceso(id);
            return PartialView("_Actualiza", objProceso);
        }

        /// <summary>
        /// Actualiza un Proceso
        /// </summary>
        /// <returns>JSonResult</returns>
        [HttpPost]
        public JsonResult Actualiza(Models.Proceso pobjModelo)
        {            
            if (ModelState.IsValid)
            {
                try
                {
                    ProcesoData.Actualiza(pobjModelo);
                    return Json(new { Success = true, id = pobjModelo.id, Message = "Se actualizo correctamente el Proceso" });
                }
                catch (Exception exp)
                {
                    return Json(new { Success = false, Message = exp.Message });
                }
            }

            return Json(new { Success = false, Message = "Información del Proceso esta incompleta" });
        }

        /// <summary>
        /// Clona un Proceso
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public ActionResult Clonar(string id)
        {
            var objProceso = ProcesoData.CargaProceso(id);
            objProceso.id = 0;
            ViewBag.Titulo = "Clonar";

            return PartialView("_Nuevo", objProceso);
        }

        /// <summary>
        /// Borra el Proceso
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpPost]
        public JsonResult Borrar(string id)
        {
            try
            {
                ProcesoData.Borrar(id);
                return Json(new { Success = true, Message = "Se borro correctamente el Proceso " });
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message });
            }
        }
    }
}
