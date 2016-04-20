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
    public class RegistroCalidad
    {
        [Display(Name = "Id Registro Calidad")]
        public int idRegistroCalidad { get; set; }

        [Required(ErrorMessage = "*")]
        [StringLength(1)]
        [Display(Name = "Clase")]
        public string claseRegistro { get; set; }

        [Required(ErrorMessage = "*")]
        [Display(Name = "Id Marca/SubMarca")]
        public int idMarca_Submarca { get; set; }

        [Required(ErrorMessage = "*")]
        [Display(Name = "Id Serie")]
        public int idSerie { get; set; }

        [StringLength(10)]
        [Display(Name = "Fecha Registro Calidad")]
        public string fechaRegistroCalidad { get; set; }

        [Required(ErrorMessage = "*")]
        [Display(Name = "Id Usuario")]
        public int idUsuario { get; set; }

        [Display(Name = "Id Ruta Fabricacion")]
        public int idRutaFabricacion { get; set; }

        [Display(Name = "Observaciones")]
        public string observacionesRegistroCalidad { get; set; }

        [Display(Name = "Estatus")]
        public int idEstatus { get; set; }

        [Display(Name = "Longitud")]
        public bool bLongitud { get; set; }

        [Display(Name = "Barrenacion")]
        public bool bBarrenacion { get; set; }

        [Display(Name = "Placa")]
        public bool bPlaca { get; set; }

        [Display(Name = "Soldadura")]
        public bool bSoldadura { get; set; }

        [Display(Name = "Pintura")]
        public bool bPintura { get; set; }

    }
}
