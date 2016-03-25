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
    public class ListaImpresionCodigoBarra
    {
        [Display(Name = "IdMS")]
        public string id { get; set; }

        [Display(Name = "Tipo")]
        public string tipo { get; set; }

        [Display(Name = "IdMS")]
        public int idMS { get; set; }

        [Display(Name = "Codigo")]
        public string codigo { get; set; }

        [Display(Name = "Serie")]
        public string serie { get; set; }

        [Display(Name = "Peso")]
        public double peso { get; set; }

        [Display(Name = "Codigo de Barra")]
        public string codigoBarra { get; set; }
    }
}
