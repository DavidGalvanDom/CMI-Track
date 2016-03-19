///Propósito:Controlador para el modulo de Planes de Montaje
///Fecha creación: 20/Febrero/16
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
    public class ReqGralMaterialController : Controller
    {
        /// <summary>
        /// Vista principal para catalogo de Etapas
        /// </summary>
        /// <returns>ActionResult</returns>
        public ActionResult Index()
        {
            return View();
        }

        /// <summary>
        /// Se cargan los planos de montaje de la etapa seleccionada
        /// </summary>
        /// <param name="idEtapa"></param>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaReqGralMateriales(int idEtapa, int idProyecto)
        {
            try
            {
                var lstReqGralMateriales = ReqGralMaterialData.CargaRequerimientosGeneral(idEtapa, idProyecto, null);

                return (Json(lstReqGralMateriales, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Se cargan los planos de montaje de la etapa seleccionada
        /// </summary>
        /// <param name="idEtapa"></param>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaReqGralMaterialesId(int idEtapa, int idProyecto, int idRequerimiento )
        {
            try
            {
                var lstReqGralMateriales = ReqGralMaterialData.CargaRequerimientosGeneralId(idEtapa, idProyecto, idRequerimiento, null);

                return (Json(lstReqGralMateriales, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Despliega ventana emergente con el grid de Matriales
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public ActionResult BuscarRequerimientos()
        {
            return PartialView("_buscarRequeMaterial");
        }

        /// <summary>
        /// Despliega ventana emergente con el grid de Matriales
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public ActionResult Reporte()
        {
            return PartialView("_rptGeneralXLS");
        }
  
    }
}
