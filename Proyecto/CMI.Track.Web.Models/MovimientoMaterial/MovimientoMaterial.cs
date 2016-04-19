﻿///Propósito: Modelo de Movimientos de Materiales
///Fecha creación: 02/Abril/16
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
    public class MovimientoMaterial
    {
        [Display(Name = "id")]
        public int id { get; set; }

        [Display(Name = "idMaterial")]
        public int idMaterialM { get; set; }


        [Display(Name = "Material")]
        public string Material { get; set; }

        [Display(Name = "Almacen")]
        public int idAlmacen { get; set; }

        [Display(Name = "Documento")]
        public int idDocumento { get; set; }

        [Display(Name = "Cantidad")]
        public double Cantidad { get; set; }

        [Display(Name = "Existencia")]
        public double Existencia { get; set; }

        [Display(Name = "TipoMovto")]
        public string TipoMovto { get; set; }

        public int usuarioCreacion { get; set; }
        
    }
}
