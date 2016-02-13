///Propósito: Modelo de Lista de usuarios
///Fecha creación: 29/Enero/16
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
    public class ListaUsuario
    {
        [Display(Name = "id", AutoGenerateField = false)]
        public int id { get; set; }

        [Display(Name = "NombreUsuario")]
        public string NombreUsuario { get; set; }


        public string NombreCompleto { get; set; }

        [Display(Name = "Perfil")]
        public string Perfil { get; set; }

        [Display(Name = "Estatus")]
        public int idEstatus { get; set; }

        [Display(Name = "nombreEstatus")]
        public string nombreEstatus { get; set; }

        [Display(Name = "Correo")]
        public string Correo { get; set; }

        [Display(Name = "Fecha")]
        public string fechaCreacion { get; set; }
             
    }
}
