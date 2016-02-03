///Propósito: Modelo de Lista de Modulos 
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
    public class ListaModulo
    {
        [Display(Name = "id")]
        public int id { get; set; }

        [Display(Name = "Nombre")]
        public string nombreModulo { get; set; }

         [Display(Name = "Lectura")]
        public int lecturaPermisos { get; set; }

         [Display(Name = "Escritura")]
         public int escrituraPermisos { get; set; }

         [Display(Name = "Borrar")]
         public int borradoPermisos { get; set; }

         [Display(Name = "Cloar")]
         public int clonadoPermisos { get; set; }
    }
}
