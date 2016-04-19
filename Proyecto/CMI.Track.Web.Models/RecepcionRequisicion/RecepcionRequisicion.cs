///Propósito: Modelo de Recepcion Requisicion Compra
///Fecha creación: 28/Marzo/16
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
    public class RecepcionRequisicion
    {
        [Display(Name = "idItem")]
        public int idItem { get; set; }

        [Display(Name = "idRequerimiento")]
        public int idRequerimiento { get; set; }

        [Display(Name = "idRequisicion")]
        public int idRequisicionF { get; set; }

        [Display(Name = "idMaterialR")]
        public int idMaterialR { get; set; }

        [Display(Name = "nombreMaterial")]
        public string nombreMat { get; set; }

        [Required(ErrorMessage = "*")]
        [Display(Name = "CantidadRecibida")]
        public int cantidadRecibida { get; set; }


        [Required(ErrorMessage = "*")]
        [Display(Name = "CantidadRec")]
        public int cantidadRec { get; set; }

        [Required(ErrorMessage = "*")]
        [Display(Name = "Ancho")]
        public int Ancho { get; set; }


        [Required(ErrorMessage = "*")]
        [Display(Name = "Largo")]
        public int Largo { get; set; }

        [Required(ErrorMessage = "*")]
        [Display(Name = "Peso")]
        public double Peso { get; set; }

        [Required(ErrorMessage = "*")]
        [Display(Name = "Existencia")]
        public int Existencia { get; set; }


        [Required(ErrorMessage = "*")]
        [Display(Name = "cantidadSol")]
        public int cantidadSol { get; set; }

        [Required(ErrorMessage = "*")]
        [Display(Name = "Calidad")]
        public string Calidad { get; set; }

        [Required(ErrorMessage = "*")]
        [Display(Name = "Serie")]
        public string Serie { get; set; }

        [Required(ErrorMessage = "*")]
        [Display(Name = "Factura")]
        public string Factura { get; set; }

        [Required(ErrorMessage = "*")]
        [Display(Name = "Proveedor")]
        public string Proveedor { get; set; }

        [Required(ErrorMessage = "*")]
        [Display(Name = "Fecha Factura")]
        public string FechaFac { get; set; }
        public int usuarioCreacion { get; set; }
       
    }
}
