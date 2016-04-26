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

    }
}
