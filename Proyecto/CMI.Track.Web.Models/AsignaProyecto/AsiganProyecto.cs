///Propósito: Modelo de Asignar materiales a proyecto
///Fecha creación: 30/Marzo/16
///Creador: David Jasso
///Fecha modifiacción: 
///Modificó:
///Dependencias de conexiones e interfaces: 

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel.DataAnnotations;

namespace CMI.Track.Web.Models
{
    public class AsignaProyecto
    {
        [Display(Name = "id")]
        public int id { get; set; }

        [Display(Name = "idProyecto")]
        public int idProyecto { get; set; }

        [Display(Name = "idEtapa")]
        public int idEtapa { get; set; }

        [Display(Name = "idAlmacen")]
        public int idAlmacen { get; set; }

        [Display(Name = "idRequisicion")]
        public int idReq { get; set; }

        [Display(Name = "idMaterial")]
        public int idMaterialSelect { get; set; }

        [Display(Name = "CantEntrega")]
        public double cantEntrega { get; set; }

        [Display(Name = "Revision")]
        public string Revision { get; set; }

        [Display(Name = "NombreMat")]
        public string NombreMat { get; set; }

        [Display(Name = "Unidad")]
        public int Unidad { get; set; }

        [Display(Name = "idOrigen")]
        public int idOrigen { get; set; }

        public int usuarioCreacion { get; set; }
        
    }
}
