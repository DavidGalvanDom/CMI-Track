///Propósito: Modelo de Ordenes de embarque
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
    public class OrdenEmbarque
    {
        [Display(Name = "id")]
        public int id { get; set; }

        [Required(ErrorMessage = "*")]

        [Display(Name = "IdProyecto")]
        public int idProyecto { get; set; }


        [Display(Name = "IdEtapa")]
        public int idEtapa { get; set; }

        [Required(ErrorMessage = "*")]
        [Display(Name = "OrdenP")]
        public int OrdenP { get; set; }

        [Required(ErrorMessage = "*")]
        [Display(Name = "EstatusOE")]
        public int EstatusOE { get; set; }

        [Display(Name = "Obervaciones")]
        public string Obervaciones { get; set; }

        [Display(Name = "Marca")]
        public int idMarca { get; set; }

        [Display(Name = "Revision")]
        public string Revision { get; set; }


        [Display(Name = "idOrdenEmb")]
        public int idOrdenEmb { get; set; }
        public int usuarioCreacion { get; set; }
       
    }
}
