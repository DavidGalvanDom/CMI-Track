///Propósito: Modelo de Lista de procesos
///Fecha creación: 10/Febrero/16
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
    public class ListaProceso
    {
        [Display(Name = "id", AutoGenerateField = false)]
        public int id { get; set; }

        [Display(Name = "Proceso")]
        public string nombreProceso { get; set; }

        [Display(Name = "idEstatus")]
        public int idEstatus { get; set; }

        [Display(Name = "Estatus")]
        public string estatus { get; set; }

        [Display(Name = "idTipoProceso")]
        public int idTipoProceso { get; set; }

        [Display(Name = "TipoProceso")]
        public string nombreTipoProceso { get; set; }

        [Display(Name = "claseAvance")]
        public string claseAvance { get; set; }
    }
}
