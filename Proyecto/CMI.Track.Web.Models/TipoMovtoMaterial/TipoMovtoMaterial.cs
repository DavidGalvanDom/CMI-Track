///Propósito: Modelo de Tipo de movto material 
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
    public class TipoMovtoMaterial
    {
        [Display(Name = "id")]
        public int id { get; set; }

        [Required(ErrorMessage = "*")]
        [StringLength(100)]
        [Display(Name = "Nombre Tipo Movimiento")]
        public string NombreTipoMovtoMaterial { get; set; }

        [Required(ErrorMessage = "*")]
        [StringLength(20)]
        [Display(Name = "Tipo Movimiento")]
        public string TipoMovimiento { get; set; }

        [Display(Name = "Estatus")]
        [Required(ErrorMessage = "*")]
        public string Estatus { get; set; }

        public int usuarioCreacion { get; set; }
    }
}
