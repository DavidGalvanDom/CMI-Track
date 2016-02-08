///Propósito: Modelo de Lista de Tipo de movimiento material
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
    public class ListaTipoMovtoMaterial
    {
        [Display(Name = "id", AutoGenerateField = false)]
        public int id { get; set; }

        [Display(Name = "Nombre Tipo Movimiento")]
        public string NombreTipoMovtoMaterial { get; set; }

        [Display(Name = "Tipo Movimiento")]
        public string TipoMovimiento { get; set; }

        [Display(Name = "Estatus")]
        public string Estatus { get; set; }
             
    }
}
