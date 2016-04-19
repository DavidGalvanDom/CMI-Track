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
    public class ListaRecepcionRequisicion
    {
        [Display(Name = "id", AutoGenerateField = false)]
        public int id { get; set; }

        [Display(Name = "IdRequerimiento")]
        public string idRequerimiento { get; set; }

        [Display(Name = "IdRequisicion")]
        public int idRequisicion { get; set; }

        [Display(Name = "idMaterial")]
        public int idMaterial { get; set; }

        [Display(Name = "Material")]
        public string nombreMaterial { get; set; }

        [Display(Name = "UM")]
        public string UM { get; set; }

        [Display(Name = "Calidad")]
        public string Calidad { get; set; }

        [Display(Name = "Ancho")]
        public int Ancho { get; set; }

        [Display(Name = "Largo")]
        public int Largo { get; set; }

        [Display(Name = "Cantidad Solicitada")]
        public int cantidadSol { get; set; }

        [Display(Name = "Existencia")]
        public int Existencia { get; set; }

        [Display(Name = "Cantidad Recibida")]
        public int cantidadRecibida { get; set; }

        [Display(Name = "LongArea")]
        public double LongArea { get; set; }

        [Display(Name = "Peso")]
        public double Peso { get; set; }



        [Display(Name = "Total")]
        public double Total { get; set; }


        

    }
}
