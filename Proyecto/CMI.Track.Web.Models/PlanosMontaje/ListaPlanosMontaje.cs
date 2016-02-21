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
    public class ListaPlanosMontaje
    {
        [Display(Name = "id")]
        public int id { get; set; }

        [Display(Name = "Nombre")]
        public string nombrePlanoMontaje { get; set; }

        [Display(Name = "Fecha Inicio")]
        public string fechaInicio { get; set; }

        [Display(Name = "Fecha Fin")]
        public string fechaFin { get; set; }

        [Display(Name = "Estatus")]
        public string nombreEstatus { get; set; }

         [Display(Name = "Archivo")]
        public string archivoPlanoMontaje { get; set; }
    }
}
