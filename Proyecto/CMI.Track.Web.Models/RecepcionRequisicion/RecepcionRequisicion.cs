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

        [Display(Name = "CantidadRecibida")]
        public int cantidadRecibida { get; set; }



        [Display(Name = "CantidadRec")]
        public int cantidadRec { get; set; }


        [Display(Name = "Ancho")]
        public int Ancho { get; set; }


        [Display(Name = "Largo")]
        public int Largo { get; set; }

        [Display(Name = "Peso")]
        public double Peso { get; set; }


        [Display(Name = "Existencia")]
        public int Existencia { get; set; }



        [Display(Name = "cantidadSol")]
        public int cantidadSol { get; set; }

  
        [Display(Name = "Calidad")]
        public string Calidad { get; set; }

        [Display(Name = "Serie")]
        public string Serie { get; set; }

  
        [Display(Name = "Factura")]
        public string Factura { get; set; }


        [Display(Name = "Proveedor")]
        public string Proveedor { get; set; }


        [Display(Name = "Fecha Factura")]
        public string FechaFac { get; set; }

        [Required(ErrorMessage = "*")]
        [Display(Name = "Lista de  ")]
        public List<string> lstMS { get; set; }
        public int usuarioCreacion { get; set; }
       
    }
}
