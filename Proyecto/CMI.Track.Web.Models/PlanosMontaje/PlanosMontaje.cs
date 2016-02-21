///Propósito: Modelo de Planos Montaje
///Fecha creación: 20/Febrero/16
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
   public class PlanosMontaje
    {
        [Required(ErrorMessage = "*")]       
        [Display(Name = "id")]
        public int id { get; set; }

        [Required(ErrorMessage = "*")]
        [Display(Name = "idEtapa")]
        public int idEtapa { get; set; }

        [Required(ErrorMessage = "*")]
        [StringLength(20)]
        [Display(Name = "Nombre")]
        public string nombrePlanoMontaje { get; set; }

        [Required(ErrorMessage = "*")]
        [StringLength(20)]
        [Display(Name = "Codigo")]
        public string codigoPlanoMontaje { get; set; }

        [Required(ErrorMessage = "*")]
        [StringLength(10)]
        [Display(Name = "Fecha Inicio")]
        public string fechaInicio { get; set; }

        [Required(ErrorMessage = "*")]
        [StringLength(10)]
        [Display(Name = "Fecha Fin")]
        public string fechaFin { get; set; }

        [Required(ErrorMessage = "*")]
        [Display(Name = "Estatus")]
        public int idEstatus { get; set; }

        [Display(Name = "Creacion")]
        public string fechaCreacion { get; set; }

        [Required(ErrorMessage = "*")]
        [StringLength(100)]
        [Display(Name = "Archivo")]
        public string archivoPlanoMontaje { get; set; }

        [Required(ErrorMessage = "*")]
        [StringLength(250)]
        [Display(Name = "Informacion General")]
        public string infGeneralPlanoMontaje { get; set; }

        [Required(ErrorMessage = "*")]        
        [Display(Name = "Usuario Creacion")]
        public int usuarioCreacion { get; set; }
       
    }
}
