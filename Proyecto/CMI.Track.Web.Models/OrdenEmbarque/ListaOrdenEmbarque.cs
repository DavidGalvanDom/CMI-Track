///Propósito: Modelo de Lista de Planos Montaje
///Fecha creación: 20/Febrero/16
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
    public class ListaOrdenEmbarque
    {
        [Display(Name = "id", AutoGenerateField = false)]
        public int id { get; set; }


        [Display(Name = "IdProyecto")]
        public int idProyecto { get; set; }


        [Display(Name = "NombreProyecto")]
        public string NombreProyecto { get; set; }


        [Display(Name = "Codigo")]
        public string Codigo { get; set; }


        [Display(Name = "Revision")]
        public string Revision { get; set; }

        [Display(Name = "NombreMarca")]
        public string NombreMarca { get; set; }

        [Display(Name = "NombreEtapa")]
        public string NombreEtapa { get; set; }


        [Display(Name = "IdEtapa")]
        public int idEtapa { get; set; }

        [Display(Name = "OrdenP")]
        public int OrdenP { get; set; }

        [Display(Name = "EstatusOE")]
        public int EstatusOE { get; set; }

        [Display(Name = "Obervaciones")]
        public string Obervaciones { get; set; }
        
        [Display(Name = "Piezas")]
        public double Piezas { get; set; }

        [Display(Name = "Peso")]
        public double Peso { get; set; }

        [Display(Name = "Total")]
        public double Total { get; set; }

        [Display(Name = "NombrePlano")]
        public string NombrePlano { get; set; }

        [Display(Name = "idOrdenEmb")]
        public int idOrdenEmb { get; set; }

        public int usuarioCreacion { get; set; }
        
        [Display(Name = "idSerie")]
        public string idSerie { get; set; }

        [Display(Name = "idMarca")]
        public int idMarca { get; set; }
    }
}
