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
    public class ListaReqGralMaterial
    {
        [Display(Name = "id", AutoGenerateField = false)]
        public int id { get; set; }

        [Display(Name = "Fecha Solicitud")]
        public string fechaSolicitud { get; set; }

        [Display(Name = "Proyecto")]
        public int idProyecto { get; set; }

        [Display(Name = "Nombre")]
        public string Nombre { get; set; }

        [Display(Name = "Codigo")]
        public string codigoProyecto { get; set; }

        [Display(Name = "Revision")]
        public string revisionProyecto { get; set; }

        [Display(Name = "Origen")]
        public string origenProyecto { get; set; }

        [Display(Name = "Departamento")]
        public string departamentoP { get; set; }

        [Display(Name = "Solicitado por")]
        public string solicitado { get; set; }

        [Display(Name = "Etapa")]
        public int etapaProyecto { get; set; }

        [Display(Name = "Fecha inicial de etapa")]
        public string fechaIniEtapa { get; set; }

        [Display(Name = "Fecha final de etapa")]
        public string fechaFinEtapa { get; set; }

        [Display(Name = "Estatus")]
        public string nombreEstatus { get; set; }

        [Display(Name = "perfilSubMarca")]
        public string perfilSubMarca { get; set; }

        [Display(Name = "piezasSubMarca")]
        public int piezasSubMarca { get; set; }

        [Display(Name = "corteSubMarca")]
        public int corteSubMarca { get; set; }

        [Display(Name = "longitudSubMarca")]
        public int longitudSubMarca { get; set; }

        [Display(Name = "anchoSubMarca")]
        public int anchoSubMarca { get; set; }

        [Display(Name = "gradoSubMarca")]
        public string gradoSubMarca { get; set; }

        [Display(Name = "kgmSubMarca")]
        public int kgmSubMarca { get; set; }

        [Display(Name = "totalLASubMarca")]
        public int totalLASubMarca { get; set; }

        [Display(Name = "pesoSubMarca")]
        public int pesoSubMarca { get; set; }

        [Display(Name = "folioRequerimiento")]
        public string folioRequerimiento { get; set; }
    }
}
