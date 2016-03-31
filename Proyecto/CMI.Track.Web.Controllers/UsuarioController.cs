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
    public class UsuarioController: Controller
    {
        /// <summary>
        /// Vista principal para autentificar al usuario
        /// </summary>
        /// <returns>ActionResult</returns>
        public ActionResult Index()
        {
            return View();
        }

        /// <summary>
        /// Carga la coleccion de usuarios
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaUsuarios()
        {
            try
            {
                var lstUsuarios = UsuarioData.CargaUsuarios();
                
                return (Json(lstUsuarios, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Define un nuevo usuario
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public ActionResult Nuevo()
        {
            var objUsuario = new Models.Usuario() { idEstatus = 1, Contrasena = "",fechaCreacion = DateTime.Now.ToString("dd/MM/yyyy") };            
            ViewBag.Titulo = "Nuevo";
            return PartialView("_Nuevo", objUsuario);
        }

        /// <summary>
        /// Define un nuevo usuario
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpPost]
        public JsonResult Nuevo(Models.Usuario pobjModelo)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    var idUsuario = UsuarioData.Guardar(pobjModelo);
                    return Json(new { Success = true, id = idUsuario, Message = "Se guardo correctamente el Usuario " });
                }
                catch (Exception exp)
                {
                    return Json(new { Success = false, Message = exp.Message });
                }
            }

            return Json(new { Success = false, Message = "La informacion del usuario esta incompleta" });                     
        }


        /// <summary>
        /// Define un nuevo usuario
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public ActionResult Actualiza(string id)
        {
            var objUsuario = UsuarioData.CargaUsuario(id);
            return PartialView("_Actualiza", objUsuario);
        }

        /// <summary>
        /// Carga la vista para actualizar el usuario
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpPost]
        public JsonResult Actualiza(Models.Usuario pobjModelo)
        {            
            if (ModelState.IsValid)
            {
                try
                {                   
                    UsuarioData.Actualiza(pobjModelo);
                    return Json(new { Success = true, id = pobjModelo.id, Message = "Se actualizo correctamente el Usuario " });
                }
                catch (Exception exp)
                {
                    return Json(new { Success = false, Message = exp.Message });
                }
            }

            return Json(new { Success = false, Message = "Información del Usuario esta incompleta" });
        }

        /// <summary>
        /// Actualiza la informacion del  usuario
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public ActionResult Clonar(string id)
        {
            var objUsuario = UsuarioData.CargaUsuario(id);
            objUsuario.id = 0;
            objUsuario.Contrasena = "";
            objUsuario.fechaCreacion = DateTime.Now.ToString("dd/MM/yyyy");
            ViewBag.Titulo = "Clonar";

            return PartialView("_Nuevo", objUsuario);
        }


        /// <summary>
        /// Borra el Usuario
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpPost]
        public JsonResult Borrar(string id)
        {
            try
            {
                UsuarioData.Borrar(id);
                return Json(new { Success = true, Message = "Se borro correctamente el Usuario " });
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message });
            }
        }

        /// <summary>
        /// Se valida si el nombre de usuairo ya existe
        /// </summary>
        /// <returns>JsonResult</returns>
        [HttpGet]
        public JsonResult ValidaLoginUsuario(string loginUsuario, int idUsuario)
        {
            try
            {
                var blnExiste = UsuarioData.ValidaNomUsuario(loginUsuario.ToUpper(), idUsuario);
                return Json(new { result = blnExiste }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception exp)
            {
                return Json(new { result = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Carga el Proceso para un Avance de Produccion
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargarProcesoAvanceProduccion(int idProyecto, int idUsuario)
        {
            try
            {
                var lstProcesos = UsuarioData.CargarProcesoAvanceProduccion(idProyecto, idUsuario);

                return (Json(lstProcesos, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }
    }
}
