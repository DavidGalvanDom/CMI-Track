///Propósito: Modelo de Lista de Tipo de proceso
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
    public class ListaTipoProceso
    {
        [Display(Name = "id", AutoGenerateField = false)]
        public int id { get; set; }

        [Display(Name = "Nombre Tipo Proceso")]
        public string NombreTipoProceso { get; set; }

        [Display(Name = "Estatus")]
        public string Estatus { get; set; }
             
    }
}
