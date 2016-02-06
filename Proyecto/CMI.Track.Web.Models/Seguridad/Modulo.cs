///Propósito: Modelo de Modulos 
///Fecha creación: 01/Febreo/2016
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
    public class Modulo
    {
        [Display(Name = "id")]
        public int id { get; set; }
        
        [Display(Name = "Nombre")]
        public string nombreModulo { get; set; }
        
    }
}
