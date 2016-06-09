///Propósito:Controlador para la administracion de materiales por proyecto
///Fecha creación: 28/Marzo/16
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
    public class AsignaProyectoController : Controller
    {
        /// <summary>
        /// Vista principal para la asignacion de materiales por proyceto
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
        public JsonResult CargaMaterialesProyecto(int idProyecto, int idEtapa, int idDocumento)
        {
            try
            {
                var lstMateralesProyecto = AsignaProyectoData.CargaMaterialesProyecto(idProyecto, idEtapa, idDocumento);

                return (Json(lstMateralesProyecto, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Carga la coleccion de documentos
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaDocumentoMaterialProyecto(int idProyecto, int idEtapa)
        {
            try
            {
                var lstMateralesProyecto = AsignaProyectoData.CargaDocumentoMaterialProyecto(idProyecto,idEtapa);

                return (Json(lstMateralesProyecto, JsonRequestBehavior.AllowGet));
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
        public JsonResult CargaMaterialesAsignados(int idProyecto, int idEtapa, int idRequerimiento, int idAlmacen, int idDocumento)
        {
            try
            {
                var lstMateralesProyecto = AsignaProyectoData.CargaMaterialesAsignados(idProyecto, idEtapa, idRequerimiento, idAlmacen, idDocumento);

                return (Json(lstMateralesProyecto, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }



        /// <summary>
        /// Define un nuevo 
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public ActionResult NuevoR()
        {
            var objAsignaProyecto = new Models.AsignaProyecto();
            ViewBag.Titulo = "Nuevo";
            return PartialView("_NuevoMM", objAsignaProyecto);
        }

 
        /// <summary>
        /// Define un nuevo
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public ActionResult NuevoM()
        {
            var objAsignaProyecto = new Models.AsignaProyecto();
            ViewBag.Titulo = "Nuevo";
            return PartialView("_NuevoM", objAsignaProyecto);
        }
        /// <summary>
        /// Define un nuevo 
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpPost]
        public JsonResult NuevoM(Models.AsignaProyecto pobjModelo)
        {
            if (ModelState.IsValid)
            {
                try
                {
                    var idDocumento = AsignaProyectoData.GuardarM(pobjModelo);
                    return Json(new { Success = true, id = idDocumento, Message = "Se guardo correctamente los materiales " });
                }
                catch (Exception exp)
                {
                    return Json(new { Success = false, Message = exp.Message });
                }
            }

            return Json(new { Success = false, Message = "Informacion incompleta" });
        }
        /// <summary>
        /// Define un nuevo material proyecto
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public ActionResult Actualiza()
        {
            return PartialView("_Actualiza");
        }

        /// <summary>
        /// Define un nuevo 
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpPost]
        public JsonResult Actualiza(Models.AsignaProyecto pobjModelo)
        {            
            if (ModelState.IsValid)
            {
                try
                {                   
                    AsignaProyectoData.Actualiza(pobjModelo);
                    return Json(new { Success = true, id = pobjModelo.id, Message = "Asignación de materiales correcta" });
                }
                catch (Exception exp)
                {
                    return Json(new { Success = false, Message = exp.Message });
                }
            }

            return Json(new { Success = false, Message = "Información para asignar materiales incompleta" });
        }





        /// <summary>
        /// Borra el material
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpPost]
        public JsonResult Borrar(string id)
        {
            try
            {
                AsignaProyectoData.Borrar(id);
                return Json(new { Success = true, Message = "Se borro correctamente el material " });
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message });
            }
        }

        /// <summary>
        /// Se cargan los detallesdel requerimeino manual seleccionado
        /// </summary>
        /// <param name="idRequerimiento"></param>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaDetalleMaterialesProyecto(int idRequerimiento, int idEtapa, int idProyecto, int idDocumento)
        {
            try
            {
                var lstDetalle = AsignaProyectoData.CargaDetalleMaterialesProyecto(idRequerimiento, idEtapa, idProyecto, idDocumento);

                return (Json(lstDetalle, JsonRequestBehavior.AllowGet));
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
        public JsonResult CargaHeaderMaterialesAsignados(int idProyecto, int idEtapa, int idDocumento)
        {
            try
            {
                var lstHeader = AsignaProyectoData.CargaHeaderMaterialesAsignados(idProyecto, idEtapa, idDocumento);

                return (Json(lstHeader, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }
    }
}
