///Propósito:Controlador para la administracion de Unidades de Medida
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
    public class UnidadMedidaController : Controller
    {
        /// <summary>
        /// Vista principal para autentificar al UnidadMedida
        /// </summary>
        /// <returns>ActionResult</returns>
        public ActionResult Index()
        {
            return View();
        }

        /// <summary>
        /// Carga la coleccion de Unidades Medida
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaUnidadesMedida()
        {
            try
            {
                var lstUnidadesMedida = UnidadMedidaData.CargaUnidadesMedida();

                return (Json(lstUnidadesMedida, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Carga la coleccion de Unidades Medida Activas
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaUnidadesMedidaActivas()
        {
            try
            {
                var lstUnidadesMedida = UnidadMedidaData.CargaUnidadesMedidaActivas();

                return (Json(lstUnidadesMedida, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Define un nuevo UnidadMedida
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public ActionResult Nuevo()
        {
            var objUnidadMedida = new Models.UnidadMedida() { idEstatus = 1 };
            ViewBag.Titulo = "Nuevo";
            return PartialView("_Nuevo", objUnidadMedida);
        }

        /// <summary>
        /// Define un nuevo UnidadMedida
        /// </summary>
        /// <returns>JSonResult</returns>
        [HttpPost]
        public JsonResult Nuevo(Models.UnidadMedida pobjModelo)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    var idUnidadMedida = UnidadMedidaData.Guardar(pobjModelo);
                    return Json(new { Success = true, id = idUnidadMedida, Message = "Se guardo correctamente la Unidad de Medida " });
                }
                catch (Exception exp)
                {
                    return Json(new { Success = false, Message = exp.Message });
                }
            }

            return Json(new { Success = false, Message = "Informacion incompleta" });
        }


        /// <summary>
        /// Actualiza un UnidadMedida
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public ActionResult Actualiza(string id)
        {
            var objUnidadMedida = UnidadMedidaData.CargaUnidadMedida(id);
            return PartialView("_Actualiza", objUnidadMedida);
        }

        /// <summary>
        /// Actualiza un UnidadMedida
        /// </summary>
        /// <returns>JSonResult</returns>
        [HttpPost]
        public JsonResult Actualiza(Models.UnidadMedida pobjModelo)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    UnidadMedidaData.Actualiza(pobjModelo);
                    return Json(new { Success = true, id = pobjModelo.id, Message = "Se actualizo correctamente la Unidad de Medida " });
                }
                catch (Exception exp)
                {
                    return Json(new { Success = false, Message = exp.Message });
                }
            }

            return Json(new { Success = false, Message = "Información de la Unidad de Medida esta incompleta" });
        }

        /// <summary>
        /// Clona un UnidadMedida
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public ActionResult Clonar(string id)
        {
            var objUnidadMedida = UnidadMedidaData.CargaUnidadMedida(id);
            objUnidadMedida.id = 0;
            ViewBag.Titulo = "Clonar";

            return PartialView("_Nuevo", objUnidadMedida);
        }

        /// <summary>
        /// Borra el UnidadMedida
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpPost]
        public JsonResult Borrar(string id)
        {
            try
            {
                UnidadMedidaData.Borrar(id);
                return Json(new { Success = true, Message = "Se borro correctamente la Unidad de Medida " });
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message });
            }
        }
    }
}
