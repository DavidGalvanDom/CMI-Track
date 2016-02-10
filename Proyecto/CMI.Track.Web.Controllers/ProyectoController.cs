///Propósito:Controlador para catalogo de Proyectos
///Fecha creación: 08/Febrero/16
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
   public  class ProyectoController : Controller
    {
        /// <summary>
        /// Vista principal para catalogo de Proyectos
        /// </summary>
        /// <returns>ActionResult</returns>
        public ActionResult Index()
        {
            return View();
        }

        /// <summary>
        /// Define un nuevo usuario
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public ActionResult Nuevo()
        {
            var objProjecto = new Models.Projecto() {  fechaCreacion = DateTime.Now.ToString("MM/dd/yyyy") };
            ViewBag.Titulo = "Nuevo";
            return PartialView("_Nuevo", objProjecto);
        }
    }
}
