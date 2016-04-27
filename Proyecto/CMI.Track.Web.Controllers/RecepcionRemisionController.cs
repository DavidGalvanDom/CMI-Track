///Propósito:Controlador para Recepcion de Remisiones
///Fecha creación: 25/Abril/16
///Creador: David Galvan
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
    public class RecepcionRemisionController : Controller
    {
        /// <summary>
        /// Vista principal Recepcion Remisiones
        /// </summary>
        /// <returns>ActionResult</returns>
        public ActionResult Index()
        {
            ViewBag.Fecha = DateTime.Now.ToString("dd/MM/yyyy");
            return View();
        }

        /// <summary>
        /// Detalle a nivel Marca de las Ordenes de embarque que pertenecen auna Remision
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaDetalleRemision(int id)
        {
            try
            {
                var lstRemisiones = RemisionData.CargaDestalleRemision(id);

                return (Json(lstRemisiones, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

       /// <summary>
       /// Se registra la Marca
       /// </summary>
       /// <param name="idDetaOrdenEmb"></param>
       /// <param name="idMarca"></param>
       /// <param name="serie"></param>
       /// <param name="idRemision"></param>
       /// <param name="idUsuario"></param>
       /// <returns></returns>
        [HttpPost]
        public JsonResult GenerarRecepcionRemision(int idOrdenEmb, int idMarca,
                                           string serie, int idRemision, 
                                           int idUsuario)
        {
            try
            {
                var resultado = RemisionData.GenerarRemision(idOrdenEmb, idMarca, serie, idRemision, idUsuario);

                if(resultado.Length == 0)
                    return (Json(new { Success = true }, JsonRequestBehavior.AllowGet));
                else
                    return (Json(new { Success = false, Message = resultado }, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

    }
}
