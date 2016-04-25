///Propósito: Acceso a base de datos Remisiones
///Fecha creación: 24/Abril/2016
///Creador: David Galvan
///Fecha modifiacción: 
///Modificó:
///Dependencias de conexiones e interfaces: SQLServer

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data.Common;
using System.Data;
using Microsoft.Practices.EnterpriseLibrary.Data;
using CMI.Track.Web.Models;

namespace CMI.Track.Web.Data
{
    public  class RemisionData
    {
        /// <summary>
        /// Se guarda la informacion de una nueva Remision
        /// </summary>
        /// <param name="pobjModelo">Datos nuevo Proyecto</param>
        /// <returns>value</returns>
        public static string Guardar(Models.Remision pobjModelo)
        {
            object[] paramArray = new object[6];
            object[] paramArrDetalle= new object[3];
            object result;
            try
            {
                paramArray[0] = pobjModelo.fechaEnvio;
                paramArray[1] = pobjModelo.idCliente;
                paramArray[2] = pobjModelo.transporte.ToUpper();
                paramArray[3] = pobjModelo.placas.ToUpper();
                paramArray[4] = pobjModelo.conductor.ToUpper();
                paramArray[5] = pobjModelo.usuarioCreacion;
                
                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (DbConnection conn = db.CreateConnection())
                {
                    conn.Open();
                    DbTransaction trans = conn.BeginTransaction();

                    try 
                    {
                        var cmdRemision = db.GetStoredProcCommand("usp_InsertarRemision",paramArray);
                        result = db.ExecuteScalar(cmdRemision, trans);

                        foreach (var valor in pobjModelo.lstOrdenEmbarque)
                        {
                            paramArrDetalle[0] = result.ToString();
                            paramArrDetalle[1] = valor;
                            paramArrDetalle[2] = pobjModelo.usuarioCreacion;

                            var cmdDetalle = db.GetStoredProcCommand("usp_InsertarRemisionDetalle", paramArrDetalle);
                            db.ExecuteScalar(cmdDetalle, trans);
                        }

                        trans.Commit();
                    }
                    catch(Exception exp)
                    {
                        // Roll back the transaction. 
                        trans.Rollback();
                        conn.Close();
                        throw new ApplicationException(exp.Message, exp);
                    }
                    conn.Close();

                    return (result.ToString());
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }
    }
}
