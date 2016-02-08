///Propósito: Modelo de Almacen
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
    public class Almacen
    {
        [Display(Name = "id")]
        public int id { get; set; }

        [Required(ErrorMessage = "*")]
        [StringLength(50)]
        [Display(Name = "Almacen")]
        public string nombreAlmacen { get; set; }

        [Display(Name = "Estatus")]
        [Required(ErrorMessage = "*")]
        public int idEstatus { get; set; }

        public int usuarioCreacion { get; set; }
    }
}
