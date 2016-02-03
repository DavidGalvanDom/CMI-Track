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
    }
}
