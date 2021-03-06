﻿///Propósito: Modelo de Proyecto
///Fecha creación: 09/Febrero/16
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
   public class Proyecto
    {
        [Display(Name = "id")]
        public int id { get; set; }

        [Required(ErrorMessage = "*")]
        [StringLength(3)]
        [Display(Name = "Revision")]
        public string revisionProyecto { get; set; }

        [Display(Name = "Estatus Revision")]
        public int idEstatusRevision { get; set; }

        [Required(ErrorMessage = "*")]
        [StringLength(20)]
        [Display(Name = "Proyecto")]
        public string nombreProyecto { get; set; }

        [Required(ErrorMessage = "*")]
        [StringLength(20)]
        [Display(Name = "Codigo")]
        public string codigoProyecto { get; set; }

        [Required(ErrorMessage = "*")]
        [Display(Name = "Categoria")]
        public int idCategoria { get; set; }

        [Required(ErrorMessage = "*")]
        [Display(Name = "Cliente")]
        public int idCliente { get; set; }

        [Required(ErrorMessage = "*")]
        [Display(Name = "Estatus")]
        public int estatusProyecto { get; set; }
        
        [Display(Name = "Archivo plano")]
        public string archivoPlanoProyecto { get; set; }
               
        public string nombreArchivo { get; set; }

        [Required(ErrorMessage = "*")]
        [StringLength(250)]
        [Display(Name = "Informacion General")]
        public string infoGeneral { get; set; }

        [Required(ErrorMessage = "*")]
        [StringLength(10)]
        [Display(Name = "Fecha Inicio")]
        public string fechaInicio { get; set; }

        [Required(ErrorMessage = "*")]
        [StringLength(10)]
        [Display(Name = "Fecha Fin")]
        public string fechaFin { get; set; }

        [Required(ErrorMessage = "*")]
        [StringLength(10)]
        [Display(Name = "Fecha Revision")]
        public string fechaRevision { get; set; }

        [Display(Name = "Creacion")]
        public string fechaCreacion { get; set; }

        public int usuarioCreacion { get; set; }
               
        public string contactoCliente { get; set; }

        public string direccionCliente { get; set; }

        public string nombreCliente { get; set; }

    }
}
