///Propósito: Modelo de Lista del Detalle de una Orden de Produccion
///Fecha creación: 19/Febrero/16
///Creador: Juan Lopepe
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
    public class ListaDetalleOrdenProduccion
    {
        [Display(Name = "Seccion")]
        public string seccion { get; set; }

        [Display(Name = "Tipo")]
        public string tipo { get; set; }

        [Display(Name = "Pieza")]
        public int pieza { get; set; }

        [Display(Name = "Marca")]
        public string marca { get; set; }

        [Display(Name = "Serie")]
        public string serie { get; set; }

        [Display(Name = "SubMarca")]
        public string submarca { get; set; }

        [Display(Name = "Perfil")]
        public string perfil { get; set; }

        [Display(Name = "Piezas")]
        public int piezas { get; set; }

        [Display(Name = "NumCorte")]
        public string numCorte { get; set; }
        
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

        [Display(Name = "NumPlano")]
        public string numPlano { get; set; }

        [Display(Name = "Peso")]
        public double peso { get; set; }
        
    }
}
