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
        public int id { get; set; }  //idOrdenEmbarque

        [Required(ErrorMessage = "*")]
        [Display(Name = "IdProyecto")]
        public int idProyecto { get; set; }
        
        [Display(Name = "IdEtapa")]
        public int idEtapa { get; set; }

        [Required(ErrorMessage = "*")]
        [Display(Name = "EstatusOE")]
        public int EstatusOE { get; set; }

        [Display(Name = "Obervaciones")]
        [Required(ErrorMessage = "*")]
        public string Obervaciones { get; set; }

        [Required(ErrorMessage = "*")]
        public int usuarioCreacion { get; set; }

        public string fechaCreacion { get; set; }
        
        [Required(ErrorMessage = "*")]
        [Display(Name = "Lista de Marcas y Serie ")]
         public List<string> lstMS { get; set; }

        [Display(Name="Marcas Existentes")]
        public List<ListaMarcasOrdenEm> lstMarcasExis { get; set; }


    }
}
