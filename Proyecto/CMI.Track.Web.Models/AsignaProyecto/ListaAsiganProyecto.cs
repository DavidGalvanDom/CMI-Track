///Propósito: Modelo de Lista de Asignar materiales a proyecto
///Fecha creación: 30/Marzo/16
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
    public class ListaAsignaProyecto
    {
        [Display(Name = "id", AutoGenerateField = false)]
        public int id { get; set; }

        [Display(Name = "idProyecto")]
        public int idProyecto { get; set; }

        [Display(Name = "NombreProyecto")]
        public string NombreProyecto { get; set; }

        [Display(Name = "idEtapa")]
        public int idEtapa { get; set; }

        [Display(Name = "NombreEtapa")]
        public string NombreEtapa { get; set; }

        [Display(Name = "NombreUsuario")]
        public string NombreUsuario { get; set; }

        [Display(Name = "idAlmacen")]
        public int idAlmacen { get; set; }

        [Display(Name = "idRequisicion")]
        public int idRequisicion { get; set; }

        [Display(Name = "idMaterial")]
        public int idMaterial { get; set; }

        [Display(Name = "nombreMaterial")]
        public string nombreMat { get; set; }

        [Display(Name = "idOrdenProduccion")]
        public int idOrdenProduccion { get; set; }

        [Display(Name = "documentoMP")]
        public int documentoMP { get; set; }

        [Display(Name = "Cantidad")]
        public double Cantidad { get; set; }

        [Display(Name = "UM")]
        public string UM { get; set; }

        [Display(Name = "Existencias")]
        public double Existencia { get; set; }

        [Display(Name = "Calidad")]
        public string Calidad { get; set; }
        [Display(Name = "Ancho")]
        public double Ancho { get; set; }

        [Display(Name = "Largo")]
        public double Largo { get; set; }

        [Display(Name = "LongArea")]
        public double LongArea { get; set; }

        [Display(Name = "Peso")]
        public double Peso { get; set; }



        [Display(Name = "Total")]
        public double Total { get; set; }

        [Display(Name = "idOrigen")]
        public int idOrigen { get; set; }

        [Display(Name = "Nombre")]
        public string nombreMaterial { get; set; }

        [Display(Name = "solpie")]
        public double Solpie { get; set; }

        [Display(Name = "solkgs")]
        public double Solkgs { get; set; }

        [Display(Name = "reqpie")]
        public double Reqpie { get; set; }

        [Display(Name = "reqkgs")]
        public double Reqkgs { get; set; }

        [Display(Name = "matpie")]
        public double Matpie { get; set; }

        [Display(Name = "matkgs")]
        public double Matkgs { get; set; }


             
    }
}
