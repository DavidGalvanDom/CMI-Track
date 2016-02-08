///Propósito: Modelo de Clientes
///Fecha creación: 05/Febrero/16
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
    public class Cliente
    {
        [Display(Name = "id")]
        public int id { get; set; }

        [Required(ErrorMessage = "*")]
        [StringLength(100)]
        [Display(Name = "Nombre Cliente")]
        public string NombreCliente { get; set; }

        [Required(ErrorMessage = "*")]
        [StringLength(100)]
        [Display(Name = "Dieccion Entrega")]
        public string DireccionEntrega { get; set; }

        [Required(ErrorMessage = "*")]
        [StringLength(100)]
        [Display(Name = "Colonia")]
        public string ColoniaCliente { get; set; }

        [Display(Name = "CP")]
        [Required(ErrorMessage = "*")]
        public int CpCliente { get; set; }

        [Required(ErrorMessage = "*")]
        [StringLength(100)]
        [Display(Name = "Ciudad")]
        public string CiudadCliente { get; set; }

        [Required(ErrorMessage = "*")]
        [StringLength(100)]
        [Display(Name = "Estado")]
        public string EstadoCliente { get; set; }

        [Required(ErrorMessage = "*")]
        [StringLength(100)]
        [Display(Name = "Pais")]
        public string PaisCliente { get; set; }

        [Required(ErrorMessage = "*")]
        [StringLength(100)]
        [Display(Name = "Contacto")]
        public string ContactoCliente { get; set; }

        [Display(Name = "Estatus")]
        [Required(ErrorMessage = "*")]
        public string Estatus { get; set; }

        public int usuarioCreacion { get; set; }
        
    }
}
