///Propósito: Modelo de Lista de Reportes
///Fecha creación: 02/Marzo/16
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
    public class ListaReporte
    {
        /// <summary>
        /// Imformación para reporte: Requerimientos
        /// </summary>
        /// <returns></returns>
        [Display(Name = "idProyecto", AutoGenerateField = false)]
        public int id { get; set; }

        [Display(Name = "Nombre Proyecto")]
        public string NombreProyecto { get; set; }

        [Display(Name = "idEtapa", AutoGenerateField = false)]
        public int idEtapa { get; set; }

        [Display(Name = "Nombre Etapa")]
        public string NombreEtapa { get; set; }

        [Display(Name = "Folio Requerimiento")]
        public string FolioRequerimiento { get; set; }

        [Display(Name = "Nombre Departamento")]
        public string NombreDepto { get; set; }

        [Display(Name = "Nombre Usuario")]
        public string NomnreUsuario { get; set; }
             
    }
}
