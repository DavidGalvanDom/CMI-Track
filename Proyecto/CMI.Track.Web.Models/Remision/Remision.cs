///Propósito: Modelo de Remisiones
///Fecha creación: 24/Marzo/16
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
    public class Remision
    {
        [Display(Name = "id")]
        public int id { get; set; }

        [Display(Name="idCliente")]
        [Required(ErrorMessage = "*")]
        public int idCliente { get; set; }

        [Display(Name = "Transporte")]
        [Required(ErrorMessage = "*")]
        public string transporte { get; set; }

        [Display(Name = "Placas")]
        [Required(ErrorMessage = "*")]
        public string placas { get; set; }

        [Display(Name = "Conductor")]
        [Required(ErrorMessage = "*")]
        public string conductor { get; set; }

        [Display(Name = "Fecha Envio")]
        [Required(ErrorMessage = "*")]
        public string fechaEnvio { get; set; }

        [Display(Name = "Fecha Remision")]
        public string fechaRemision { get; set; }

        [Display(Name = "Usuario Creacion")]
        public int usuarioCreacion { get; set; }

        [Required(ErrorMessage = "*")]
        public int idProyecto { get; set; }

        [Required(ErrorMessage = "*")]
        public int idEtapa { get; set; }

        [Required(ErrorMessage = "*")]
        public List<int> lstOrdenEmbarque { get; set; }

        public string nombreCliente { get; set; }

        public string direccionCliente { get; set; }

        public string nombreContacto { get; set; }

    }
}
