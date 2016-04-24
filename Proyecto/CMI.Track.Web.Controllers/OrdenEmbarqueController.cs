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
        /// Se cargan solo los proyectos que esten activos.
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaOrdenEmbarqueActivos(int idProyecto, string revision, int idEtapa)
        {
            try
            {
                var lstOrdenEmbarque = OrdenEmbarqueData.CargarOrdenesEmbarque(idProyecto, revision, idEtapa,1);

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
        public ActionResult BuscarOrdenEmbarque()
        {
            return PartialView("_buscarOrdenEmbarque");
        }
        /// <summary>
        /// Se cargan los detallesdel requerimeino manual seleccionado
        /// </summary>
        /// <param name="idProyecto"></param>
        /// <param name="idEtapa"></param>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaOrdenEmbarque(int idProyecto, int idEtapa, string idOrden)
        {
            try
            {
                var lstOrdenEmb = OrdenEmbarqueData.CargaOrdenEmbarque(idProyecto, idEtapa, idOrden);

                return (Json(lstOrdenEmb, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Carga la coleccion de ordenes de embarque
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaOrdenes()
        {
            try
            {
                var lstOrdenes = OrdenEmbarqueData.CargaOrdenes();

                return (Json(lstOrdenes, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
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
            var objOrdenEmbarque = new Models.OrdenEmbarque() {  };
            ViewBag.Titulo = "Nuevo";
            return PartialView("_Nuevo", objOrdenEmbarque);
        }

        /// <summary>
        /// Define un nuevo categoria
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
                    return Json(new { Success = true, id = idOrden, Message = "Se guardo correctamente la pieza" });
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
        public JsonResult CargaMarcas(int idProyecto, int idEtapa)
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
        /// Despliega ventana emergente con el grid de marcas
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public ActionResult BuscarMarca()
        {
            return PartialView("_buscaMarca");
        }

  
    }
}
