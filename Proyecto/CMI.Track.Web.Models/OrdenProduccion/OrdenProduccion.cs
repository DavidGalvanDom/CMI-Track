///Propósito: Modelo de Orden de produccion
///Fecha creación: 31/Marzo/16
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
   public class OrdenProduccion
    {

        [Display(Name = "Montaje")]
        public string planoMontaje { get; set; }

        [Display(Name = "Despiece")]
        public string planoDespiece { get; set; }

        [Display(Name = "Pieza")]
        public int piezaMarca { get; set; }

        [Display(Name = "Marca")]
        public string marca { get; set; }       

        [Display(Name = "SubMarca")]
        public string submarca { get; set; }

        [Display(Name = "Perfil")]
        public string perfil { get; set; }

        [Display(Name = "Piezas")]
        public int piezas { get; set; }

        [Display(Name = "Corte")]
        public double corte { get; set; }

        [Display(Name = "Longitud")]
        public double longitud { get; set; }

        [Display(Name = "Ancho")]
        public double ancho { get; set; }

        [Display(Name = "Grado")]
        public string grado { get; set; }

        [Display(Name = "KGM")]
        public double kgm { get; set; }

        [Display(Name = "TotalLA")]
        public double totalLA { get; set; }

        [Display(Name = "Total")]
        public double total { get; set; }      

        [Display(Name = "Peso")]
        public double peso { get; set; }
    }
}
