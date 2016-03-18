///Propósito:Controlador para catalogo de Departamentos
///Fecha creación: 28/Enero/16
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

using CMI.Track.Web.Models;
using CMI.Track.Web.Data;

namespace CMI.Track.Web.Controllers
{
    public class DepartamentoController: Controller
    {
        /// <summary>
        /// Vista principal para catalogo de departamentos
        /// </summary>
        /// <returns>ActionResult</returns>
        public ActionResult Index()
        {
            return View();
        }

        /// <summary>
        /// Carga la coleccion de Departamentos
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaDepartamentos(int id)
        {
            try
            {
                var lstDepartamentos = DepartamentoData.CargaDepartamentos(id);

                return (Json(lstDepartamentos, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }


        /// <summary>
        /// Carga la coleccion de los departamentos Activos
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaDepartamentosActivos()
        {
            try
            {
                var lstDepartamentos = DepartamentoData.CargaDepartamentos(1);

                return (Json(lstDepartamentos, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }


        /// <summary>
        /// Define un nuevo Departamento
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public ActionResult Nuevo()
        {
            var objDepartamento = new Models.Departamento() { idEstatus = 1, fechaCreacion = DateTime.Now.ToString("dd/MM/yyyy") };
            ViewBag.Titulo = "Nuevo";
            return PartialView("_Nuevo", objDepartamento);
        }

        /// <summary>
        /// Se guarda el nuevo departamento
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpPost]
        public JsonResult Nuevo(Models.Departamento pobjModelo)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    var idUsuario = DepartamentoData.Guardar(pobjModelo);
                    return Json(new { Success = true, id = idUsuario, Message = "Se guardo correctamente el Departamento " });
                }
                catch (Exception exp)
                {
                    return Json(new { Success = false, Message = exp.Message });
                }
            }

            return Json(new { Success = false, Message = "La informacion del departamento esta incompleta" });
        }

        /// <summary>
        /// Carga la vista para actualizar el departamento
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public ActionResult Actualiza(int id)
        {
            var objDepartamento = DepartamentoData.CargaDepartamento(id);            
            return PartialView("_Actualiza", objDepartamento);
        }

        /// <summary>
        /// Actualiza la inforamcion del Departamento
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpPost]
        public JsonResult Actualiza(Models.Departamento pobjModelo)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    DepartamentoData.Actualiza(pobjModelo);
                    return Json(new { Success = true, id = pobjModelo.id, Message = "Se actualizo correctamente la informacion del Departamento " });
                }
                catch (Exception exp)
                {
                    return Json(new { Success = false, Message = exp.Message });
                }
            }

            return Json(new { Success = false, Message = "Información del Departamento esta incompleta" });
        }

        /// <summary>
        /// Define un nuevo usuario
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public ActionResult Clonar(int id)
        {
            var objDepartamento = DepartamentoData.CargaDepartamento(id);
            objDepartamento.id = 0;
            objDepartamento.fechaCreacion = DateTime.Now.ToString("dd/MM/yyyy");
            ViewBag.Titulo = "Clonar";

            return PartialView("_Nuevo", objDepartamento);
        }

        /// <summary>
        /// Borra el Departamento
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpPost]
        public JsonResult Borrar(string id)
        {
            try
            {
                DepartamentoData.Borrar(id);
                return Json(new { Success = true, Message = "Se borro correctamente el Departamento " });
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message });
            }
        }
    }
}
