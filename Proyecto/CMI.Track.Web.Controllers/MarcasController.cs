///Propósito:Controlador para el modulo de Marcas
///Fecha creación: 24/Febrero/16
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
    public class MarcasController: Controller
    {
        /// <summary>
        /// Vista principal para las Marcas
        /// </summary>
        /// <returns>ActionResult</returns>
        public ActionResult Index()
        {
            return View();
        }

        /// <summary>
        /// Se cargan las Marcas del Plano Despiece seleccionado
        /// </summary>
        /// <param name="idPlanoDespiece"></param>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaMarcas(int idPlanoDespiece)
        {
            try
            {
                var lstMarcas = MarcasData.CargaMarcas(idPlanoDespiece, null);

                return (Json(lstMarcas, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Se cargan solo las Marcasque esten activos de un plano despiece
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaMarcasActivas(int idPlanoDespiece)
        {
            try
            {
                var lstMarcas = MarcasData.CargaMarcas(idPlanoDespiece, 1); //1 Activo

                return (Json(lstMarcas, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Define una nueva Marca
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public ActionResult Nuevo()
        {
            var objMarcas = new Models.Marca() { fechaCreacion = DateTime.Now.ToString("MM/dd/yyyy"), idEstatus = 1 };
            ViewBag.Titulo = "Nuevo";
            return PartialView("_Nuevo", objMarcas);
        }


        /// <summary>
        /// Define una neuva Marca
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpPost]
        public JsonResult Nuevo(Models.Marca pobjModelo)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    var idMarca = MarcasData.Guardar(pobjModelo);
                    return Json(new { Success = true, id = idMarca, Message = "Se guardo correctamente la Marca" });
                }
                catch (Exception exp)
                {
                    return Json(new { Success = false, Message = exp.Message });
                }
            }
            return Json(new { Success = false, Message = "La informacion de la Marca esta incompleta." });
        }
        
        /// <summary>
        /// Se carga la vista parcial para actulizar la Marca
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpGet]
        public ActionResult Actualiza(int id)
        {
            var objMarca = MarcasData.CargaMarca(id);
            return PartialView("_Actualiza", objMarca);
        }

        /// <summary>
        /// Actualiza la informacion de la Marca
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpPost]
        public ActionResult Actualiza(Models.Marca pobjModelo)
        {          
            if (ModelState.IsValid)
            {
                try
                {                   
                    MarcasData.Actualiza(pobjModelo);
                    return Json(new { Success = true, id = pobjModelo.id.ToString(), Message = "Se actualizo la informacion de la Marca." });
                }
                catch (Exception exp)
                {
                    return Json(new { Success = false, Message = exp.Message });
                }
            }

            return Json(new { Success = false, Message = "La informacion de la Marca esta incompleta" });

        }
       
        /// <summary>
        /// Carga el formulario para clonar una Marca
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public ActionResult Clonar(int id)
        {
            var objMarca = MarcasData.CargaMarca(id);
            objMarca.id = 0;
            objMarca.fechaCreacion = DateTime.Now.ToString("MM/dd/yyyy");
            ViewBag.Titulo = "Clonar";
            return PartialView("_Nuevo", objMarca);
        }


        /// <summary>
        /// Borra la Marca de base de datos
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpPost]
        public JsonResult Borrar(int id)
        {
            try
            {
                MarcasData.Borrar(id);
                return Json(new { Success = true, Message = "Se borro correctamente la Marca. (" + id.ToString() + ")" });
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message });
            }
        }
        
        /// <summary>
        /// Despliega ventana emergente con el grid de Marcas
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public ActionResult BuscarMarcas()
        {
            return PartialView("_buscarMarcas");
        }
    }
}