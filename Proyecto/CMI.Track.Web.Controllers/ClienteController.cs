///Propósito:Controlador para la administracion de clientes
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
    public class ClienteController: Controller
    {
        /// <summary>
        /// Vista principal para clientes
        /// </summary>
        /// <returns>ActionResult</returns>
        public ActionResult Index()
        {
            return View();
        }

        /// <summary>
        /// Carga la coleccion de clientes
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaClientes()
        {
            try
            {
                var lstClientes = ClienteData.CargaClientes();

                return (Json(lstClientes, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Carga la coleccion de clientes activos
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaClientesActivos()
        {
            try
            {
                var lstClientes = ClienteData.CargaClientesActivos();

                return (Json(lstClientes, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Define un nuevo cliente
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public ActionResult Nuevo()
        {
            var objCliente = new Models.Cliente() { Estatus = "Activo" };
            ViewBag.Titulo = "Nuevo";
            return PartialView("_Nuevo", objCliente);
        }

        /// <summary>
        /// Define un nuevo cliente
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpPost]
        public JsonResult Nuevo(Models.Cliente pobjModelo)
        {
            if (ModelState.IsValid)

            {
                try
                {
                    var idCliente = ClienteData.Guardar(pobjModelo);
                    return Json(new { Success = true, id = idCliente, Message = "Se guardo correctamente el cliente " });
                }
                catch (Exception exp)
                {
                    return Json(new { Success = false, Message = exp.Message });
                }
            }

            return Json(new { Success = false, Message = "Informacion incompleta" });                     
        }


        /// <summary>
        /// Define un nuevo cliente
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public ActionResult Actualiza(string id)
        {
            var objCliente = ClienteData.CargaCliente(id);
            return PartialView("_Actualiza", objCliente);
        }

        /// <summary>
        /// Define un nuevo cliente
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpPost]
        public JsonResult Actualiza(Models.Cliente pobjModelo)
        {            
            if (ModelState.IsValid)
            {
                try
                {                   
                    ClienteData.Actualiza(pobjModelo);
                    return Json(new { Success = true, id = pobjModelo.id, Message = "Se actualizo correctamente el cliente " });
                }
                catch (Exception exp)
                {
                    return Json(new { Success = false, Message = exp.Message });
                }
            }

            return Json(new { Success = false, Message = "Información del cliente esta incompleta" });
        }

        /// <summary>
        /// Define un nuevo cliente
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public ActionResult Clonar(string id)
        {
            var objCliente = ClienteData.CargaCliente(id);
            objCliente.id = 0;
            ViewBag.Titulo = "Clonar";

            return PartialView("_Nuevo", objCliente);
        }


        /// <summary>
        /// Borra el cliente
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpPost]
        public JsonResult Borrar(string id)
        {
            try
            {
                ClienteData.Borrar(id);
                return Json(new { Success = true, Message = "Se borro correctamente el cliente " });
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message });
            }
        }


        /// <summary>
        /// Despliega ventana emergente con el grid de clietnes
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public ActionResult BuscarCliente()
        {
            return PartialView("_buscarCliente");
        }
    }
}
