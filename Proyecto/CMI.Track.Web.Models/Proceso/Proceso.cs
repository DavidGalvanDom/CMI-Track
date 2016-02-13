///Propósito: Modelo de Proceso 
///Fecha creación: 10/Febrero/16
///Creador: Juan Lopepe
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
    public class Proceso
    {
        [Display(Name = "id")]
        public int id { get; set; }

        [Required(ErrorMessage = "*")]
        [StringLength(50)]
        [Display(Name = "Proceso")]
        public string nombreProceso { get; set; }

        [Display(Name = "Estatus")]
        [Required(ErrorMessage = "*")]
        public int idEstatus { get; set; }

        [Display(Name = "TipoProceso")]
        [Required(ErrorMessage = "*")]
        public int idTipoProceso { get; set; }

        public int usuarioCreacion { get; set; }
    }
}
