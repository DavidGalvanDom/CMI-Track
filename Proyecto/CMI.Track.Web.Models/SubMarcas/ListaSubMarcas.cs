///Propósito: Modelo de Lista de SubMarcas
///Fecha creación: 07/Marzo/16
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
   public class ListaSubMarcas
    {
        [Display(Name = "id")]
        public int id { get; set; }      

        [Display(Name = "Codigo")]
        public string codigoSubMarca { get; set; }

        [Display(Name = "Perfil")]
        public string perfilSubMarca { get; set; }

        [Display(Name = "Piezas")]
        public int piezasSubMarcas { get; set; }

        [Display(Name = "Corte")]
        public double corteSubMarcas { get; set; }

        [Display(Name = "Longitud")]
        public double longitudSubMarcas { get; set; }

        [Display(Name = "Ancho")]
        public double anchoSubMarcas { get; set; }

        [Display(Name = "Grado")]
        public string gradoSubMarcas { get; set; }

        [Display(Name = "KG/M")]
        public double kgmSubMarcas { get; set; }

        [Display(Name = "Total L/A")]
        public double totalLASubMarcas { get; set; }

        [Display(Name = "Peso")]
        public double pesoSubMarcas { get; set; }

        [Display(Name = "Estatus")]
        public string nombreEstatus { get; set; } 
    }
}
