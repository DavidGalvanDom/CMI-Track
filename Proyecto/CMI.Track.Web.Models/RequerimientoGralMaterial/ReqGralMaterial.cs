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
    public class ReqGralMaterial
    {
        [Display(Name = "id")]
        public int id { get; set; }

        [Required(ErrorMessage = "*")]
        [StringLength(10)]
        [Display(Name = "Fecha Solicitud")]
        public string fechaSolicitud { get; set; }

        [Required(ErrorMessage = "*")]
        [Display(Name = "Proyecto")]
        public int idProyecto { get; set; }

        [Required(ErrorMessage = "*")]
        [Display(Name = "Nombre")]
        public string Nombre { get; set; }

        [Required(ErrorMessage = "*")]
        [Display(Name = "Codigo")]
        public string codigoProyecto { get; set; }

        [Required(ErrorMessage = "*")]
        [Display(Name = "Revision")]
        public string revisionProyecto { get; set; }

        [Required(ErrorMessage = "*")]
        [Display(Name = "Origen")]
        public string origenProyecto { get; set; }

        [Required(ErrorMessage = "*")]
        [Display(Name = "Departamento")]
        public string departamentoP { get; set; }

        [Required(ErrorMessage = "*")]
        [Display(Name = "Solicitado por")]
        public string solicitado { get; set; }
      
        [Display(Name = "Etapa")]
        public int etapaProyecto { get; set; }
                
        [Display(Name = "Nombre Etapa")]
        public string nombreEtapa { get; set; }

        [Display(Name = "Clave Etapa")]
        public string claveEtapa { get; set; }

        [Display(Name = "Folio")]
        public string folioRequerimiento { get; set; }

        public List<DetalleReqGenMat> lstDetalle { get; set; }
        
    }
}
