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
    public class ListaReporteProduccionPorPersona
    {
        [Display(Name = "Id")]
        public string id { get; set; }

        [Display(Name = "Fecha")]
        public string fecha { get; set; }

        [Display(Name = "Id Usuario")]
        public int idUsuario { get; set; }

        [Display(Name = "Usuario")]
        public string usuario { get; set; }

        [Display(Name = "Id Proyecto")]
        public int idProyecto { get; set; }

        [Display(Name = "Proyecto")]
        public string proyecto { get; set; }

        [Display(Name = "Etapa")]
        public string etapa { get; set; }

        [Display(Name = "Clase")]
        public string clase { get; set; }

        [Display(Name = "Elemento")]
        public string elemento { get; set; }

        [Display(Name = "Id Serie")]
        public string idSerie { get; set; }

        [Display(Name = "Proceso")]
        public string proceso { get; set; }

        [Display(Name = "Peso")]
        public string peso { get; set; }

    }
}
