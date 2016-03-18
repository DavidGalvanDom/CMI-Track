///Propósito:Controlador para el modulo de SubMarcas
///Fecha creación: 01/Marzo/16
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
    public class SubMarcasController: Controller
    {

        /// <summary>
        /// Vista principal para la carga de SubMarcas
        /// </summary>
        /// <returns>ActionResult</returns>
        public ActionResult Index()
        {
            return View();
        }

        /// <summary>
        /// Se cargan las subMarcas de la Marca seleccionada
        /// </summary>
        /// <param name="idMarca"></param>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaSubMarcas(int idMarca)
        {
            try
            {
                var lstSubMarcas = SubMarcasData.CargaSubMarcas(idMarca, null);

                return (Json(lstSubMarcas, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Se cargan solo las SubMarcasque esten activos de una Marca
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaSubMarcasActivas(int idMarca)
        {
            try
            {
                var lstSubMarcas = SubMarcasData.CargaSubMarcas(idMarca, 1); //1 Activo

                return (Json(lstSubMarcas, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Define una nueva SubMarca
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public ActionResult Nuevo()
        {
            var objSubMarcas = new Models.SubMarcas() { fechaCreacion = DateTime.Now.ToString("dd/MM/yyyy"), idEstatus = 1 };
            ViewBag.Titulo = "Nuevo";
            return PartialView("_Nuevo", objSubMarcas);
        }
        
        /// <summary>
        /// Define una neuva SubMarca
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpPost]
        public JsonResult Nuevo(Models.SubMarcas pobjModelo)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    var idSubMarca = SubMarcasData.Guardar(pobjModelo);
                    return Json(new { Success = true, id = idSubMarca, Message = "Se guardo correctamente la SubMarca" });
                }
                catch (Exception exp)
                {
                    return Json(new { Success = false, Message = exp.Message });
                }
            }
            return Json(new { Success = false, Message = "La informacion de la SubMarca esta incompleta." });
        }

        /// <summary>
        /// Se carga la vista parcial para actulizar la Marca
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpGet]
        public ActionResult Actualiza(int id)
        {
            var objSubMarca = SubMarcasData.CargaSubMarca(id);
            return PartialView("_Actualiza", objSubMarca);
        }

        /// <summary>
        /// Actualiza la informacion de la SubMarca
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpPost]
        public ActionResult Actualiza(Models.SubMarcas pobjModelo)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    SubMarcasData.Actualiza(pobjModelo);
                    return Json(new { Success = true, id = pobjModelo.id.ToString(), Message = "Se actualizo la informacion de la SubMarca." });
                }
                catch (Exception exp)
                {
                    return Json(new { Success = false, Message = exp.Message });
                }
            }

            return Json(new { Success = false, Message = "La informacion de la SubMarca esta incompleta" });

        }

        /// <summary>
        /// Carga el formulario para clonar una SubMarca
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public ActionResult Clonar(int id)
        {
            var objSubMarca = SubMarcasData.CargaSubMarca(id);
            objSubMarca.id = 0;
            objSubMarca.fechaCreacion = DateTime.Now.ToString("dd/MM/yyyy");
            ViewBag.Titulo = "Clonar";
            return PartialView("_Nuevo", objSubMarca);
        }


        /// <summary>
        /// Borra la SubMarca de base de datos
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpPost]
        public JsonResult Borrar(int id)
        {
            try
            {
                SubMarcasData.Borrar(id);
                return Json(new { Success = true, Message = "Se borro correctamente la SubMarca. (" + id.ToString() + ")" });
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message });
            }
        }       
    }
}
