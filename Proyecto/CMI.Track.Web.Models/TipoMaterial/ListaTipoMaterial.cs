///Propósito: Modelo de Lista de Tipos de Material
///Fecha creación: 01/Febrero/16
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
    public class ListaTipoMaterial
    {
        [Display(Name = "id", AutoGenerateField = false)]
        public int id { get; set; }

        [Display(Name = "Tipo Material")]
        public string nombreTipoMaterial { get; set; }

        [Display(Name = "idEstatus")]
        public int idEstatus { get; set; }

        [Display(Name = "Estatus")]
        public string estatus { get; set; }
             
    }
}
