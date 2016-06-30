///Propósito:Controlador para la administracion de kardex
///Fecha creación: 02/Febrero/16
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
    public class ExistenciasController : Controller
    {
        /// <summary>
        /// Vista principal para la categoria
        /// </summary>
        /// <returns>ActionResult</returns>
        public ActionResult Index()
        {
            return View();
        }

        /// <summary>
        /// Carga la coleccion de categorias
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaExistencias(string matrialDe, string materialA,
                                         string almacenDe, string almacenA,
                                         string grupoDe, string grupoA)
        {
            try
            {
                var lstExistencias = ExistenciasData.CargaExistencias(matrialDe, materialA,
                                                                     almacenDe, almacenA,
                                                                     grupoDe, grupoA);

                return (Json(lstExistencias, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

       
    }
}
