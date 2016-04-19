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
    public class ListaKardex
    {
        [Display(Name = "id", AutoGenerateField = false)]
        public int id { get; set; }

        [Display(Name = "Nombre Grupo")]
        public string NombreGrupo { get; set; }

        [Display(Name = "id Material")]
        public int idMaterial { get; set; }

        [Display(Name = "Nombre Material")]
        public string NombreMaterial { get; set; }

        [Display(Name = "NombreAlmacen")]
        public string NombreAlmacen { get; set; }

        [Display(Name = "Nombre Tipo Movto")]
        public string NomTipoMOvto { get; set; }

        [Display(Name = "Tipo Movto")]
        public string TipoMovto { get; set; }

        [Display(Name = "Cantidad")]
        public double Cantidad { get; set; }

        [Display(Name = "Fecha")]
        public string Fecha { get; set; }


        [Display(Name = "Ancho")]
        public double Ancho { get; set; }

        [Display(Name = "Largo")]
        public double Largo { get; set; }
             
    }
}
