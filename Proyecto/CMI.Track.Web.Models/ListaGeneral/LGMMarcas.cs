using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CMI.Track.Web.Models
{
    public class LGMMarcas
    {
        public int id { get; set; }

        public int idPlanoDespiece { get; set; }

        public string codigoMarca { get; set; }

        public int piezas { get; set; }

        public int usuarioCreacion { get; set; }

        public List<LGMSubMarcas> listaSubMarcas { get; set; }
    }
}
