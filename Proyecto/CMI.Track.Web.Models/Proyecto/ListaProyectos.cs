///Propósito: Modelo de Lista de Proyectos
///Fecha creación: 15/Febrero/16
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
    public class ListaProyectos
    {
        [Display(Name = "id", AutoGenerateField = false)]
        public string id { get; set; }

        [Display(Name = "idProyecto", AutoGenerateField = false)]
        public int idProyecto { get; set; }

        [Display(Name = "Codigo Proyecto")]
        public string CodigoProyecto { get; set; }

        [Display(Name = "Nombre Proyecto")]
        public string NombreProyecto { get; set; }

        [Display(Name = "Fecha Inicio")]
        public string FechaInicio { get; set; }


        [Display(Name = "Fecha Fin")]
        public string FechaFin { get; set; }

        [Display(Name = "Revision")]
        public string Revision { get; set; }

        [Display(Name = "Estatus")]
        public string nombreEstatus { get; set; }

         [Display(Name = "estatusRevision")]
        public int estatusRevision { get; set; }

    }
}
