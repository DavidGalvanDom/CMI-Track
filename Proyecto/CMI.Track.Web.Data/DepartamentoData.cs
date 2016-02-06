///Propósito: Catalogo de Departamentos
///Fecha creación: 02/Febrero/2016
///Creador: David Galvan
///Fecha modifiacción: 
///Modificó:
///Dependencias de conexiones e interfaces: SQLServer

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using Microsoft.Practices.EnterpriseLibrary.Data;
using CMI.Track.Web.Models;


namespace CMI.Track.Web.Data
{
     public class DepartamentoData
    {
        /// <summary>
        /// Se carga el listado de departamentos
        /// </summary>
        /// <returns>Lista Usuarios</returns>
         public static List<Models.ListaDepartamento> CargaDepartamentos(int? idEstatus)
        {
            var listaDepartamentos = new List<Models.ListaDepartamento>();
            object[] paramArray = new object[2];
            try
            {
                paramArray[0] = null;
                paramArray[1] = idEstatus == -1 ? null : idEstatus;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarDepartamentos", paramArray))
                {
                    while (dataReader.Read())
                    {
                        listaDepartamentos.Add(new Models.ListaDepartamento()
                        {
                            id = Convert.ToInt32(dataReader["idDepartamento"]),
                            Nombre = Convert.ToString(dataReader["nombreDepartamento"]),
                            idEstatus = Convert.ToInt32(dataReader["idEstatus"]),
                            fechaCreacion = Convert.ToDateTime(dataReader["fechaCreacion"]).ToShortDateString()
                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }

            return listaDepartamentos;
        }

         /// <summary>
         /// Se carga la informacion general del Departamento
         /// </summary>
         /// <returns>Departamento</returns>
         public static Models.Departamento CargaDepartamento(int? idDepto)
         {
             object[] paramArray = new object[2];
             try
             {
                 paramArray[0] = idDepto;
                 paramArray[1] = null;

                 var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                 using (IDataReader dataReader = db.ExecuteReader("usp_CargarDepartamentos", paramArray))
                 {
                     while (dataReader.Read())
                     {
                         var objDepartamento = new Models.Departamento()
                         {
                             id = Convert.ToInt32(dataReader["idDepartamento"]),
                             Nombre = Convert.ToString(dataReader["nombreDepartamento"]),
                             idEstatus = Convert.ToInt32(dataReader["idEstatus"]),
                             fechaCreacion = Convert.ToDateTime(dataReader["fechaCreacion"]).ToShortDateString()
                         };

                         return objDepartamento;
                     }
                 }
             }
             catch (Exception exp)
             {
                 throw new ApplicationException(exp.Message, exp);
             }

             return null;

         }

         /// <summary>
         /// Se guarda la informacion de un nuevo Departamento
         /// </summary>
         /// <param name="pobjModelo">Datos nuevo Departamento</param>
         /// <returns>value</returns>
         public static string Guardar(Models.Departamento pobjModelo)
         {
             object[] paramArray = new object[3];
             try
             {
                 paramArray[0] = pobjModelo.idEstatus;                 
                 paramArray[1] = pobjModelo.Nombre.ToUpper();                
                 paramArray[2] = pobjModelo.usuarioCreacion;

                 var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                 var result = db.ExecuteScalar("usp_InsertarDepartamento", paramArray);

                 return (result.ToString());
             }
             catch (Exception exp)
             {
                 throw new ApplicationException(exp.Message, exp);
             }
         }

         /// <summary>
         /// Se actuliza la informacion del Departamento
         /// </summary>
         /// <param name="pobjModelo">Datos del usurio</param>
         /// <returns>value</returns>
         public static string Actualiza(Models.Departamento pobjModelo)
         {
             object[] paramArray = new object[3];
             try
             {
                 paramArray[0] = pobjModelo.id;
                 paramArray[1] = pobjModelo.idEstatus;                 
                 paramArray[2] = pobjModelo.Nombre.ToUpper();                

                 var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                 var result = db.ExecuteNonQuery("usp_ActualizarDepartamento", paramArray);

                 return (result.ToString());
             }
             catch (Exception exp)
             {
                 throw new ApplicationException(exp.Message, exp);
             }
         }

         /// <summary>
         /// Remueve de base de datos el Departamento 
         /// </summary>
         /// <param name="idDepartamento"></param>
         /// <returns></returns>
         public static string Borrar(string idDepartamento)
         {
             object[] paramArray = new object[1];
             try
             {
                 paramArray[0] = idDepartamento;

                 var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                 var result = db.ExecuteNonQuery("usp_RemueveDepartamento", paramArray);

                 return (result.ToString());
             }
             catch (Exception exp)
             {
                 throw new ApplicationException(exp.Message, exp);
             }
         }
    }
}
