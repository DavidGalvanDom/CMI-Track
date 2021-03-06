﻿///Propósito: Datos de la configuración
///Fecha creación: 28/Enero/2016
///Creador: David Galvan
///Fecha modifiacción: 
///Modificó:
///Dependencias de conexiones e interfaces: 

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using System.Web.Security;
namespace CMI.Track.Web.Controllers
{
    public class AutorizarLogin : AuthorizeAttribute
    {
        /// <summary>
        /// Redirecciona a el controlador que dispara el Login
        /// </summary>
        /// <param name="filterContext"></param>
        public override void OnAuthorization(AuthorizationContext filterContext)
        {
            if (!((filterContext.Controller is AutentificacionController) && (filterContext.ActionDescriptor.ActionName.ToLower() == "login")))
            {
                if (!filterContext.HttpContext.Request.IsAuthenticated)
                    base.OnAuthorization(filterContext);

            }
        }
    }
}
