///Propósito: Modelo de Lista de Categoria
///Fecha creación: 02/Febrero/16
///Creador: David Jasso
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
    public class ListaCategoria
    {
        [Display(Name = "id", AutoGenerateField = false)]
        public int id { get; set; }

        [Display(Name = "Nombre Categoria")]
        public string NombreCategoria { get; set; }

        [Display(Name = "Estatus")]
        public string Estatus { get; set; }
             
    }
}
