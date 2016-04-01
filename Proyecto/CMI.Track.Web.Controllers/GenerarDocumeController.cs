///Propósito:Controlador para la generacion de documentos
///Fecha creación: 22/Marzo/16
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
    public class GenerarDocumeController: Controller
    {
        /// <summary>
        /// Vista principal Generar documentos
        /// </summary>
        /// <returns>ActionResult</returns>
        public ActionResult Index()
        {
            return View();
        }

        /// <summary>
        /// Se generarn los requerimientos y regresa el reporte de 
        /// requerimiento general de materiales.
        /// </summary>
        /// <param name="idProyecto"></param>
        /// <param name="idEtapa"></param>
        /// <param name="idUsuario"></param>
        /// <returns></returns>
        [HttpPost]
        public JsonResult RGMateriales(int idProyecto, int idEtapa, int idUsuario)
        {
            try
            {
                var reqGenMat = GenerarDocumeData.GenerarRequerimientos(idProyecto,idEtapa,idUsuario);

                return (Json(new { Success = true, Excel = reqGenMat}));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message });
            }
        }

        /// <summary>
        /// Se generarn los requerimientos y regresa el reporte de 
        /// requerimiento general de materiales.
        /// </summary>
        /// <param name="idProyecto"></param>
        /// <param name="idEtapa"></param>
        /// <param name="clase"></param>
        /// <returns></returns>
        [HttpPost]
        public JsonResult OrdenProduccion(int idProyecto, int idEtapa, string clase)
        {
            try
            {
                var rptOrdenProduccion = GenerarDocumeData.CargarOrdenProduccion(idProyecto, idEtapa, clase);

                return (Json(new { Success = true, Excel = rptOrdenProduccion, fecha= DateTime.Now.ToString("dd/MM/yyyy") }));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message });
            }
        }

        /// <summary>
        /// Se carga el reporte de Lisado general de partes detallado
        /// </summary>
        /// <param name="idProyecto"></param>
        /// <param name="idEtapa"></param>
        /// <param name="idUsuario"></param>
        /// <returns></returns>
         [HttpPost]
        public JsonResult LGPDetalle(int idProyecto, int idEtapa, int idUsuario)
        {
            try
            {
                var rptLGPDetalle = GenerarDocumeData.CargarLGPDetalle(idProyecto, idEtapa, idUsuario);

                return (Json(new { Success = true, Excel = rptLGPDetalle, fecha = DateTime.Now.ToString("dd/MM/yyyy") }));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message });
            }
        }

        
    }
}
