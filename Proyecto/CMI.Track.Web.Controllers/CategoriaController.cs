///Propósito:Controlador para la administracion de categorias
///Fecha creación: 02/Febrero/16
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
    public class CategoriaController: Controller
    {
        /// <summary>
        /// Vista principal para la categoria
        /// </summary>
        /// <returns>ActionResult</returns>
        public ActionResult Index()
        {
            return View();
        }

        /// <summary>
        /// Carga la coleccion de categorias
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaCategorias()
        {
            try
            {
                var lstCategorias = CategoriaData.CargaCategorias();

                return (Json(lstCategorias, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Carga la coleccion de categorias
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaCategoriasActivas()
        {
            try
            {
                var lstCategorias = CategoriaData.CargaCategoriasActivas();

                return (Json(lstCategorias, JsonRequestBehavior.AllowGet));
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
            var objCategoria = new Models.Categoria();
            ViewBag.Titulo = "Nuevo";
            return PartialView("_Nuevo", objCategoria);
        }

        /// <summary>
        /// Define un nuevo categoria
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpPost]
        public JsonResult Nuevo(Models.Categoria pobjModelo)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    var idCategoria = CategoriaData.Guardar(pobjModelo);
                    return Json(new { Success = true, id = idCategoria, Message = "Se guardo correctamente la categoria " });
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
