///Propósito:Controlador para generacion de Embarques
///Fecha creación: 20/Abril/16
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
    public class GenerarEmbarqueController : Controller
    {
        /// <summary>
        /// Vista principal para Tablet1
        /// </summary>
        /// <returns>ActionResult</returns>
        public ActionResult Tablet1()
        {
            return View();
        }

        /// <summary>
        /// Vista principal para Tablet1
        /// </summary>
        /// <returns>ActionResult</returns>
        public ActionResult Tablet2()
        {
            return View();
        }

        /// <summary>
        /// Se carga el detalle de la Orden de embarque para darle entrada a los productos
        /// </summary>
        /// <param name="idEtapa"></param>
        /// <returns></returns>
        public JsonResult CargaDetalleOrden(int id)
        {
            try
            {
                var lstDetalleOrdenEmbarque = OrdenEmbarqueData.CargarDetalleOrdenEmbarque(id);

                return (Json(lstDetalleOrdenEmbarque, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }

        /// <summary>
        /// Se registra la marca por serie en la orden de embarque.
        /// </summary>
        /// <param name="idDetalleOrdenEmb"></param>
        /// <param name="idMarca"></param>
        /// <param name="serie"></param>
        /// <param name="origen">Si es embarque EM o entrega de mercancia EN</param>
        /// <param name="idUsuario"></param>
        /// <returns></returns>
        [HttpPost]
        public JsonResult GenerarEmbarque (int idDetaOrdenEmb, int idMarca,
                                            string serie, string origen, 
                                            int idUsuario)
        {
            try
            {
                var resultado = OrdenEmbarqueData.GenerarEmbarque(idDetaOrdenEmb, idMarca, serie, origen,idUsuario);

                if(resultado.Length == 0)
                    return (Json(new { Success = true }, JsonRequestBehavior.AllowGet));
                else
                    return (Json(new { Success = false, Message = resultado }, JsonRequestBehavior.AllowGet));
            }
            catch (Exception exp)
            {
                return Json(new { Success = false, Message = exp.Message }, JsonRequestBehavior.AllowGet);
            }
        }
    }
}
