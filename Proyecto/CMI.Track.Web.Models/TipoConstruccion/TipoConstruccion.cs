///Propósito: Modelo de Tipo de Construccion 
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
    public class TipoConstruccion
    {
        [Display(Name = "id")]
        public int id { get; set; }

        [Required(ErrorMessage = "*")]
        [StringLength(100)]
        [Display(Name = "Nombre Tipo Construccion")]
        public string NombreTipoConstruccion { get; set; }

        [Display(Name = "Estatus")]
        [Required(ErrorMessage = "*")]
        public string Estatus { get; set; }

        public int usuarioCreacion { get; set; }
    }
}
