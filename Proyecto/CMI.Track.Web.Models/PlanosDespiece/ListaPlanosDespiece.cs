///Propósito: Modelo de Lista de Planos Despiece
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
   public class ListaPlanosDespiece
    {

       [Display(Name = "id")]
       public int id { get; set; }

       [Display(Name = "Nombre")]
       public string nombrePlanoDespiece { get; set; }
              
       [Display(Name = "Codigo")]
       public string codigoPlanoDespiece { get; set; }

       [Display(Name = "Tipo Contruccion")]
       public string nombreTipoContruccion { get; set; }

       [Display(Name = "Estatus")]
       public string nombreEstatus { get; set; }

       [Display(Name = "Archivo")]
       public string archivoPlanoDespiece { get; set; }

       public string nombreArchivo { get; set; }

       public int idTipoConstruccion { get; set; }

       public string Serialize()
       {
           return String.Format("{0}|{1}|{2}|{3}", id, codigoPlanoDespiece, idTipoConstruccion, nombreTipoContruccion);
       }

    }
}
