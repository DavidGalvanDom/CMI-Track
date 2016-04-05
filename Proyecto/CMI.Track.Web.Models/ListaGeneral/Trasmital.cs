///Propósito: Modelo de Reporte Trasmital
///Fecha creación: 04/Abril/16
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
    public class Trasmital
    {
        [Display(Name = "Montaje")]
        public string planoMontaje { get; set; }

        [Display(Name = "ClaveMontaje")]
        public string claveMontaje { get; set; }


        [Display(Name = "Despiece")]
        public string planoDespiece { get; set; }

        [Display(Name = "ClaveDespiece")]
        public string claveDespiece { get; set; }
    }
}
