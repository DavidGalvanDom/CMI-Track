///Propósito: Modelo de Departamentos
///Fecha creación: 06/Febrero/16
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
    public class Departamento
    {

        [Required(ErrorMessage = "*")]
        [Display(Name = "id", AutoGenerateField = false)]
        public int id { get; set; }

        [Required(ErrorMessage = "*")]
        [StringLength(255)]
        [Display(Name = "Nombre")]
        public string Nombre { get; set; }

        [Required(ErrorMessage = "*")]
        [Display(Name = "Estatus")]
        public int idEstatus { get; set; }

        [Display(Name = "Fecha")]
        public string fechaCreacion { get; set; }

        public int usuarioCreacion { get; set; }
    }
}
