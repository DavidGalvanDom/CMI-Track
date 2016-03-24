///Propósito:Controlador para catalogo de Ordenes de Produccion
///Fecha creación: 19/Febrero/16
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
using System.Configuration;

using CMI.Track.Web.Models;
using CMI.Track.Web.Data;

namespace CMI.Track.Web.Controllers
{
    public class OrdenProduccionController : Controller
    {
        /// <summary>
        /// Vista principal para catalogo de OrdenesProduccion
        /// </summary>
        /// <returns>ActionResult</returns>
        public ActionResult Index()
        {
            return View();
        }

        /// <summary>
        /// Carga la coleccion de Ordenes de Produccion
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaDetalleOrdenProduccion(int idEtapa, int idEstatusEtapa = 10, int idEstatus = 1, string clase = "T")
        {
            try
            {
                var lstDetalleOrdenProduccion = OrdenProduccionData.CargaDetalleOrdenProduccion(idEtapa, idEstatusEtapa, idEstatus, clase);

                return (Json(lstDetalleOrdenProduccion, JsonRequestBehavior.AllowGet));
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
        public ActionResult BuscarOrdenProduccion()
        {
            return PartialView("_buscarOrdenProduccion");
        }
    }
}
