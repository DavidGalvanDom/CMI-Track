///Propósito: Modelo de Reporte detalle orden embarque
///Fecha creación: 29/Abril/16
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
   public class ReportOrdenEmbarque
    {

        [Display(Name = "idMarca")]
        public int idMarca { get; set; }

        [Display(Name = "nombreMarca")]
        public string nombreMarca { get; set; }
       
        [Display(Name = "piezas")]
        public int piezas { get; set; }

        [Display(Name = "peso")]
        public double peso { get; set; }

        [Display(Name = "Nombre Plano")]
        public string nombrePlano { get; set; }

        [Display(Name = "pesoTotal")]
        public double pesoTotal { get; set; }
    }
}
