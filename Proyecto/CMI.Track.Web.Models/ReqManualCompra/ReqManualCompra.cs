///Propósito: Modelo de Planos Montaje
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
    public class ReqManualCompra
    {
        [Display(Name = "id")]
        public int id { get; set; }

        [Required(ErrorMessage = "*")]
        [StringLength(10)]
        [Display(Name = "IdRequerimiento")]
        public string idRequerimiento { get; set; }


        [Display(Name = "IdRequisicion")]
        public int idRequisicion { get; set; }

        [Required(ErrorMessage = "*")]
        [Display(Name = "Origen")]
        public int Origen { get; set; }

        [Required(ErrorMessage = "*")]
        [Display(Name = "Alamcen")]
        public int Almacen { get; set; }

        [Display(Name = "Causa")]
        public string Causa { get; set; }

        [Required(ErrorMessage = "*")]
        [Display(Name = "IdMaterial")]
        public int idMaterialSelect { get; set; }

        [Required(ErrorMessage = "*")]
        [Display(Name = "Unidad")]
        public int Unidad { get; set; }

        [Display(Name = "idUnidad")]
        public int idUnidad { get; set; }

        [Required(ErrorMessage = "*")]
        [Display(Name = "Cantidad")]
        public int Cantidad { get; set; }

        [Display(Name = "Nombre Material")]
        public string nombreMaterial { get; set; }

        [Display(Name = "Calidad")]
        public string Calidad { get; set; }


        [Display(Name = "Ancho")]
        public int Ancho { get; set; }


        [Display(Name = "Largo")]
        public int Largo { get; set; }

        [Display(Name = "Peso")]
        public int Peso { get; set; }

        public int usuarioCreacion { get; set; }
       
    }
}
