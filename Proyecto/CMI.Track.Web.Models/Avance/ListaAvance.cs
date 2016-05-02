///Propósito: Modelo de Lista del Detalle de una Orden de Produccion
///Fecha creación: 19/Febrero/16
///Creador: Juan Lopepe
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
    public class ListaAvance
    {
        [Display(Name = "Id")]
        public string id { get; set; }

        [Display(Name = "Codigo de Barra")]
        public string codigoBarra { get; set; }

        [Display(Name = "Tipo")]
        public string tipo { get; set; }

        [Display(Name = "Perfil")]
        public string perfil { get; set; }

        [Display(Name = "Clase")]
        public string clase { get; set; }

        [Display(Name = "Estatus Calidad")]
        public string estatusCalidad { get; set; }

        [Display(Name = "Proceso Actual")]
        public string procesoActual { get; set; }


        [Display(Name = "Link")]
        public string link { get; set; }
    }
}