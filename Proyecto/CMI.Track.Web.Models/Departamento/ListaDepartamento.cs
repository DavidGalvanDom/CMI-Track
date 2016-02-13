///Propósito: Modelo de Lista de Departamentos
///Fecha creación: 02/Febrero/16
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
    public class ListaDepartamento
    {
        [Display(Name = "id", AutoGenerateField = false)]
        public int id { get; set; }

        [Display(Name = "Nombre")]
        public string Nombre { get; set; }

        [Display(Name = "Estatus")]
        public int idEstatus { get; set; }

        [Display(Name = "Nombre Estatus")]
        public string nombreEstatus { get; set; }

         [Display(Name = "Fecha")]
        public string fechaCreacion { get; set; }
    }
}
