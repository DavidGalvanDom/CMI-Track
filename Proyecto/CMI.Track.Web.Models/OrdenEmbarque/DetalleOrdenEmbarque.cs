///Propósito: Modelo de detalle orden embarque
///Fecha creación: 21/Abril/16
///Creador: David Galvan
///Fecha modifiacción: 
///Modifico:
///Dependencias de conexiones e interfaces: 

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel.DataAnnotations;

namespace CMI.Track.Web.Models
{
    public  class DetalleOrdenEmbarque
    {
        [Display(Name = "id")]
        public string id { get; set; }

        [Display(Name = "claveEtapa")]
        public string claveEtapa { get; set; }

        [Display(Name = "nombreProyecto")]
        public string nombreProyecto { get; set; }

        [Display(Name = "idOrdenEmbarque")]
        public int idOrdenEmbarque { get; set; }

        [Display(Name = "idMarca")]
        public int idMarca { get; set; }

         [Display(Name = "nombreMarca")]
        public string nombreMarca { get; set; }

        [Display(Name = "piezasLeidas")]
        public int piezasLeidas { get; set; }

        [Display(Name = "piezas")]
        public int piezas { get; set; }

        [Display(Name = "peso")]
        public double peso { get; set; }

        [Display(Name = "Estatus")]
        public int estatusEmbarque { get; set; }

        [Display(Name = "Nombre Plano")]
        public string nombrePlano { get; set; }

        [Display(Name = "Saldo")]
        public int Saldo { get; set; }

         [Display(Name = "pesoTotal")]
        public double pesoTotal { get; set; }
    }
}
