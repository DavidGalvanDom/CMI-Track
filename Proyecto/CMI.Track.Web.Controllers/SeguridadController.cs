///Propósito:Controlador para la administracion de usuarios
///Fecha creación: 28/Enero/16
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
    public class SeguridadController : Controller
    {
        /// <summary>
        /// Vista principal asignar permisos a los usuarios
        /// </summary>
        /// <returns>ActionResult</returns>
        public ActionResult Index(string id)
        {
            return View();
        }

        /// <summary>
        /// Lista de modulos para el usuario
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        public ActionResult Modulos(string id)
        {            
            ViewBag.Usuario = id;
            return PartialView("_Modulos");
        }



        /// <summary>
        /// Se carga la lista de modulos
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargarModulos(int id)
        {
            try
            {
                var lstModulos = SeguridadData.CargarModulos(id);

                return (Json(lstModulos, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Se guarda la informacion de los permisos del sistema
        /// </summary>
        /// <param name="lstModulos"></param>
        /// <param name="idUsuario"></param>
        /// <param name="usuarioCreacion"></param>
        /// <returns></returns>
        [HttpPost]
        public JsonResult GuardaSeguridad(List<ListaModulo> lstModulos, int idUsuario, int usuarioCreacion)
        {
            try
            {
                SeguridadData.GuardaSeguridad(lstModulos, idUsuario, usuarioCreacion);
                
                return Json(new { Success = true, Message = "Los permisos fueron actualizados" });
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message });
            }
        }
    }
}
