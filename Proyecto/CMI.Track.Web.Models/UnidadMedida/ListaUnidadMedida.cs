///Propósito: Modelo de Lista de Unidades de Medida
///Fecha creación: 01/Febrer/16
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
    public class ListaUnidadMedida
    {
        [Display(Name = "id", AutoGenerateField = false)]
        public int id { get; set; }

        [Display(Name = "Nombre Corto")]
        public string nombreCortoUnidadMedida { get; set; }

        [Display(Name = "Nombre")]
        public string nombreUnidadMedida { get; set; }

        [Display(Name = "idEstatus")]
        public int idEstatus { get; set; }

        [Display(Name = "Estatus")]
        public string estatus { get; set; }

    }
}
