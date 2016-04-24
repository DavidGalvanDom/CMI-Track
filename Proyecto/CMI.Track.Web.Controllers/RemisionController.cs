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
    }
}
