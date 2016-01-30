///Propósito: Modelo de Autentificacion
///Fecha creación: 28/Enero/16
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
    public class Login
    {

        [Required(ErrorMessage = "*")]      
        [Display(Name = "Nombre usuario")]
        public string NombreUsuario { get; set; }

        [Required(ErrorMessage = "*")]       
        [Display(Name = "Contrasena")]
        public string Contrasena { get; set; }
    }
}
