///Propósito: Modelo de Lista de Marcas
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
    public class ListaMarcas
    {
        [Display(Name = "id")]
        public int id { get; set; }

        [Display(Name = "Nombre")]
        public string nombreMarca { get; set; }

        [Display(Name = "Codigo")]
        public string codigoMarca { get; set; }
               
        [Display(Name = "Piezas")]
        public int Piezas { get; set; }

        [Display(Name = "Estatus")]
        public string nombreEstatus { get; set; }
    }
}
