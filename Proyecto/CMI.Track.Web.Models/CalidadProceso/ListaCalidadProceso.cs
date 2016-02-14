///Propósito: Modelo de Lista de Rutas de Fabricacion
///Fecha creación: 12/Febrero/16
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
    public class ListaCalidadProceso
    {
        [Display(Name = "idProceso")]
        public int idProceso { get; set; }
        
        [Display(Name = "Proceso")]
        public string nombreProceso { get; set; }

        [Display(Name = "Secuencia")]
        public int secuencia { get; set; }

        [Display(Name = "idTipoCalidad")]
        public int idTipoCalidad { get; set; }

        [Display(Name = "TipoCalidad")]
        public string nombreTipoCalidad { get; set; }

        [Display(Name = "idEstatus")]
        public int idEstatus { get; set; }

        [Display(Name = "Estatus")]
        public string estatus { get; set; }

        public int id { get; set; }

    }
}
