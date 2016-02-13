///Propósito: Modelo de CalidadProceso
///Fecha creación: 12/Febrero/16
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
    public class CalidadProceso
    {
        [Display(Name = "Proceso")]
        [Required(ErrorMessage = "*")]
        public int idProceso { get; set; }

        [Display(Name = "Secuencia")]
        [Required(ErrorMessage = "*")]
        public int secuencia { get; set; }

        [Display(Name = "Tipo Calidad")]
        [Required(ErrorMessage = "*")]
        public int idTipoCalidad { get; set; }

        [Display(Name = "Estatus")]
        [Required(ErrorMessage = "*")]
        public int idEstatus { get; set; }

        public int usuarioCreacion { get; set; }
    }
}
