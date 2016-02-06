///Propósito:Controlador para la administracion de usuarios
///Fecha creación: 29/Enero/16
///Creador: David Galvan
///Fecha modifiacción: 
///Modificó:
///Dependencias de conexiones e interfaces: 

using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.UI;
using System.IO;

using CMI.Track.Web.Models;
using CMI.Track.Web.Data;

namespace CMI.Track.Web.Controllers
{
    public class PrincipalController : Controller
    {
        /// <summary>
        /// Pagina principal del citio web
        /// </summary>
        /// <param name="pUser"></param>
        /// <param name="pNombre"></param>
        /// <param name="pProfile"></param>
        /// <returns></returns>
        public ActionResult Inicio()
        {
            var cookie = HttpContext.Request.Cookies["data"] ?? new HttpCookie("data");
            if (cookie.Value != null)
            {
                string idUsuario = cookie.Value;
                var result = UsuarioData.CargaUsuario(idUsuario);

                ViewBag.IdUsuario = result.id;
                ViewBag.UserName = result.NombreUsuario;
                
                cookie.Expires = DateTime.Now.AddDays(-1);
                Response.Cookies.Add(cookie);
            }

            ViewBag.Module = "Inicio";
            return View();
        }

        ///// <summary>
        ///// Regresa la estructura del sidebar en base al usuario
        ///// </summary>
        ///// <param name="idUsuario"></param>
        ///// <returns></returns>
        [OutputCache(CacheProfile = "Long", Location = OutputCacheLocation.Client)]
        public PartialViewResult _sideBar(int id)
        {
            ViewBag.idUser = id;

            var lstPermisos = SeguridadData.CargaUsuarioPermisos(id);

            return PartialView(lstPermisos);
        }
    }
}
