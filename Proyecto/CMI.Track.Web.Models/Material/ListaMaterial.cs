///Propósito: Modelo de Lista de materiales
///Fecha creación: 02/Febrero/16
///Creador: David Jasso
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
    public class ListaMaterial
    {
        [Display(Name = "id", AutoGenerateField = false)]
        public int id { get; set; }

        [Display(Name = "Nombre")]
        public string NombreMaterial { get; set; }

        [Display(Name = "Ancho")]
        public int AnchoMaterial { get; set; }

        [Display(Name = "UM")]
        public string AnchoUM { get; set; }

        [Display(Name = "Largo")]
        public int LargoMaterial { get; set; }

        [Display(Name = "UM")]
        public string LargoUM { get; set; }

        [Display(Name = "Peso")]
        public int PesoMaterial { get; set; }

        [Display(Name = "UM")]
        public string PesoUM { get; set; }

        [Display(Name = "Calidad")]
        public string CalidadMaterial { get; set; }

        [Display(Name = "Tipo")]
        public string TipoMaterial { get; set; }

        [Display(Name = "Grupo")]
        public string Grupo { get; set; }

        [Display(Name = "Observaciones")]
        public string Observaciones { get; set; }

        [Display(Name = "Estatus")]
        public string Estatus { get; set; }

             
    }
}
