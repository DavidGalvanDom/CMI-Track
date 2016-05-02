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
   public class ActividadProduccion
   {
       [Display(Name = "Actividad")]
       public int id { get; set; }

       [Required(ErrorMessage = "*")]
       [StringLength(1)]
       [Display(Name = "Tipo")]
       public string tipo { get; set; }

       [Required(ErrorMessage = "*")]
       [StringLength(1)]
       [Display(Name = "Clase")]
       public string clase { get; set; }
       
       [Display(Name = "SubMarca")]
       public int idSubmarca { get; set; }

       [Display(Name = "Marca")]
       public int idMarca { get; set; }

       [Display(Name = "Serie")]
       public string idSerie { get; set; }

       [Required(ErrorMessage = "*")]
       [Display(Name = "Piezas")]
       public int piezas { get; set; }

       [Display(Name = "Fecha")]
       public string fecha { get; set; }

       [Display(Name = "Tipo Proceso")]
       public int idTipoProceso { get; set; }

       [Display(Name = "Proceso")]
       public int idProceso { get; set; }

       [Display(Name = "Usuario Fabrico")]
       public int idUsuarioFabrico { get; set; }

       [Display(Name = "Estatus Calidad")]
       public int idEstatus_Calidad { get; set; }

       [Display(Name = "Observaciones")]
       public string observaciones { get; set; }

       [Display(Name = "Longitud")]
       public bool longitud { get; set; }
       
       [Display(Name = "Barrenacion")]
       public bool barrenacion { get; set; }

       [Display(Name = "Placa")]
       public bool placa { get; set; }

       [Display(Name = "Soldadura")]
       public bool soldadura { get; set; }

       [Display(Name = "pintura")]
       public bool pintura { get; set; }

       [Required(ErrorMessage = "*")]
       [Display(Name = "Usuario")]
       public int usuarioCreacion { get; set; }
    }
}
