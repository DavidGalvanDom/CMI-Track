///Propósito: Modelo de Lista del Reporte de Produccion de Calidad
///Fecha creación: 04/Abril/16
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
    public class ListaReporteProduccionCalidad
    {
        [Display(Name = "Id")]
        public string id { get; set; }

        [Display(Name = "Fecha")]
        public string fecha { get; set; }

        [Display(Name = "Proyecto")]
        public string proyecto { get; set; }

        [Display(Name = "Etapa")]
        public string etapa { get; set; }

        [Display(Name = "Marca")]
        public string marca { get; set; }

        [Display(Name = "Serie")]
        public string serie { get; set; }

        public string piezas { get; set; }

        [Display(Name = "Peso")]
        public string peso { get; set; }

        [Display(Name = "Proceso")]
        public string proceso { get; set; }

        [Display(Name = "Usuario")]
        public string usuario { get; set; }

        [Display(Name = "Longitud")]
        public string longitud { get; set; }

        [Display(Name = "Barrenacion")]
        public string barrenacion { get; set; }

        [Display(Name = "Placa")]
        public string placa { get; set; }

        [Display(Name = "Soldadura")]
        public string soldadura { get; set; }

        [Display(Name = "Pintura")]
        public string pintura { get; set; }

        [Display(Name = "Estatus")]
        public string estatus { get; set; }

        [Display(Name = "Observaciones")]
        public string observaciones { get; set; }
    }
}
