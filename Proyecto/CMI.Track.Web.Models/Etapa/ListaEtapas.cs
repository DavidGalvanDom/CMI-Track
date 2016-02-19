///Propósito: Modelo de Lista de Etapas
///Fecha creación: 18/Febrero/16
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
    public class ListaEtapas
    {
        [Display(Name = "id")]
        public int id { get; set; }

        [Display(Name = "Etapa")]
        public string nombreEtapa { get; set; }
       
        [Display(Name = "Fecha Inicio")]
        public string fechaInicio { get; set; }
       
        [Display(Name = "Fecha Fin")]
        public string fechaFin { get; set; }

        [Display(Name = "Estatus")]
        public string nombreEstatus { get; set; }

    }
}
