///Propósito:Controlador para la administracion de Remisiones
///Fecha creación: 24/Abril/16
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
    public class RemisionController : Controller
    {
        /// <summary>
        /// Vista principal para las Remisiones
        /// </summary>
        /// <returns>ActionResult</returns>
        public ActionResult Index()
        {
            return View();
        }

        /// <summary>
        /// Se carga la lista de Remisiones
        /// </summary>
        /// <param name="idProyecto"></param>
        /// <param name="idEtapa"></param>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaRemisiones(int idProyecto, int idEtapa)
        {
            try
            {
                var lstRemisiones = RemisionData.CargaRemisiones(idProyecto, idEtapa,null);

                return (Json(lstRemisiones, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Define un nueva Remision
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public ActionResult Nuevo(int idProyecto, int idEtapa)
        {
            var objRemision = new Models.Remision() { idProyecto= idProyecto, idEtapa=idEtapa, fechaRemision = DateTime.Now.ToString("dd/MM/yyyy") };
            ViewBag.Titulo = "Nuevo";
            return PartialView("_Nuevo", objRemision);
        }

        /// <summary>
        /// Define un nueva Remision
        /// </summary>
        /// <returns>JsonResult</returns>
        [HttpPost]
        public JsonResult Nuevo(Models.Remision pobjRemision)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    var idRemision = RemisionData.Guardar(pobjRemision);
                    return Json(new { Success = true, id = idRemision, Message = "Se guardo correctamente la Remision " });
                }
                catch (Exception exp)
                {
                    return Json(new { Success = false, Message = exp.Message });
                }
            }

            return Json(new { Success = false, Message = "La informacion de la Remision esta incompleta" });
        }

        /// <summary>
        /// Carga el formulario para actulizar el proyecto
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public ActionResult Actualiza(int id)
        {
            var objRemision = RemisionData.CargaRemision(id);
            return PartialView("_Actualiza", objRemision);
        }

        /// <summary>
        /// Actualiza la informacion del proyecto
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpPost]
        public ActionResult Actualiza(Models.Remision pobjModelo)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    RemisionData.Actualiza(pobjModelo);
                    return Json(new { Success = true, id = pobjModelo.id.ToString(), Message = "Gracias por actualizar la informacion de la remision." });
                }
                catch (Exception exp)
                {
                    return Json(new { Success = false, Message = exp.Message });
                }
            }

            return Json(new { Success = false, Message = "La informacion de la Remision esta incompleta" });
        }


        /// <summary>
        /// Se carga la lista de Embarque asignados a la Remision
        /// </summary>
        /// <param name="id">Id Remision</param>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaEmbarquesRemisiones(int id)
        {
            try
            {
                var lstEmbarquesRemision = RemisionData.CargaEmbarquesRemision(id);

                return (Json(new { Success = true, Data = lstEmbarquesRemision }, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Despliega ventana emergente con el grid de proyectos
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public ActionResult BuscarRemision()
        {
            return PartialView("_buscarRemision");
        }

        /// <summary>
        /// Se cargan solo los proyectos que esten activos.
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaRemisionesActivas(int idProyecto, int idEtapa)
        {
            try
            {
                var lstRemisiones = RemisionData.CargaRemisiones(idProyecto, idEtapa,1);

                return (Json(lstRemisiones, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Se carga a nivel Marca de las Ordenes de embarque asignadas a la remision
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaDetalleRemision(int id)
        {
            try
            {
                var lstDetalleRemision = RemisionData.CargaDestalleRemision(id);

                return (Json(new { Success = true, Data = lstDetalleRemision, fecha = DateTime.Now.ToString("dd/MM/yyyy") }, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Carga el formulario para actulizar el proyecto
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public JsonResult Remision(int id)
        {
            try
            {
                var objRemision = RemisionData.CargaRemision(id);

                return (Json(new { Success = true, Data = objRemision }, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Se Elimina la Remision de la base de datos
        /// </summary>
        /// <param name="idOrdenEmebarque"></param>
        /// <returns></returns>
        public JsonResult Borrar(int id)
        {
            try
            {
                RemisionData.Borrar(id);

                return Json(new { Success = true }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

    }
}
