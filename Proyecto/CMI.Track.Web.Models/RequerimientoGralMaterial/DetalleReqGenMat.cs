///Propósito: Modelo del detalle del requerimiento general de Materiales
///Fecha creación: 28/Marzo/16
///Creador: David Galvan
///Fecha modifiacción: 
///Modificó:
///Dependencias de conexiones e interfaces: 

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel.DataAnnotations;

namespace CMI.Track.Web.Models
{
   public class DetalleReqGenMat
    {
       public int numRenglon { get; set; }       

        [Display(Name = "Perfil")]
        public string perfilReqGenMat { get; set; }
       
        
        [Display(Name = "Piezas")]
        public int piezasReqGenMat { get; set; }

        
        [Display(Name = "Corte")]
        public double corteReqGenMat { get; set; }

        
        [Display(Name = "Longitud")]
        public double longitudReqGenMat { get; set; }

        
        [Display(Name = "Ancho")]
        public double anchoReqGenMat { get; set; }

        
        [Display(Name = "Grado")]
        public string gradoReqGenMat { get; set; }

        
        [Display(Name = "KG/M")]
        public double kgmReqGenMat { get; set; }

        
        [Display(Name = "Total L/A")]
        public double totalLAReqGenMat { get; set; }

        
        [Display(Name = "Peso")]
        public double pesoReqGenMat { get; set; }

        [Display(Name = "Area")]
        public double areaReqGenMat { get; set; } 

        [Display(Name = "Altura")]
        public double alturaReqGenMat { get; set; }
       
    }
}
