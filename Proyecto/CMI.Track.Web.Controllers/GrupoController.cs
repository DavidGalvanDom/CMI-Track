///Propósito:Controlador para la administracion de Grupos
///Fecha creación: 01/Febrero/16
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

using CMI.Track.Web.Models;
using CMI.Track.Web.Data;


namespace CMI.Track.Web.Controllers
{
    public class GrupoController : Controller
    {
        /// <summary>
        /// Vista principal Grupo
        /// </summary>
        /// <returns>ActionResult</returns>
        public ActionResult Index()
        {
            return View();
        }

        /// <summary>
        /// Carga la coleccion de Grupo
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaGrupos()
        {
            try
            {
                var lstGrupos = GrupoData.CargaGrupos();

                return (Json(lstGrupos, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Carga la coleccion de Grupos Activos
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaGruposActivos()
        {
            try
            {
                var lstGrupos = GrupoData.CargaGruposActivos();

                return (Json(lstGrupos, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Define un nuevo Grupo
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public ActionResult Nuevo()
        {
            var objGrupo = new Models.Grupo() { idEstatus = 1 };
            ViewBag.Titulo = "Nuevo";
            return PartialView("_Nuevo", objGrupo);
        }

        /// <summary>
        /// Define un nuevo Grupo
        /// </summary>
        /// <returns>JSonResult</returns>
        [HttpPost]
        public JsonResult Nuevo(Models.Grupo pobjModelo)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    var idGrupo = GrupoData.Guardar(pobjModelo);
                    return Json(new { Success = true, id = idGrupo, Message = "Se guardo correctamente el Grupo " });
                }
                catch (Exception exp)
                {
                    return Json(new { Success = false, Message = exp.Message });
                }
            }

            return Json(new { Success = false, Message = "Informacion incompleta" });                     
        }


        /// <summary>
        /// Actualiza un Grupo
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public ActionResult Actualiza(string id)
        {
            var objGrupo = GrupoData.CargaGrupo(id);
            return PartialView("_Actualiza", objGrupo);
        }

        /// <summary>
        /// Actualiza un Grupo
        /// </summary>
        /// <returns>JSonResult</returns>
        [HttpPost]
        public JsonResult Actualiza(Models.Grupo pobjModelo)
        {            
            if (ModelState.IsValid)
            {
                try
                {
                    GrupoData.Actualiza(pobjModelo);
                    return Json(new { Success = true, id = pobjModelo.id, Message = "Se actualizo correctamente el Grupo" });
                }
                catch (Exception exp)
                {
                    return Json(new { Success = false, Message = exp.Message });
                }
            }

            return Json(new { Success = false, Message = "Información del Grupo esta incompleta" });
        }

        /// <summary>
        /// Clona un Grupo
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public ActionResult Clonar(string id)
        {
            var objGrupo = GrupoData.CargaGrupo(id);
            objGrupo.id = 0;
            ViewBag.Titulo = "Clonar";

            return PartialView("_Nuevo", objGrupo);
        }

        /// <summary>
        /// Borra el Grupo
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpPost]
        public JsonResult Borrar(string id)
        {
            try
            {
                GrupoData.Borrar(id);
                return Json(new { Success = true, Message = "Se borro correctamente el Grupo " });
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message });
            }
        }
    }
}
