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
    public class ListaReporteProduccionDiasProceso
    {
        [Display(Name = "Id")]
        public string id { get; set; }

        [Display(Name = "Id Proyecto")]
        public int idProyecto { get; set; }

        [Display(Name = "Proyecto")]
        public string proyecto { get; set; }

        [Display(Name = "Id Etapa")]
        public int idEtapa { get; set; }

        [Display(Name = "Etapa")]
        public string etapa { get; set; }

        [Display(Name = "Clase")]
        public string clase { get; set; }

        [Display(Name = "Id Elemento")]
        public int idElemento { get; set; }

        [Display(Name = "Elemento")]
        public string elemento { get; set; }

        [Display(Name = "Id Serie")]
        public string idSerie { get; set; }

        public int piezas { get; set; }

        [Display(Name = "Dias Proceso")]
        public int diasProceso { get; set; }

        [Display(Name = "Fecha Inicio")]
        public string fechaInicio { get; set; }
        
        [Display(Name = "Peso")]
        public string peso { get; set; }

        [Display(Name = "CORTE")]
        public string corte { get; set; }

        [Display(Name = "PANTOGRAFO")]
        public string pantografo { get; set; }

        [Display(Name = "ENSAMBLE")]
        public string ensamble { get; set; }

        [Display(Name = "CALIDAD ENSAMBLE")]
        public string calidadEnsamble { get; set; }

        [Display(Name = "SOLDADURA")]
        public string soldadura { get; set; }

        [Display(Name = "CALIDAD SOLDADURA")]
        public string calidadSoldadura { get; set; }

        [Display(Name = "LIMPIEZA")]
        public string limpieza { get; set; }

        [Display(Name = "PINTURA")]
        public string pintura { get; set; }

        [Display(Name = "CALIDAD FINAL")]
        public string calidadFinal { get; set; }
    }
}
