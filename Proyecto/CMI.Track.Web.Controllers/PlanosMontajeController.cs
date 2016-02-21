﻿///Propósito:Controlador para el modulo de Planes de Montaje
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
    public class PlanosMontajeController : Controller
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
        public JsonResult CargaPlanosMontaje(int idEtapa)
        {
            try
            {
                var lstPlanosMontaje = PlanosMontajeData.CargaPlanosMontaje(idEtapa, null);

                return (Json(lstPlanosMontaje, JsonRequestBehavior.AllowGet));
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
            var objPlanosMontaje = new Models.PlanosMontaje() { fechaCreacion = DateTime.Now.ToString("MM/dd/yyyy") };
            ViewBag.Titulo = "Nuevo";
            return PartialView("_Nuevo", objPlanosMontaje);
        }


        /// <summary>
        /// Define un nuevo Proyecto
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpPost]
        public JsonResult Nuevo(Models.Etapa pobjModelo)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    var idEtapa = EtapaData.Guardar(pobjModelo);
                    return Json(new { Success = true, id = idEtapa, Message = "Se guardo correctamente la Etapa " });
                }
                catch (Exception exp)
                {
                    return Json(new { Success = false, Message = exp.Message });
                }
            }

            return Json(new { Success = false, Message = "La informacion de la Etapa esta incompleta." });
        }
    }
}