///Propósito: Modelo de Planos Despiece
///Fecha creación: 24/Febrero/16
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
    public class PlanosDespiece
    {
        [Required(ErrorMessage = "*")]
        [Display(Name = "id")]
        public int id { get; set; }

        [Required(ErrorMessage = "*")]
        [Display(Name = "idPlanoMontaje")]
        public int idPlanoMontaje { get; set; }

        [Required(ErrorMessage = "*")]
        [Display(Name = "Tipo Construccion")]
        public int idTipoConstruccion { get; set; }

        [Required(ErrorMessage = "*")]
        [StringLength(20)]
        [Display(Name = "Nombre")]
        public string nombrePlanoDespiece { get; set; }

        [Required(ErrorMessage = "*")]
        [StringLength(20)]
        [Display(Name = "Codigo")]
        public string codigoPlanoDespiece { get; set; }
        
        [Required(ErrorMessage = "*")]
        [Display(Name = "Estatus")]
        public int idEstatus { get; set; }

        [Display(Name = "Creacion")]
        public string fechaCreacion { get; set; }
        
        [StringLength(100)]
        [Display(Name = "Archivo")]
        public string archivoPlanoDespiece { get; set; }

        [Required(ErrorMessage = "*")]
        [StringLength(250)]
        [Display(Name = "Informacion General")]
        public string infGeneralPlanoDespiece { get; set; }

        [Required(ErrorMessage = "*")]
        [Display(Name = "Usuario Creacion")]
        public int usuarioCreacion { get; set; }

        public string nombreArchivo { get; set; }
    }
}
