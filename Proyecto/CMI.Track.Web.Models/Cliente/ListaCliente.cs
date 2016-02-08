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
    public class ListaCliente
    {
        [Display(Name = "id", AutoGenerateField = false)]
        public int id { get; set; }

        [Display(Name = "Nombre Cliente")]
        public string NombreCliente { get; set; }

        [Display(Name = "Dieccion Entrega")]
        public string DireccionEntrega { get; set; }

        [Display(Name = "Colonia")]
        public string ColoniaCliente { get; set; }

        [Display(Name = "CP")]
        public int CpCliente { get; set; }

        [Display(Name = "Ciudad")]
        public string CiudadCliente { get; set; }

        [Display(Name = "Estado")]
        public string EstadoCliente { get; set; }

        [Display(Name = "Pais")]
        public string PaisCliente { get; set; }

        [Display(Name = "Contacto")]
        public string ContactoCliente { get; set; }

        [Display(Name = "Estatus")]
        public string Estatus { get; set; }
             
    }
}
