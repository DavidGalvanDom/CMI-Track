///Propósito: Modelo de Detalle par Remisiones
///Fecha creación: 24/Marzo/16
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
    public class DetalleRemision
    {
        public string id { get; set; }

        [Display(Name = "idRemision")]
        public int idRemision { get; set; }

        public int idOrdenEmbarque { get; set; }

        public string Proyecto { get; set; }

        public string Etapa { get; set; }

        public string OrdenEmbarque { get; set; }

        public string Marca { get; set; }

        public int idMarca { get; set; }

        public int Piezas { get; set; }

        public int PiezasLeidas { get; set; }

        public int Saldo { get; set; }

        public double PesoCU { get; set; }

        public double PesoTotal { get; set; }

        public string NombrePlano { get; set; }
    }
}
