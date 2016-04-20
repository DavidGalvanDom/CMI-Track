///Propósito: Modelo de Avance
///Fecha creación: 27/Marzo/16
///Creador: Juan Lopepe
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
   public class Avance
    {
        [Display(Name = "Id Historico Avance")]
        public int idHistoricoAvance { get; set; }

        [Required(ErrorMessage = "*")]
        [StringLength(1)]
        [Display(Name = "Clase")]
        public string claseAvance { get; set; }

        [Required(ErrorMessage = "*")]
        [Display(Name = "Id Marca/SubMarca")]
        public int idMarca_Submarca { get; set; }

        [Required(ErrorMessage = "*")]
        [Display(Name = "Id Serie")]
        public string idSerie { get; set; }

        [StringLength(10)]
        [Display(Name = "Fecha Avance")]
        public string fechaAvance { get; set; }

        [Required(ErrorMessage = "*")]
        [Display(Name = "Id Usuario")]
        public int idUsuario { get; set; }

        [Display(Name = "Id Ruta Fabricacion Inicio")]
        public int idRutaFabricacionInicio { get; set; }

        [Display(Name = "Id Ruta Fabricacion Fin")]
        public int idRutaFabricacionFin { get; set; }
    }
}
