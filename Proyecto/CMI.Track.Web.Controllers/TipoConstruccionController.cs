///Propósito:Controlador para la administracion de tipos de construccion
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
    public class TipoConstruccionController: Controller
    {
        /// <summary>
        /// Vista principal para el tipo de construccion
        /// </summary>
        /// <returns>ActionResult</returns>
        public ActionResult Index()
        {
            return View();
        }

        /// <summary>
        /// Carga la coleccion de tipos de construccion
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaTiposConstruccion()
        {
            try
            {
                var lstTiposConstruccion = TipoConstruccionData.CargaTiposConstruccion();

                return (Json(lstTiposConstruccion, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Carga la coleccion de tipos de construccion
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaTiposConstruccionActivos()
        {
            try
            {
                var lstTiposConstruccion = TipoConstruccionData.CargaTiposConstruccionActivos();

                return (Json(lstTiposConstruccion, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Define un nuevo tipo de construccion
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public ActionResult Nuevo()
        {
            var objTipoConstruccion = new Models.TipoConstruccion();
            ViewBag.Titulo = "Nuevo";
            return PartialView("_Nuevo", objTipoConstruccion);
        }

        /// <summary>
        /// Define un nuevo tipo de construccion
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpPost]
        public JsonResult Nuevo(Models.TipoConstruccion pobjModelo)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    var idTipoConstruccion = TipoConstruccionData.Guardar(pobjModelo);
                    return Json(new { Success = true, id = idTipoConstruccion, Message = "Se guardo correctamente el tipo de construccion " });
                }
                catch (Exception exp)
                {
                    return Json(new { Success = false, Message = exp.Message });
                }
            }

            return Json(new { Success = false, Message = "Informacion incompleta" });                     
        }


        /// <summary>
        /// Define un nuevo tipo de construccion
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public ActionResult Actualiza(string id)
        {
            var objTipoCOnstruccion = TipoConstruccionData.CargaTipoConstruccion(id);
            return PartialView("_Actualiza", objTipoCOnstruccion);
        }

        /// <summary>
        /// Define un nuevo tipo de construccion
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpPost]
        public JsonResult Actualiza(Models.TipoConstruccion pobjModelo)
        {            
            if (ModelState.IsValid)
            {
                try
                {                   
                    TipoConstruccionData.Actualiza(pobjModelo);
                    return Json(new { Success = true, id = pobjModelo.id, Message = "Se actualizo correctamente el tipo de construccion " });
                }
                catch (Exception exp)
                {
                    return Json(new { Success = false, Message = exp.Message });
                }
            }

            return Json(new { Success = false, Message = "Información del tipo de construccion esta incompleta" });
        }

        /// <summary>
        /// Define un nuevo tipo de construccion
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public ActionResult Clonar(string id)
        {
            var objTipoConstruccion = TipoConstruccionData.CargaTipoConstruccion(id);
            objTipoConstruccion.id = 0;
            ViewBag.Titulo = "Clonar";

            return PartialView("_Nuevo", objTipoConstruccion);
        }


        /// <summary>
        /// Borra el tipo de construccion
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpPost]
        public JsonResult Borrar(string id)
        {
            string mensaje = "Se borro correctamente el tipo de construccion ";
            try
            {
                TipoConstruccionData.Borrar(id);
                return Json(new { Success = true, Message = mensaje });
            }
            catch (Exception exp)
            {
                mensaje = exp.Message;
                if (exp.HResult ==  -2146232832)
                {
                    mensaje = string.Format("El Tipo de Construccion ( {0} ) no puede ser borrado porque esta ciendo utilizado.", id) ;
                }
                return Json(new { Success = false, Message = mensaje });
            }
        }
    }
}
