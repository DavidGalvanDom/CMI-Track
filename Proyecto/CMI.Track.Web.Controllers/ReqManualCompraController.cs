///Propósito:Controlador para el modulo de Planes de Montaje
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
    public class ReqManualCompraController : Controller
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
        /// Vista principal para catalogo de Etapas
        /// </summary>
        /// <returns>ActionResult</returns>
        public ActionResult Autorizar()
        {
            return View();
        }

        /// <summary>
        /// Se cargan los detallesdel requerimeino manual seleccionado
        /// </summary>
        /// <param name="idRequerimiento"></param>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaDetalleManual(int idRequerimiento, string idRequisicion)
        {
            try
            {
                var lstMarcas = ReqManulCompraData.CargaDetalleManual(idRequerimiento, idRequisicion,  null);

                return (Json(lstMarcas, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }
        /// <summary>
        /// Se cargan los planos de montaje de la etapa seleccionada
        /// </summary>
        /// <param name="idEtapa"></param>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaRequisiciones(int idEtapa, int idProyecto, int idRequerimiento)
        {
            try
            {
                var lstRequisiciones = ReqManulCompraData.CargaRequisicionesGeneral(idEtapa, idProyecto, idRequerimiento, null);

                return (Json(lstRequisiciones, JsonRequestBehavior.AllowGet));
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
            var objReqManualCompra = new Models.ReqManualCompra() {  };
            ViewBag.Titulo = "Nuevo";
            return PartialView("_Nuevo", objReqManualCompra);
        }

        /// <summary>
        /// Define un nuevo categoria
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpPost]
        public JsonResult Nuevo(Models.ReqManualCompra pobjModelo)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    var idRequesicion = ReqManulCompraData.Guardar(pobjModelo);
                    return Json(new { Success = true, id = idRequesicion, Message = "Se guardo correctamente la requisicion de compra" });
                }
                catch (Exception exp)
                {
                    return Json(new { Success = false, Message = exp.Message });
                }
            }

            return Json(new { Success = false, Message = "Informacion incompleta" });
        }
        /// <summary>
        /// Define un nuevo categoria
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public ActionResult Actualiza(int id, int idRequerimiento, string idRequisicion)
        {
            var objReqMaterial = ReqManulCompraData.CargaMaterialesDetalles(id, idRequerimiento, idRequisicion);
            return PartialView("_Actualiza", objReqMaterial);
        }

        /// <summary>
        /// Define un nuevo categoria
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpPost]
        public JsonResult Actualiza(Models.ReqManualCompra pobjModelo)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    ReqManulCompraData.Actualiza(pobjModelo);
                    return Json(new { Success = true, id = pobjModelo.id, Message = "Se actualizo correctamente el material " });
                }
                catch (Exception exp)
                {
                    return Json(new { Success = false, Message = exp.Message });
                }
            }

            return Json(new { Success = false, Message = "Información del material esta incompleto" });
        }
        /// <summary>
        /// Define un nuevo categoria
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpPost]
        public JsonResult Autoriza(int Autoriza, int idRequisicion, int idRequerimiento)
        {
            try
            {
                var lstAutoriza = ReqManulCompraData.Autorizar(Autoriza, idRequisicion, idRequerimiento);

                  return Json(new { Success = true });
            }
            catch (Exception exp)
            {
                 return Json(new { Success = false, Message = exp.Message });
            }

          
        }
        /// <summary>
        /// Borra el material
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpPost]
        public JsonResult Borrar(string id, int idRequisicion)
        {
            try
            {
                ReqManulCompraData.Borrar(id, idRequisicion);
                return Json(new { Success = true, Message = "Se borro correctamente el material " });
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message });
            }
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
        /// Carga la coleccion de infor REquerimiento
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaInfoRequerimiento(int idProyecto, int idEtapa, int idRequerimiento)
        {
            try
            {
                var lstlistaRptRequerimientos = ReqManulCompraData.CargaInfoRequerimiento(idProyecto, idEtapa, idRequerimiento);

                return (Json(lstlistaRptRequerimientos, JsonRequestBehavior.AllowGet));
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
        public JsonResult CargaInfoRequisicion(int idProyecto, int idEtapa, int idRequerimiento)
        {
            try
            {
                var lstlistaRptRequisicion = ReqManulCompraData.CargaInfoRequisicion(idProyecto, idEtapa, idRequerimiento);

                return (Json(lstlistaRptRequisicion, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

  
    }
}
