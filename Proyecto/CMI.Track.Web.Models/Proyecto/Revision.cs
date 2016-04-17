///Propósito: Modelo de Reivision para Proyecto
///Fecha creación: 12/Abril/16
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
    public class Revision
    {
        [Display(Name = "Codigo")]
        public string Codigo { get; set; }

        [Display(Name = "Fecha")]
        public string Fecha { get; set; }

        [Display(Name = "Estatus")]
        public int Estatus { get; set; }
    }
}
