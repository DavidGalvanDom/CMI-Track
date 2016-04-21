///Propósito:Controlador el manejo de Ordenes de Embarque
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
using System.Configuration;

using CMI.Track.Web.Models;
using CMI.Track.Web.Data;
namespace CMI.Track.Web.Controllers
{
    public class OrdenEmbarqueController: Controller
    {
        /// <summary>
        /// Vista principal para Ordenes de Embarque
        /// </summary>
        /// <returns>ActionResult</returns>
        public ActionResult Index()
        {
            return View();
        }

        /// <summary>
        /// Se cargan solo los proyectos que esten activos.
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaOrdenEmbarqueActivos(int idProyecto, string revision, int idEtapa)
        {
            try
            {
                var lstOrdenEmbarque = OrdenEmbarqueData.CargarOrdenesEmbarque(idProyecto, revision, idEtapa,1);

                return (Json(lstOrdenEmbarque, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

         /// <summary>
        /// Despliega ventana emergente con el grid de proyectos
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public ActionResult BuscarOrdenEmbarque()
        {
            return PartialView("_buscarOrdenEmbarque");
        }

    }
}
