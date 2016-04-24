///Propósito: Modelo de Lista de Orden de Embarque
///Fecha creación: 19/Abril/16
///Creador: David Galvan
///Fecha modifiacción: 
///Modifico:
///Dependencias de conexiones e interfaces: 

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.ComponentModel.DataAnnotations;

namespace CMI.Track.Web.Models
{
    public class ListaOrdenEmbarqueBusqueda
    {
        [Display(Name = "id")]
        public int id { get; set; }

        [Display(Name = "idOrdenProduccion")]
        public int idOrdenProduccion { get; set; }

        [Display(Name = "Observacion")]
        public string observacionOrdenEmbarque { get; set; }

        [Display(Name = "Fecha")]
        public string fechaCreacion { get; set; }
    }
}
