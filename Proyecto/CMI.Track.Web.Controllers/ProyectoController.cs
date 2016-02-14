///Propósito:Controlador para catalogo de Proyectos
///Fecha creación: 08/Febrero/16
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
   public  class ProyectoController : Controller
    {
        /// <summary>
        /// Vista principal para catalogo de Proyectos
        /// </summary>
        /// <returns>ActionResult</returns>
        public ActionResult Index()
        {
            return View();
        }

        /// <summary>
        /// Define un nuevo usuario
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public ActionResult Nuevo()
        {
            var objProjecto = new Models.Projecto() {  fechaCreacion = DateTime.Now.ToString("MM/dd/yyyy") };
            ViewBag.Titulo = "Nuevo";
            return PartialView("_Nuevo", objProjecto);
        }

        /// <summary>
        /// Metodo para subir los archivos del proyecto
        /// </summary>
        /// <returns></returns>
        [HttpPost]
        public JsonResult SubirArchivo()
        {
            string nombreArchivo = "";
            string pathArchivo = ConfigurationManager.AppSettings["PathArchvos"].ToString();

            try
            {
                foreach (string file in Request.Files)
                {
                    var fileContent = Request.Files[file];
                    if (fileContent != null && fileContent.ContentLength > 0)
                    {
                        // get a stream
                        var stream = fileContent.InputStream;
                        // and optionally write the file to disk
                        nombreArchivo = Path.GetFileName(file);
                        var path = Path.Combine(pathArchivo, nombreArchivo);
                        using (var fileStream = System.IO.File.Create(path))
                        {
                            stream.CopyTo(fileStream);
                        }
                    }
                }

                return Json(new { Success = false, Archivo = nombreArchivo });
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message });
            }
        }
    }
}
