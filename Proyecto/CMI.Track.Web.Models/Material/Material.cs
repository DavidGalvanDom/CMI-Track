///Propósito: Modelo de material 
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
    public class Material
    {
        [Display(Name = "id")]
        public int id { get; set; }

        [Required(ErrorMessage = "*")]
        [StringLength(100)]
        [Display(Name = "Nombre Material")]
        public string NombreMaterial { get; set; }

        [Display(Name = "Ancho")]
        [Required(ErrorMessage = "*")]
        public int AnchoMaterial { get; set; }

        [Display(Name = "UM")]
        [Required(ErrorMessage = "*")]
        public string AnchoUM { get; set; }

        [Display(Name = "Largo")]
        [Required(ErrorMessage = "*")]
        public int LargoMaterial { get; set; }

        [Display(Name = "UM")]
        [Required(ErrorMessage = "*")]
        public string LargoUM { get; set; }

        [Display(Name = "Peso")]
        [Required(ErrorMessage = "*")]
        public int PesoMaterial { get; set; }

        [Display(Name = "UM")]
        [Required(ErrorMessage = "*")]
        public string PesoUM { get; set; }

        [Required(ErrorMessage = "*")]
        [StringLength(100)]
        [Display(Name = "Calidad")]
        public string CalidadMaterial { get; set; }

        [Display(Name = "Tipo")]
        [Required(ErrorMessage = "*")]
        public string TipoMaterial { get; set; }

        [Display(Name = "Grupo")]
        [Required(ErrorMessage = "*")]
        public string Grupo { get; set; }

        [Required(ErrorMessage = "*")]
        [StringLength(100)]
        [Display(Name = "Observaciones")]
        public string Observaciones { get; set; }

        [Display(Name = "Estatus")]
        [Required(ErrorMessage = "*")]
        public string Estatus { get; set; }

        public int usuarioCreacion { get; set; }
    }
}
