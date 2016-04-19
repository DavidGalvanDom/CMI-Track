///Propósito:Controlador para la administracion de movimientos de materiales
///Fecha creación: 02/Abril/16
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
    public class MovimientoMaterialController: Controller
    {
        /// <summary>
        /// Vista principal para movimeintos de material
        /// </summary>
        /// <returns>ActionResult</returns>
        public ActionResult Index()
        {
            return View();
        }

        /// <summary>
        /// Carga la coleccion de movimientos
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaMovimientos(string id)
        {
            try
            {
                var lstMovtos = MovimientoMaterialData.CargaMovimientos(id);

                return (Json(lstMovtos, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Carga la coleccion de movimientos
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaHeaderMovimientos(string id)
        {
            try
            {
                var lstMovtos = MovimientoMaterialData.CargaHeaderMovtos(id);

                return (Json(lstMovtos, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Carga la coleccion de movimeintos por Documento
        /// </summary>
        /// <returns></returns>
        //[HttpGet]
        //public JsonResult CargaMovimientosDocumento(int idDocumento)
        //{
        //    try
        //    {
        //        var lstMovtos = MovimientoMaterialData.CargaMovimientosDocumento(idDocumento);

        //        return (Json(lstMovtos, JsonRequestBehavior.AllowGet));
        //    }
        //    catch (Exception exp)
        //    {
        //        return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
        //    }
        //}


        /// <summary>
        /// Carga la coleccion de movimientos
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaDocumentos()
        {
            try
            {
                var lstMovtos = MovimientoMaterialData.CargaDocumentos();

                return (Json(lstMovtos, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Carga la coleccion de tipos de movimientos
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaTiposMovimientos()
        {
            try
            {
                var lstMovtos = MovimientoMaterialData.CargaTiposMovimientos();

                return (Json(lstMovtos, JsonRequestBehavior.AllowGet));
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
            var objMovtoM = new Models.MovimientoMaterial();
            ViewBag.Titulo = "Nuevo";
            return PartialView("_Nuevo", objMovtoM);

        }

        /// <summary>
        /// Define un nuevo categoria
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpPost]
        public JsonResult Nuevo(Models.MovimientoMaterial pobjModelo)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    var idMaterial = MovimientoMaterialData.Guardar(pobjModelo);
                    return Json(new { Success = true, id = idMaterial, Message = "Se guardo correctamente el material " });
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
        public ActionResult Actualiza(string id)
        {
            var objCategoria = CategoriaData.CargaCategoria(id);
            return PartialView("_Actualiza", objCategoria);
        }

        /// <summary>
        /// Define un nuevo categoria
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpPost]
        public JsonResult Actualiza(Models.Categoria pobjModelo)
        {            
            if (ModelState.IsValid)
            {
                try
                {                   
                    CategoriaData.Actualiza(pobjModelo);
                    return Json(new { Success = true, id = pobjModelo.id, Message = "Se actualizo correctamente la categoria " });
                }
                catch (Exception exp)
                {
                    return Json(new { Success = false, Message = exp.Message });
                }
            }

            return Json(new { Success = false, Message = "Información de la categoria esta incompleta" });
        }

        /// <summary>
        /// Define un nuevo categoria
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public ActionResult Clonar(string id)
        {
            var objCategoria = CategoriaData.CargaCategoria(id);
            objCategoria.id = 0;
            ViewBag.Titulo = "Clonar";

            return PartialView("_Nuevo", objCategoria);
        }


        /// <summary>
        /// Borra la categoria
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpPost]
        public JsonResult Borrar(string id)
        {
            try
            {
                CategoriaData.Borrar(id);
                return Json(new { Success = true, Message = "Se borro correctamente la categoria " });
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message });
            }
        }
    }
}
