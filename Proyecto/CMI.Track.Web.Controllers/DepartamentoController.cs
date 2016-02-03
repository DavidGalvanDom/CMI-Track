///Propósito:Controlador para catalogo de Departamentos
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
    public class DepartamentoController: Controller
    {
        /// <summary>
        /// Vista principal para catalogo de departamentos
        /// </summary>
        /// <returns>ActionResult</returns>
        public ActionResult Index()
        {
            return View();
        }

        /// <summary>
        /// Carga la coleccion de Departamentos
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaDepartamentos(int id)
        {
            try
            {
                var lstDepartamentos = DepartamentoData.CargaDepartamentos(id);

                return (Json(lstDepartamentos, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }
    }
}
