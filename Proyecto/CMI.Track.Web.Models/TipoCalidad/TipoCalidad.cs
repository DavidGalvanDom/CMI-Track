///Propósito: Modelo de Tipo de Calidad
///Fecha creación: 02/Febrero/16
///Creador: Juan Lopepe
///Fecha modificación: 
///Modificó:
///Dependencias de conexiones e interfaces: 

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel.DataAnnotations;

namespace CMI.Track.Web.Models
{
    public class TipoCalidad
    {
        [Display(Name = "id")]
        public int id { get; set; }

        [Required(ErrorMessage = "*")]
        [StringLength(50)]
        [Display(Name = "Tipo Calidad")]
        public string nombreTipoCalidad { get; set; }

        [Display(Name = "Estatus")]
        [Required(ErrorMessage = "*")]
        public int idEstatus { get; set; }

        public int usuarioCreacion { get; set; }
    }
}
