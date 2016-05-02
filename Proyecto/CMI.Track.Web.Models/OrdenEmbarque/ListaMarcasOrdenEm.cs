///Propósito: Modelo de Lista de Marcas para Orden embarque
///Fecha creación: 29/Abril/16
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
    public class ListaMarcasOrdenEm
    {
        [Display(Name = "id", AutoGenerateField = false)]
        public string id { get; set; }

        [Display(Name = "idMarca", AutoGenerateField = false)]
        public int idMarca { get; set; } 

        [Display(Name = "idSerie")]
        public string idSerie { get; set; }

        [Display(Name = "NombreMarca")]
        public string NombreMarca { get; set; }

        [Display(Name = "Piezas")]
        public double Piezas { get; set; }

        [Display(Name = "Peso")]
        public double Peso { get; set; }

        [Display(Name = "NombrePlano")]
        public string NombrePlano { get; set; }

    }
}
