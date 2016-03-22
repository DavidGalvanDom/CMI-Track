///Propósito: Modelo de SubMarca
///Fecha creación: 07/Marzo/16
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
    public class SubMarcas
    {
        [Required(ErrorMessage = "*")]
        [Display(Name = "id")]
        public int id { get; set; }

        [Required(ErrorMessage = "*")]
        [StringLength(20)]
        [Display(Name = "Codigo")]
        public string codigoSubMarca { get; set; }

        [Required(ErrorMessage = "*")]
        [StringLength(50)]
        [Display(Name = "Perfil")]
        public string perfilSubMarca { get; set; }

        [Required(ErrorMessage = "*")]
        [Display(Name = "Estatus")]
        public int idEstatus { get; set; }
        
        [Required(ErrorMessage = "*")]
        [Display(Name = "Piezas")]
        public int piezasSubMarcas { get; set; }

        [Required(ErrorMessage = "*")]
        [Display(Name = "Corte")]
        public double corteSubMarcas { get; set; }

        [Required(ErrorMessage = "*")]
        [Display(Name = "Longitud")]
        public double longitudSubMarcas { get; set; }

        [Required(ErrorMessage = "*")]
        [Display(Name = "Ancho")]
        public double anchoSubMarcas { get; set; }

        [Required(ErrorMessage = "*")]
        [Display(Name = "Grado")]
        public string gradoSubMarcas { get; set; }

        [Required(ErrorMessage = "*")]
        [Display(Name = "KG/M")]
        public double kgmSubMarcas { get; set; }

        [Required(ErrorMessage = "*")]
        [Display(Name = "Total L/A")]
        public double totalLASubMarcas { get; set; }

        [Required(ErrorMessage = "*")]
        [Display(Name = "Total")]
        public double totalSubMarcas { get; set; }

        [Required(ErrorMessage = "*")]
        [Display(Name = "Peso")]
        public double pesoSubMarcas { get; set; }

        [Required(ErrorMessage = "*")]
        [Display(Name = "Altura")]
        public double alturaSubMarcas { get; set; }

        [Required(ErrorMessage = "*")]
        [Display(Name = "idMarca")]
        public int idMarca { get; set; }
        
        [Display(Name = "Creacion")]
        public string fechaCreacion { get; set; }

        [Required(ErrorMessage = "*")]
        [Display(Name = "Usuario Creacion")]
        public int usuarioCreacion { get; set; }

        [Required(ErrorMessage = "*")]
        [Display(Name = "Orden produccion")]
        public int idOrdenProduccion { get; set; }

        [Required(ErrorMessage = "*")]
        [Display(Name = "Clase")]
        public string claseSubMarca { get; set; }
    }
}
