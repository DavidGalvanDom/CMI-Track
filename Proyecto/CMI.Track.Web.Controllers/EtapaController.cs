///Propósito:Controlador para catalogo de Etapas
///Fecha creación: 17/Febrero/16
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
    public class EtapaController : Controller
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
        /// Carga la coleccion de Proyectos
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaEtapas(int idProyecto, string revision)
        {
            try
            {
                var lstEtapas = EtapaData.CargaEtapas(idProyecto, revision, null);

                return (Json(lstEtapas, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Se cargan las Etapas activas del proyecto
        /// </summary>
        /// <param name="idProyecto"></param>
        /// <param name="revision"></param>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaEtapasActivas(int idProyecto, string revision)
        {
            try
            {
                var lstEtapas = EtapaData.CargaEtapas(idProyecto, revision, 10);

                return (Json(lstEtapas, JsonRequestBehavior.AllowGet));
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
            var objEtapa = new Models.Etapa() { fechaCreacion = DateTime.Now.ToString("dd/MM/yyyy") };
            ViewBag.Titulo = "Nuevo";
            return PartialView("_Nuevo", objEtapa);
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

        /// <summary>
        /// Se carga la vista parcial para actulizar la etapa
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpGet]
        public ActionResult Actualiza(int id)
        {
            var objEtapa = EtapaData.CargaEtapa(id);
            return PartialView("_Actualiza", objEtapa);     
        }

        /// <summary>
        /// Actualiza la informacion de la Etapa
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpPost]
        public ActionResult Actualiza(Models.Etapa pobjModelo)
        {
         
            if (ModelState.IsValid)
            {
                try
                {         
                    EtapaData.Actualizar(pobjModelo);
                    return Json(new { Success = true, id = pobjModelo.id.ToString(), Message = "Se actualizo la informacion de la Etapa." });
                }
                catch (Exception exp)
                {
                    return Json(new { Success = false, Message = exp.Message });
                }
            }

            return Json(new { Success = false, Message = "La informacion de la Etapa esta incompleta" });
        }

        /// <summary>
        /// Carga el formulario para clonar la Etapa
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public ActionResult Clonar(int id)
        {
            var objEtapa = EtapaData.CargaEtapa(id);
            objEtapa.id = 0;
            objEtapa.fechaCreacion = DateTime.Now.ToString("dd/MM/yyyy");
            ViewBag.Titulo = "Clonar";
            return PartialView("_Nuevo", objEtapa);
        }


        /// <summary>
        /// Borra la etapa del proyecto seleccionado
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpPost]
        public JsonResult Borrar(int id)
        {
            try
            {
                EtapaData.Borrar(id);
                return Json(new { Success = true, Message = "Se borro correctamente la Etapa del proyecto." });
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message });
            }
        }

        /// <summary>
        /// Despliega ventana emergente con el grid de proyectos
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public ActionResult BuscarEtapa()
        {
            return PartialView("_buscarEtapa");
        }
    }
}
