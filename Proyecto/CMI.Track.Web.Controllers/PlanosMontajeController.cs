///Propósito:Controlador para el modulo de Planes de Montaje
///Fecha creación: 20/Febrero/16
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
    public class PlanosMontajeController : Controller
    {
        /// <summary>
        /// Vista principal para catalogo de Etapas
        /// </summary>
        /// <returns>ActionResult</returns>
        public ActionResult Index()
        {
            return View();
        }

        /// <summary>
        /// Se cargan los planos de montaje de la etapa seleccionada
        /// </summary>
        /// <param name="idEtapa"></param>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaPlanosMontaje(int idEtapa)
        {
            try
            {
                var lstPlanosMontaje = PlanosMontajeData.CargaPlanosMontaje(idEtapa, null);

                return (Json(lstPlanosMontaje, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Se cargan solo los proyectos que esten activos.
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public JsonResult CargaPlanosMontajeActivos(int idEtapa)
        {
            try
            {
                var lstPlanosMontaje = PlanosMontajeData.CargaPlanosMontaje(idEtapa, 1); //1 Activo

                return (Json(lstPlanosMontaje, JsonRequestBehavior.AllowGet));
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
            var objPlanosMontaje = new Models.PlanosMontaje() { fechaCreacion = DateTime.Now.ToString("dd/MM/yyyy"), idEstatus=1 };
            ViewBag.Titulo = "Nuevo";
            return PartialView("_Nuevo", objPlanosMontaje);
        }


        /// <summary>
        /// Define un nuevo Plano montaje 
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpPost]
        public JsonResult Nuevo(Models.PlanosMontaje pobjModelo)
        {
            string pathArchivo = ConfigurationManager.AppSettings["PathArchivos"].ToString() + "PlanoMontaje\\";
            string pathArchivoTem = ConfigurationManager.AppSettings["PathArchivosTem"].ToString();

            if (ModelState.IsValid)
            {
                try
                {
                    if (pobjModelo.archivoPlanoMontaje != null)
                    {
                        if (!System.IO.File.Exists(pathArchivoTem + pobjModelo.archivoPlanoMontaje))
                        {
                            return Json(new { Success = false, Message = "No se encontro el archivo en el servidor " });
                        }

                        if (System.IO.File.Exists(pathArchivo + pobjModelo.archivoPlanoMontaje))
                            System.IO.File.Delete(pathArchivo + pobjModelo.archivoPlanoMontaje);

                        System.IO.File.Move(pathArchivoTem + pobjModelo.archivoPlanoMontaje, pathArchivo + pobjModelo.archivoPlanoMontaje);
                    }

                    var idPlanoMontaje = PlanosMontajeData.Guardar(pobjModelo);
                    return Json(new { Success = true, id = idPlanoMontaje, Message = "Se guardo correctamente el Plano Montaje " });
                }
                catch (Exception exp)
                {
                    return Json(new { Success = false, Message = exp.Message });
                }
            }

            return Json(new { Success = false, Message = "La informacion del Plano Montaje esta incompleta." });
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
        /// Se carga la vista parcial para actulizar el Plano Montaje
        /// </summary>
        /// <param name="id"></param>
        /// <returns></returns>
        [HttpGet]
        public ActionResult Actualiza(int id)
        {
            var objPlanoMontaje = PlanosMontajeData.CargaPlanoMontaje(id);
            return PartialView("_Actualiza", objPlanoMontaje);
        }

        /// <summary>
        /// Actualiza la informacion del Plano montaje
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpPost]
        public ActionResult Actualiza(Models.PlanosMontaje pobjModelo)
        {
            string pathArchivo = ConfigurationManager.AppSettings["PathArchivos"].ToString() + "PlanoMontaje\\";
            string pathArchivoTem = ConfigurationManager.AppSettings["PathArchivosTem"].ToString();

            if (ModelState.IsValid)
            {
                try
                {
                    if (pobjModelo.archivoPlanoMontaje != null)
                    {
                        if (System.IO.File.Exists(pathArchivoTem + pobjModelo.archivoPlanoMontaje))
                        {
                            if (System.IO.File.Exists(pathArchivo + pobjModelo.archivoPlanoMontaje))
                                System.IO.File.Delete(pathArchivo + pobjModelo.archivoPlanoMontaje);

                            System.IO.File.Move(pathArchivoTem + pobjModelo.archivoPlanoMontaje, pathArchivo + pobjModelo.archivoPlanoMontaje);
                        }
                    }

                    PlanosMontajeData.Actualiza(pobjModelo);
                    return Json(new { Success = true, id = pobjModelo.id.ToString(), Message = "Se actualizo la informacion del Plano montaje." });
                }
                catch (Exception exp)
                {
                    return Json(new { Success = false, Message = exp.Message });
                }
            }

            return Json(new { Success = false, Message = "La informacion del Plano Montaje esta incompleta" });          
           
        }

        /// <summary>
        /// Carga el formulario para clonar un Plano Montaje
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpGet]
        public ActionResult Clonar(int id)
        {
            var objPlanoMontaje = PlanosMontajeData.CargaPlanoMontaje(id);
            objPlanoMontaje.id = 0;
            objPlanoMontaje.archivoPlanoMontaje = "";
            objPlanoMontaje.nombreArchivo = "";
            objPlanoMontaje.fechaCreacion = DateTime.Now.ToString("dd/MM/yyyy");
            ViewBag.Titulo = "Clonar";
            return PartialView("_Nuevo", objPlanoMontaje);
        }


        /// <summary>
        /// Borra el Plano montaje
        /// </summary>
        /// <returns>ActionResult</returns>
        [HttpPost]
        public JsonResult Borrar(int id)
        {
            try
            {
                PlanosMontajeData.Borrar(id);
                return Json(new { Success = true, Message = "Se borro correctamente el Plano Montaje. (" + id.ToString() + ")" });
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message });
            }
        }


        /// <summary>
        /// Despliega ventana emergente con el grid de proyectos
        /// </summary>
        /// <returns></returns>
        [HttpGet]
        public ActionResult BuscarPlanosMontaje()
        {
            return PartialView("_buscarPlanosMontaje");
        }

    }
}
