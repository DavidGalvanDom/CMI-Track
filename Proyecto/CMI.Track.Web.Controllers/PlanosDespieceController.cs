///Propósito:Controlador para la administracion de Planos Despiece
///Fecha creación: 23/Febrero/16
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
   public class PlanosDespieceController : Controller
   {

       /// <summary>
       /// Vista principal Planos despiece
       /// </summary>
       /// <returns>ActionResult</returns>
       public ActionResult Index()
       {
           return View();
       }

       /// <summary>
       /// Se cargan los planos de despliece del plano de montaje seleccionado
       /// </summary>
       /// <param name="idEtapa"></param>
       /// <returns></returns>
       [HttpGet]
       public JsonResult CargaPlanosDespiece(int idPlanoMontaje)
       {
           try
           {
               var lstPlanosDespiece = PlanosDespieceData.CargaPlanosDespiece(idPlanoMontaje, null);

               return (Json(lstPlanosDespiece, JsonRequestBehavior.AllowGet));
           }
           catch (Exception exp)
           {
               return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
           }
       }

       /// <summary>
       /// Se cargan solo los Planos de despiece que esten activos de un plano de montaje
       /// </summary>
       /// <returns></returns>
       [HttpGet]
       public JsonResult CargaPlanosDespieceActivos(int idPlanoMontaje)
       {
           try
           {
               var lstPlanosDespiece = PlanosDespieceData.CargaPlanosDespiece(idPlanoMontaje, 1); //1 Activo

               return (Json(lstPlanosDespiece, JsonRequestBehavior.AllowGet));
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
           var objPlanosDespiece = new Models.PlanosDespiece() { fechaCreacion = DateTime.Now.ToString("dd/MM/yyyy"), idEstatus = 1 };
           ViewBag.Titulo = "Nuevo";
           return PartialView("_Nuevo", objPlanosDespiece);
       }


       /// <summary>
       /// Define un nuevo Plano montaje 
       /// </summary>
       /// <returns>ActionResult</returns>
       [HttpPost]
       public JsonResult Nuevo(Models.PlanosDespiece pobjModelo)
       {
           string pathArchivo = ConfigurationManager.AppSettings["PathArchivos"].ToString() + "PlanoDespiece\\";
           string pathArchivoTem = ConfigurationManager.AppSettings["PathArchivosTem"].ToString();

           if (ModelState.IsValid)
           {
               try
               {
                   if (pobjModelo.archivoPlanoDespiece != null)
                   {
                       if (!System.IO.File.Exists(pathArchivoTem + pobjModelo.archivoPlanoDespiece))
                       {
                           return Json(new { Success = false, Message = "No se encontro el archivo en el servidor " });
                       }

                       if (System.IO.File.Exists(pathArchivo + pobjModelo.archivoPlanoDespiece))
                           System.IO.File.Delete(pathArchivo + pobjModelo.archivoPlanoDespiece);

                       System.IO.File.Move(pathArchivoTem + pobjModelo.archivoPlanoDespiece, pathArchivo + pobjModelo.archivoPlanoDespiece);
                   }

                   var idPlanoDespiece = PlanosDespieceData.Guardar(pobjModelo);
                   return Json(new { Success = true, id = idPlanoDespiece, Message = "Se guardo correctamente el Plano Despiece " });
               }
               catch (Exception exp)
               {
                   return Json(new { Success = false, Message = exp.Message });
               }
           }

           return Json(new { Success = false, Message = "La informacion del Plano de despiece esta incompleta." });
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
       /// Se carga la vista parcial para actulizar el Plano Despiece
       /// </summary>
       /// <param name="id"></param>
       /// <returns></returns>
       [HttpGet]
       public ActionResult Actualiza(int id)
       {
           var objPlanoDespiece = PlanosDespieceData.CargaPlanoDespiece(id);
           return PartialView("_Actualiza", objPlanoDespiece);
       }

       /// <summary>
       /// Actualiza la informacion del Plano montaje
       /// </summary>
       /// <returns>ActionResult</returns>
       [HttpPost]
       public ActionResult Actualiza(Models.PlanosDespiece pobjModelo)
       {
           string pathArchivo = ConfigurationManager.AppSettings["PathArchivos"].ToString() + "PlanoDespiece\\";
           string pathArchivoTem = ConfigurationManager.AppSettings["PathArchivosTem"].ToString();

           if (ModelState.IsValid)
           {
               try
               {
                   if (pobjModelo.archivoPlanoDespiece != null)
                   {
                       if (System.IO.File.Exists(pathArchivoTem + pobjModelo.archivoPlanoDespiece))
                       {
                           if (System.IO.File.Exists(pathArchivo + pobjModelo.archivoPlanoDespiece))
                               System.IO.File.Delete(pathArchivo + pobjModelo.archivoPlanoDespiece);

                           System.IO.File.Move(pathArchivoTem + pobjModelo.archivoPlanoDespiece, pathArchivo + pobjModelo.archivoPlanoDespiece);
                       }
                   }

                   PlanosDespieceData.Actualiza(pobjModelo);
                   return Json(new { Success = true, id = pobjModelo.id.ToString(), Message = "Se actualizo la informacion del Plano despiece." });
               }
               catch (Exception exp)
               {
                   return Json(new { Success = false, Message = exp.Message });
               }
           }

           return Json(new { Success = false, Message = "La informacion del Plano Despiece esta incompleta" });

       }

       /// <summary>
       /// Carga el formulario para clonar un Plano Despiece
       /// </summary>
       /// <returns>ActionResult</returns>
       [HttpGet]
       public ActionResult Clonar(int id)
       {
           var objPlanoDespiece = PlanosDespieceData.CargaPlanoDespiece(id);
           objPlanoDespiece.id = 0;
           objPlanoDespiece.archivoPlanoDespiece = "";
           objPlanoDespiece.nombreArchivo = "";
           objPlanoDespiece.fechaCreacion = DateTime.Now.ToString("dd/MM/yyyy");
           ViewBag.Titulo = "Clonar";
           return PartialView("_Nuevo", objPlanoDespiece);
       }


       /// <summary>
       /// Borra el Plano despiece
       /// </summary>
       /// <returns>ActionResult</returns>
       [HttpPost]
       public JsonResult Borrar(int id)
       {
           try
           {
               PlanosDespieceData.Borrar(id);
               return Json(new { Success = true, Message = "Se borro correctamente el Plano Despiece. (" + id.ToString() + ")" });
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
       public ActionResult BuscarPlanosDespiece()
       {
           return PartialView("_buscarPlanosDespiece");
       }

   }

}
