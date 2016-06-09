///Propósito: Modelo de Lista de Kardex
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
    public class ListaExistencias
    {
        [Display(Name = "id", AutoGenerateField = false)]
        public int id { get; set; }

        [Display(Name = "Nombre Grupo")]
        public string NombreGrupo { get; set; }

        [Display(Name = "id Material")]
        public int idMaterial { get; set; }

        [Display(Name = "Nombre Material")]
        public string NombreMaterial { get; set; }

        [Display(Name = "Ancho")]
        public double Ancho { get; set; }

        [Display(Name = "UMAncho")]
        public string UMAncho { get; set; }

        [Display(Name = "Largo")]
        public double Largo { get; set; }

        [Display(Name = "UMLargo")]
        public string UMLargo { get; set; }

        [Display(Name = "Calidad")]
        public string Calidad { get; set; }

        [Display(Name = "Inventario")]
        public double Inventario { get; set; }
    }
}
