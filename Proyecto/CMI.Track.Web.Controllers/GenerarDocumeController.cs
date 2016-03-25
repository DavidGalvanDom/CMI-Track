///Propósito:Controlador para la generacion de documentos
///Fecha creación: 22/Marzo/16
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
    public class GenerarDocumeController: Controller
    {
        /// <summary>
        /// Vista principal Generar documentos
        /// </summary>
        /// <returns>ActionResult</returns>
        public ActionResult Index()
        {
            return View();
        }

        /// <summary>
        /// Se generarn los requerimientos y regresa el reporte de 
        /// requerimiento general de materiales.
        /// </summary>
        /// <param name="idProyecto"></param>
        /// <param name="idEtapa"></param>
        /// <returns></returns>
        [HttpPost]
        public JsonResult RGMateriales(int idProyecto, int idEtapa)
        {
            try
            {
                //var lstEtapas = EtapaData.CargaEtapas(idProyecto, revision, null);

                return (Json(new { Success = true, Excel = "data"}));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message });
            }
        }
    }
}
