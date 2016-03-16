///Propósito: Modelo de Etapa
///Fecha creación: 18/Febrero/16
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
    public class Etapa
    {
        [Display(Name = "id")]
        public int id { get; set; }        

        [Required(ErrorMessage = "*")]
        [StringLength(20)]
        [Display(Name = "Nombre")]
        public string nombreEtapa { get; set; }

        [Required(ErrorMessage = "*")]
        [StringLength(10)]
        [Display(Name = "Clave")]
        public string claveEtapa { get; set; }

        [Required(ErrorMessage = "*")]
        [StringLength(250)]
        [Display(Name = "Informacion General")]
        public string infoGeneral { get; set; }

        [Required(ErrorMessage = "*")]
        [StringLength(10)]
        [Display(Name = "Fecha Inicio")]
        public string fechaInicio { get; set; }

        [Required(ErrorMessage = "*")]
        [StringLength(10)]
        [Display(Name = "Fecha Fin")]
        public string fechaFin { get; set; }

        [Required(ErrorMessage = "*")]
        [Display(Name = "Proyecto")]
        public int idProyecto { get; set; }

        [Required(ErrorMessage = "*")]
        [Display(Name = "Revision")]
        public string revisionProyecto { get; set; }

        [Required(ErrorMessage = "*")]
        [Display(Name = "Estatus")]
        public int estatusEtapa { get; set; }

        [Display(Name = "Creacion")]
        public string fechaCreacion { get; set; }

        public int usuarioCreacion { get; set; }

    }
}
