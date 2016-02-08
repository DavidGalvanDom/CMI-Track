///Propósito: Modelo de Categoria
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
    public class Categoria
    {
        [Display(Name = "id")]
        public int id { get; set; }

        [Required(ErrorMessage = "*")]
        [StringLength(100)]
        [Display(Name = "Nombre Categoria")]
        public string NombreCategoria { get; set; }

        [Display(Name = "Estatus")]
        [Required(ErrorMessage = "*")]
        public string Estatus { get; set; }

        public int usuarioCreacion { get; set; }
        
    }
}
