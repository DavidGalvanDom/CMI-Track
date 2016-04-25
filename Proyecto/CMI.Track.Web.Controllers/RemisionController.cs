///Propósito:Controlador para la administracion de Remisiones
///Fecha creación: 24/Abril/16
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
    public class RemisionController : Controller
    {
        /// <summary>
        /// Vista principal para las Remisiones
        /// </summary>
        /// <returns>ActionResult</returns>
        public ActionResult Index()
        {
            return View();
        }

        /// <summary>
        /// Define un nueva Remision
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public ActionResult Nuevo()
        {
            var objRemision = new Models.Remision() { fechaRemision = DateTime.Now.ToString("dd/MM/yyyy") };
            ViewBag.Titulo = "Nuevo";
            return PartialView("_Nuevo", objRemision);
        }

        /// <summary>
        /// Define un nueva Remision
        /// </summary>
        /// <returns>JsonResult</returns>
        [HttpPost]
        public JsonResult Nuevo(Models.Remision pobjRemision)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    var idRemision = RemisionData.Guardar(pobjRemision);
                    return Json(new { Success = true, id = idRemision, Message = "Se guardo correctamente la Remision " });
                }
                catch (Exception exp)
                {
                    return Json(new { Success = false, Message = exp.Message });
                }
            }

            return Json(new { Success = false, Message = "La informacion de la Remision esta incompleta" });
        }

    }
}
