///Propósito:Controlador para generacion de Embarques
///Fecha creación: 20/Abril/16
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
    public class GenerarEmbarqueController : Controller
    {
        /// <summary>
        /// Vista principal para Tablet1
        /// </summary>
        /// <returns>ActionResult</returns>
        public ActionResult Tablet1()
        {
            return View();
        }

        /// <summary>
        /// Vista principal para Tablet1
        /// </summary>
        /// <returns>ActionResult</returns>
        public ActionResult Tablet2()
        {
            return View();
        }
    }
}
