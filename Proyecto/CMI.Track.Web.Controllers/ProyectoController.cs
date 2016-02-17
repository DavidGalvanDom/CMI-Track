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
        /// Carga la coleccion de Proyectos
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaProyectos()
        {
            try
            {
                var lstProyectos = ProyectoData.CargaProyectos();

                return (Json(lstProyectos, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Define un nuevo usuario
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public ActionResult Nuevo()
        {
            var objProjecto = new Models.Proyecto() {  fechaCreacion = DateTime.Now.ToString("MM/dd/yyyy") };
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
            string pathArchivo = ConfigurationManager.AppSettings["PathArchivosTem"].ToString();

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
                        if (nombreArchivo.Length > 67)
                            nombreArchivo = nombreArchivo.Substring(nombreArchivo.Length - 67, 67);

                        nombreArchivo = string.Format("{0}-{1}", Guid.NewGuid().ToString("N"), nombreArchivo);
                        var path = Path.Combine(pathArchivo, nombreArchivo);
                        using (var fileStream = System.IO.File.Create(path))
                        {
                            stream.CopyTo(fileStream);
                        }
                    }
                }

                return Json(new { Success = true, Archivo = nombreArchivo });
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message });
            }
        }

        /// <summary>
        /// Define un nuevo Proyecto
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpPost]
        public JsonResult Nuevo(Models.Proyecto pobjModelo)
        {
            string pathArchivo = ConfigurationManager.AppSettings["PathArchivos"].ToString();
            string pathArchivoTem = ConfigurationManager.AppSettings["PathArchivosTem"].ToString();
            
            if (ModelState.IsValid)
            {
                try
                {
                    if (pobjModelo.archivoPlanoProyecto != null)
                    {
                        if (!System.IO.File.Exists(pathArchivoTem + pobjModelo.archivoPlanoProyecto))
                        {
                            return Json(new { Success = false, Message = "No se encontro el archivo en el servidor " });
                        }

                        if (System.IO.File.Exists(pathArchivo + pobjModelo.archivoPlanoProyecto))
                            System.IO.File.Delete(pathArchivo + pobjModelo.archivoPlanoProyecto);

                        System.IO.File.Move(pathArchivoTem + pobjModelo.archivoPlanoProyecto, pathArchivo + pobjModelo.archivoPlanoProyecto);
                    }

                    var idProyecto = ProyectoData.Guardar(pobjModelo);
                    return Json(new { Success = true, id = idProyecto, Message = "Se guardo correctamente el Proyecto " });                    
                }
                catch (Exception exp)
                {
                    return Json(new { Success = false, Message = exp.Message });
                }
            }

            return Json(new { Success = false, Message = "La informacion del proyecto esta incompleta" });
        }

        /// <summary>
        /// Carga el formulario para actulizar el proyecto
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public ActionResult Actualiza(int idProyecto, string revision)
        {
            var objProyecto = ProyectoData.CargaProyecto(idProyecto, revision);
            return PartialView("_Actualiza", objProyecto);            
        }

        /// <summary>
        /// Actualiza la informacion del proyecto
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpPost]
        public ActionResult Actualiza(Models.Proyecto pobjModelo)
        {
            string pathArchivo = ConfigurationManager.AppSettings["PathArchivos"].ToString();
            string pathArchivoTem = ConfigurationManager.AppSettings["PathArchivosTem"].ToString();

            if (ModelState.IsValid)
            {
                try
                {
                    if (pobjModelo.archivoPlanoProyecto != null)
                    {
                        if (System.IO.File.Exists(pathArchivoTem + pobjModelo.archivoPlanoProyecto))
                        {
                            if (System.IO.File.Exists(pathArchivo + pobjModelo.archivoPlanoProyecto))
                                System.IO.File.Delete(pathArchivo + pobjModelo.archivoPlanoProyecto);

                            System.IO.File.Move(pathArchivoTem + pobjModelo.archivoPlanoProyecto, pathArchivo + pobjModelo.archivoPlanoProyecto);                            
                        }
                    }

                     ProyectoData.Actualiza(pobjModelo);
                     return Json(new { Success = true, id = pobjModelo.id.ToString() , Message = "Se actualizo la informacion correctamente del Proyecto " });
                }
                catch (Exception exp)
                {
                    return Json(new { Success = false, Message = exp.Message });
                }
            }

            return Json(new { Success = false, Message = "La informacion del proyecto esta incompleta" });          
        }

        /// <summary>
        /// Carga el formulario para actulizar el proyecto
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public ActionResult Clonar(int idProyecto, string revision)
        {
            var objProyecto = ProyectoData.CargaProyecto(idProyecto, revision);
            return PartialView("_Nuevo", objProyecto);
        }


        /// <summary>
        /// Borra el Usuario
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpPost]
        public JsonResult Borrar(int idProyecto, string revision)
        {
            try
            {
                ProyectoData.Borrar(idProyecto, revision);
                return Json(new { Success = true, Message = "Se borro correctamente el Proyecto." });
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message });
            }
        }
    }
}
