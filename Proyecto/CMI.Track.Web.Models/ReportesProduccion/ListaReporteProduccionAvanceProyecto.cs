///Propósito: Modelo de Lista del Reporte de Produccion de Estatus Proyecto
///Fecha creación: 14/Abril/16
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
    public class ListaReporteProduccionAvanceProyecto
    {
        [Display(Name = "Id")]
        public string id { get; set; }

        [Display(Name = "Etapa")]
        public string etapa { get; set; }

        [Display(Name = "Plano Montaje")]
        public string planoMontaje { get; set; }
        
        [Display(Name = "Avance")]
        public string avance { get; set; }

        [Display(Name = "Fecha Inicial")]
        public string fechaIni { get; set; }

        [Display(Name = "Fecha Final")]
        public string fechaFin { get; set; }
    }
}
