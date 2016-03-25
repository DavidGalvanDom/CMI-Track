///Propósito:Controlador para catalogo de Codigos de Barra
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
    public class ImpresionCodigoBarraController : Controller
    {
        /// <summary>
        /// Vista principal para catalogo de ImpresionCodigoBarra
        /// </summary>
        /// <returns>ActionResult</returns>
        public ActionResult Index()
        {
            return View();
        }

        /// <summary>
        /// Carga la coleccion de Codigos de Barra
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaCodigosBarra(int idEtapa, string tipo = "T")
        {
            try
            {
                var lstCodigosBarra = ImpresionCodigoBarraData.CargaCodigosBarra(idEtapa, tipo);

                return (Json(lstCodigosBarra, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }
    }
}
