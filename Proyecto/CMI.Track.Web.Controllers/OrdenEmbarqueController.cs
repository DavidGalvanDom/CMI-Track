///Propósito:Controlador para el modulo de ordenes de embarque
///Fecha creación: 20/Febrero/16
///Creador: David Jaso
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
    public class OrdenEmbarqueController : Controller
    {
        /// <summary>
        /// Vista principal para catalogo de embarques
        /// </summary>
        /// <returns>ActionResult</returns>
        public ActionResult Index()
        {
            return View();
        }

        /// <summary>
        /// Se carga el detalle de la oreden de embarque
        /// </summary>
        /// <param name="idProyecto"></param>
        /// <param name="idEtapa"></param>
        /// <param name="idOrdenEmebarque"></param>
        /// <returns></returns>
        public JsonResult CargaReporteDetaOE(int id)
        {
            try
            {
                var lstOrdenEmbarque = OrdenEmbarqueData.CargaReporteDetaOE(id);

                return (Json(lstOrdenEmbarque, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

 	    /// <summary>
        /// Se cargan solo los proyectos que esten activos.
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaOrdenEmbarqueActivos(int idProyecto, int idEtapa, bool sinRemision)
        {
            try
            {
                var lstOrdenEmbarque = OrdenEmbarqueData.CargarOrdenesEmbarque(idProyecto,  idEtapa, 1, sinRemision);

                return (Json(lstOrdenEmbarque, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Se cargan solo los proyectos que esten activos.
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaOrdenEmbarques(int idProyecto, int idEtapa)
        {
            try
            {
                var lstOrdenEmbarque = OrdenEmbarqueData.CargarOrdenesEmbarque(idProyecto, idEtapa, null,false);

                return (Json(lstOrdenEmbarque, JsonRequestBehavior.AllowGet));
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
        public ActionResult BuscarOrdenEmbarque(bool sinRemision)
        {
            ViewBag.sinRemision = sinRemision.ToString();
            return PartialView("_buscarOrdenEmbarque");
        }

        /// <summary>
        /// Carga la coleccion de infor Requisicion
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaHeaderOrdeEmb(int idProyecto, int idEtapa, int idOrden)
        {
            try
            {
                var lstOrdenEmbarque = OrdenEmbarqueData.CargaHeaderOrdeEmb(idProyecto, idEtapa, idOrden);

                return (Json(lstOrdenEmbarque, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Define un nuevo categoria
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public ActionResult Nuevo()
        {
            var objOrdenEmbarque = new Models.OrdenEmbarque() { EstatusOE = 1, fechaCreacion = DateTime.Now.ToString("dd/MM/yyyy")};
            ViewBag.Titulo = "Nuevo";
            return PartialView("_Nuevo", objOrdenEmbarque);
        }

        /// <summary>
        /// Se crea una nueva Orden de Embarque
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpPost]
        public JsonResult Nuevo(Models.OrdenEmbarque pobjModelo)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    var idOrden = OrdenEmbarqueData.Guardar(pobjModelo);
                    return Json(new { Success = true, id = idOrden, Message = "Se guardo correctamente la Orden de Embarque" });
                }
                catch (Exception exp)
                {
                    return Json(new { Success = false, Message = exp.Message });
                }
            }

            return Json(new { Success = false, Message = "Informacion incompleta" });
        }

        /// <summary>
        /// Despliega ventana emergente con el grid de Requerimientos
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public ActionResult BuscarRequisiciones()
        {
            return PartialView("_buscarRequisicion");
        }

        /// <summary>
        /// Carga la coleccion de marcas
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaMarcasDispo(int idProyecto, int idEtapa)
        {
            try
            {
                var lstMateriales = OrdenEmbarqueData.CargaMarcas(idProyecto, idEtapa);

                return (Json(lstMateriales, JsonRequestBehavior.AllowGet));
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
        public ActionResult Actualiza(int id)
        {
            var objOrdeEmbarque = OrdenEmbarqueData.CargarOrdenEmbarque(id);
            return PartialView("_Actualiza", objOrdeEmbarque);
        }

        /// <summary>
        /// Se actualizan los datos de la Orden de Embarque
        /// </summary>
        /// <returns></returns>
        [HttpPost]
        public JsonResult Actualiza(Models.OrdenEmbarque pobjModelo)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    OrdenEmbarqueData.Actualizar(pobjModelo);
                    return Json(new { Success = true,id = pobjModelo.id, Message = "Se actulizo correctamente la Orden de Embarque" });
                }
                catch (Exception exp)
                {
                    return Json(new { Success = false, Message = exp.Message });
                }
            }

            return Json(new { Success = false, Message = "Informacion incompleta" });
        }

        /// <summary>
        /// Se Elimina la Orden de Embarque de la base de datos
        /// </summary>
        /// <param name="idOrdenEmebarque"></param>
        /// <returns></returns>
        public JsonResult Borrar(int id)
        {
            try
            {
                OrdenEmbarqueData.Borrar(id);

                return Json(new { Success = true }, JsonRequestBehavior.AllowGet);
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

  
    }
}
