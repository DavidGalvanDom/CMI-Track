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
    public class ListaReqManualCompra
    {
        [Display(Name = "id", AutoGenerateField = false)]
        public int id { get; set; }

        [Display(Name = "IdRequerimiento")]
        public string idRequerimiento { get; set; }

        [Display(Name = "IdRequisicion")]
        public int idRequisicion { get; set; }

        [Display(Name = "Origen")]
        public int Origen { get; set; }

        [Display(Name = "Alamcen")]
        public int Almacen { get; set; }

        [Display(Name = "Causa")]
        public string Causa { get; set; }

        [Display(Name = "IdMaterial")]
        public int idMaterialSelect { get; set; }

        [Display(Name = "Unidad")]
        public string Unidad { get; set; }

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


        [Display(Name = "Estatus")]
        public string Estatus { get; set; }

        [Display(Name = "NombreOrigen")]
        public string NombreOrigen { get; set; }

        [Display(Name = "Serie")]
        public string Serie { get; set; }


        [Display(Name = "Factura")]
        public string Factura { get; set; }


        [Display(Name = "Proveedor")]
        public string Proveedor { get; set; }


        [Display(Name = "Fecha Factura")]
        public string FechaFac { get; set; }

        [Display(Name = "idProyecto", AutoGenerateField = false)]
        public int idProyecto { get; set; }

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
        public int usuarioCreacion { get; set; }
    }
}
