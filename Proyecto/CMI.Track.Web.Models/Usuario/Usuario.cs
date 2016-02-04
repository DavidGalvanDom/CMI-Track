///Propósito: Modelo de Usuario 
///Fecha creación: 28/Enero/16
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
    public class Usuario
    {
        [Display(Name = "id")]
        public int id { get; set; }

        [Required(ErrorMessage = "*")]
        [StringLength(20)]
        [Display(Name = "Usuario")]
        public string NombreUsuario { get; set; }

        [Required(ErrorMessage = "*")]
        [StringLength(50)]
        [Display(Name = "Nombre")]
        public string Nombre { get; set; }

        [Required(ErrorMessage = "*")]
        [StringLength(50)]
        [Display(Name = "Paterno")]
        public string ApePaterno { get; set; }

        [Required(ErrorMessage = "*")]
        [StringLength(50)]
        [Display(Name = "Materno")]
        public string ApeMaterno { get; set; }

        [Required(ErrorMessage = "*")]
        [RegularExpression(@"^([\w-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([\w-]+\.)+))([a-zA-Z]{2,4}|[0-9]{1,3})(\]?)$", ErrorMessage="*")]
        [Display(Name = "Correo")]
        public string Correo { get; set; }

        [Display(Name = "Contraseña")]
        [Required(ErrorMessage = "*")]
        public string Contrasena { get; set; }

        [Display(Name = "Estatus")]
        [Required(ErrorMessage = "*")]
        public int idEstatus { get; set; }

        [Display(Name = "Puesto")]
        [Required(ErrorMessage = "*")]
        public string puestoUsuario { get; set; }

        [Display(Name = "Area")]
        [Required(ErrorMessage = "*")]
        public string areaUsuario { get; set; }

        [Display(Name = "Departamento")]
        [Required(ErrorMessage = "*")]
        public int idDepartamento { get; set; }

        [Display(Name = "Autoriza")]
        [Required(ErrorMessage = "*")]
        public bool autorizaRequisiciones { get; set; }

        [Display(Name = "Proceso Origen")]
        public int? idProcesoOrigen { get; set; }

        [Display(Name = "Proceso Destino")]
        public int? idProcesoDestino { get; set; }

         [Display(Name = "Fecha Creacion")]
        public string fechaCreacion {get; set;}


         public int usuarioCreacion { get; set; }
    }
}
