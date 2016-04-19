///Propósito:Controlador para la administracion de requisiciones detalle
///Fecha creación: 28/Marzo/16
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
    public class RecepcionRequisicionController : Controller
    {
        /// <summary>
        /// Vista principal para la recepcion
        /// </summary>
        /// <returns>ActionResult</returns>
        public ActionResult Index()
        {
            return View();
        }

        /// <summary>
        /// Carga la coleccion de detalle requisicion
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaDetalleRequisicion(int idProyecto, int idEtapa, int idRequerimiento, int idRequisicion)
        {
            try
            {
                var lstDetalleRequisicion = RecepcionRequisicionData.CargaDetalleRequisicion(idProyecto, idEtapa, idRequerimiento, idRequisicion);

                return (Json(lstDetalleRequisicion, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Despliega ventana emergente para asiganr cantidad Recibida
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public ActionResult Actualiza()
        {
            return PartialView("_Actualiza");
        }

        /// <summary>
        /// Actualiza la cantidad recibida
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpPost]
        public JsonResult Actualiza(Models.RecepcionRequisicion pobjModelo)
        {            
            if (ModelState.IsValid)
            {
                try
                {                   
                    RecepcionRequisicionData.Actualiza(pobjModelo);
                    return Json(new { Success = true, id = pobjModelo.idItem, Message = "Se actualizo correctamente la cantidad recibida " });
                }
                catch (Exception exp)
                {
                    return Json(new { Success = false, Message = exp.Message });
                }
            }

            return Json(new { Success = false, Message = "Información incompleta" });
        }
    }
}
