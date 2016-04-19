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
    public class ListaReporteProduccionEstatusProyecto
    {
        [Display(Name = "Id")]
        public string id { get; set; }

        [Display(Name = "Proceso")]
        public string proceso { get; set; }

        [Display(Name = "Categoria")]
        public string categoria { get; set; }
        
        [Display(Name = "Proyecto")]
        public string proyecto { get; set; }

        [Display(Name = "Etapa")]
        public string etapa { get; set; }

        [Display(Name = "Plano Montaje")]
        public string planoMontaje { get; set; }

        [Display(Name = "Plano Despiece")]
        public string planoDespiece { get; set; }

        [Display(Name = "Marca")]
        public string marca { get; set; }

        [Display(Name = "Serie")]
        public string serie { get; set; }

        [Display(Name = "Dias Proceso")]
        public string diasProceso { get; set; }

        [Display(Name = "Piezas")]
        public string piezas { get; set; }

        [Display(Name = "Peso")]
        public string peso { get; set; }
    }
}
