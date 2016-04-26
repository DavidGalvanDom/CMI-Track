///Propósito: Modelo de Lista de Remisiones
///Fecha creación: 24/Marzo/16
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
    public class ListaRemisiones
    {
        [Display(Name = "id")]
        public int id { get; set; }

        [Display(Name = "idCliente")]
        public int idCliente { get; set; }

        [Display(Name = "Cliente")]
        public string NombreCliente { get; set; }

        [Display(Name = "Transporte")]
        public string Transporte { get; set; }

        [Display(Name = "Fecha Envio")]
        public string fechaEnvio { get; set; }

        [Display(Name = "Fecha Remision")]
        public string fechaRemision { get; set; }
    }
}
