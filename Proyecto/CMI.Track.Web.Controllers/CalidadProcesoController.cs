///Propósito:Controlador para la administracion de CalidadProceso
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
    public class CalidadProcesoController : Controller
    {
        /// <summary>
        /// Vista principal CalidadProceso
        /// </summary>
        /// <returns>ActionResult</returns>
        public ActionResult Index()
        {
            return View();
        }

        /// <summary>
        /// Carga la coleccion de CalidadProceso
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaCalidadesProceso()
        {
            try
            {
                var lstCalidadesProceso = CalidadProcesoData.CargaCalidadesProceso();

                return (Json(lstCalidadesProceso, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Carga la coleccion de CalidadProceso Activas
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaCalidadesProcesoActivas()
        {
            try
            {
                var lstCalidadesProceso = CalidadProcesoData.CargaCalidadesProcesoActivas();

                return (Json(lstCalidadesProceso, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Define un nuevo CalidadProceso
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public ActionResult Nuevo()
        {
            var objCalidadProceso = new Models.CalidadProceso() { idEstatus = 1 };
            ViewBag.Titulo = "Nuevo";
            return PartialView("_Nuevo", objCalidadProceso);
        }

        /// <summary>
        /// Define un nuevo CalidadProceso
        /// </summary>
        /// <returns>JSonResult</returns>
        [HttpPost]
        public JsonResult Nuevo(Models.CalidadProceso pobjModelo)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    CalidadProcesoData.Guardar(pobjModelo);
                    return Json(new { Success = true, id = pobjModelo.idProceso.ToString() + pobjModelo.idTipoCalidad.ToString(), Message = "Se guardo correctamente la Relacion Calidad Proceso " });
                }
                catch (Exception exp)
                {
                    return Json(new { Success = false, Message = exp.Message });
                }
            }

            return Json(new { Success = false, Message = "Informacion incompleta" });                     
        }


        /// <summary>
        /// Actualiza un CalidadProceso
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public ActionResult Actualiza(string idProceso, string idTipoCalidad)
        {
            var objCalidadProceso = CalidadProcesoData.CargaCalidadProceso(idProceso, idTipoCalidad);
            return PartialView("_Actualiza", objCalidadProceso);
        }

        /// <summary>
        /// Actualiza un CalidadProceso
        /// </summary>
        /// <returns>JSonResult</returns>
        [HttpPost]
        public JsonResult Actualiza(Models.CalidadProceso pobjModelo)
        {            
            if (ModelState.IsValid)
            {
                try
                {
                    CalidadProcesoData.Actualiza(pobjModelo);
                    return Json(new { Success = true, id = pobjModelo.idProceso.ToString() + pobjModelo.idTipoCalidad.ToString(), Message = "Se actualizo correctamente la Relacion Calidad Proceso" });
                }
                catch (Exception exp)
                {
                    return Json(new { Success = false, Message = exp.Message });
                }
            }
            return Json(new { Success = false, Message = "Información de la Relacion Calidad Proceso esta incompleta" });
        }

        /// <summary>
        /// Clona un CalidadProceso
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public ActionResult Clonar(string idProceso, string idTipoCalidad)
        {
            var objCalidadProceso = CalidadProcesoData.CargaCalidadProceso(idProceso, idTipoCalidad);
            ViewBag.Titulo = "Clonar";

            return PartialView("_Nuevo", objCalidadProceso);
        }

        /// <summary>
        /// Borra la CalidadProceso
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpPost]
        public JsonResult Borrar(string idProceso, string idTipoCalidad)
        {
            try
            {
                CalidadProcesoData.Borrar(idProceso, idTipoCalidad);
                return Json(new { Success = true, Message = "Se borro correctamente la Relacion Calidad Proceso " });
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message });
            }
        }
    }
}
