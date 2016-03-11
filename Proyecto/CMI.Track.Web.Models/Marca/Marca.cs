///Propósito: Modelo de Marca
///Fecha creación: 25/Febrero/16
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
    public class Marca
    {
        [Required(ErrorMessage = "*")]
        [Display(Name = "id")]
        public int id { get; set; }


        [Required(ErrorMessage = "*")]
        [StringLength(50)]
        [Display(Name = "Nombre")]
        public string nombreMarca { get; set; }

        [Required(ErrorMessage = "*")]
        [StringLength(20)]
        [Display(Name = "Codigo")]
        public string codigoMarca { get; set; }

        [Required(ErrorMessage = "*")]
        [Display(Name = "Estatus")]
        public int idEstatus { get; set; }

        [Required(ErrorMessage = "*")]
        [Display(Name = "Peso")]
        public double pesoMarca { get; set; }

        [Required(ErrorMessage = "*")]
        [Display(Name = "Piezas")]
        public int piezas { get; set; }

        [Required(ErrorMessage = "*")]
        [Display(Name = "Plano despiece")]
        public int idPlanoDespiece { get; set; }

        [Display(Name = "Creacion")]
        public string fechaCreacion { get; set; }

        [Required(ErrorMessage = "*")]
        [Display(Name = "Usuario Creacion")]
        public int usuarioCreacion { get; set; }


    }
}
