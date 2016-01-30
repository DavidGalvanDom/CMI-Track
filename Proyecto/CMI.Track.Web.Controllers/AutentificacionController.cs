///Propósito: Datos de la configuración
///Fecha creación: 28/Enero/16
///Creador: David Galvan
///Fecha modifiacción: 
///Modificó:
///Dependencias de conexiones e interfaces: 

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Security;
using System.Web.Mvc;

using CMI.Track.Web.Models;
using CMI.Track.Web.Data;

namespace CMI.Track.Web.Controllers
{
    public class AutentificacionController: Controller
    {
        /// <summary>
        /// Vista principal para autentificar al usuario
        /// </summary>
        /// <returns>ActionResult</returns>
        [AllowAnonymous]
        public ActionResult Login()
        {
            ViewBag.error = string.Empty;
            var objLogin = new Models.Login();
            

            return View(objLogin);
        }


        /// <summary>
        /// Valida la entrada del usuario al sistema
        /// </summary>
        /// <param name="model">model</param>
        /// <param name="returnUrl">returnUrl</param>
        /// <returns>ActionResult</returns>
        [AllowAnonymous]
        [HttpPost]
        public ActionResult Login(Models.Login model, string returnUrl)
        {
            ViewBag.error = string.Empty;
            try
            {
                if (ModelState.IsValid)
                {
                    string agentName = model.NombreUsuario;
                    var result = UsuarioData.AutentificaUsuario(agentName, "ACT");

                    if (result != null)
                    {
                        if (result.Contrasena == model.Contrasena)
                        {
                            FormsAuthentication.SetAuthCookie(result.id.ToString(), false);
                            var objCookie = new HttpCookie("data", result.id.ToString());
                            Response.Cookies.Add(objCookie);

                            if (returnUrl != null)
                                return Redirect(returnUrl);
                            else
                                return RedirectToAction("Inicio", "Principal");
                        }
                        else
                        {
                            ViewBag.error = "El nombre de usuario o contraseña son incorrectos.";
                            return View();
                        }
                    }
                    else
                    {
                        ViewBag.error ="El nombre de usuario o contraseña son incorrectos.";
                        return View();
                    }
                }
               else
                  ViewBag.error = "Informacion incompleta";
            }
            catch (Exception exp)
            {
               ViewBag.error = "Login:" + exp.Message;
            }

            return View();
        }


        /// <summary>
        /// Termina la Sesion 
        /// </summary>
        /// <returns></returns>
        public ActionResult LogOut()
        {
            FormsAuthentication.SignOut();
            return RedirectToAction("Inicio", "Principal");
        }


        /// <summary>
        /// Cambio de contrasena del usuario
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult ContrasenaActual(string nomUsuario)
        {
            try
            {
                var contrasena = UsuarioData.ContrasenaActual(nomUsuario);
                return Json(new { Success = true, Message = contrasena }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }

        }
    }
}
