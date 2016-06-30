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
    public class KardexController: Controller
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
        public JsonResult CargaKardex(string idMaterial, string idAlmacen)
        {
            try
            {
                var lstKardex = KardexData.CargaKardex(idMaterial, idAlmacen);

                return (Json(new { Success = true, data = lstKardex }, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

       
    }
}
