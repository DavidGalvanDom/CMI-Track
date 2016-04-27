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
        /// Se cargan las Ordenes de Embarque de la remision
        /// </summary>
        /// <param name="idRemision"></param>
        /// <returns></returns>
        public static List<ListaOrdenEmbarqueBusqueda> CargaEmbarquesRemision(int idRemision)
        {
            var lstOrdenEmbar = new List<ListaOrdenEmbarqueBusqueda>();
             try
            {
                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                using (IDataReader dataDetalle = db.ExecuteReader("usp_CargarRemisionDetalle", idRemision))
                {
                    
                    while (dataDetalle.Read())
                    {
                        lstOrdenEmbar.Add(new ListaOrdenEmbarqueBusqueda()
                        {
                            id = Convert.ToInt32(dataDetalle["idOrdenEmbarque"]),
                            observacionOrdenEmbarque = Convert.ToString(dataDetalle["observacionOrdenEmbarque"]),
                            fechaCreacion = Convert.ToString(dataDetalle["fechaCreacion"]),
                            idOrdenProduccion = Convert.ToInt32(dataDetalle["idOrdenProduccion"])
                        });
                    }
                }
            }
             catch (Exception exp)
             {
                 throw new ApplicationException(exp.Message, exp);
             }

             return lstOrdenEmbar;
        }

        /// <summary>
        /// Se carga la Revision
        /// </summary>
        /// <param name="idRemision"></param>
        /// <returns></returns>
        public static Remision CargaRemision(int idRemision)
        {
            Remision remision = new Remision();
            try
            {
                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarRemision", idRemision))
                {
                    while (dataReader.Read())
                    {
                        remision = new Remision()
                        {
                            id = Convert.ToInt32(dataReader["idRemision"]),
                            conductor = Convert.ToString(dataReader["conductor"]),
                            transporte = Convert.ToString(dataReader["transporte"]),
                            placas = Convert.ToString(dataReader["placas"]),
                            fechaEnvio = Convert.ToString(dataReader["fechaEnvio"]),
                            fechaRemision = Convert.ToString(dataReader["fechaRemision"]),
                            idEtapa = Convert.ToInt32(dataReader["idEtapa"]),
                            idProyecto = Convert.ToInt32(dataReader["idProyecto"]),
                            idCliente = Convert.ToInt32(dataReader["idCliente"]),
                            nombreCliente = Convert.ToString(dataReader["nombreCliente"]),
                            direccionCliente = Convert.ToString(dataReader["direccionEntregaCliente"]),
                            nombreContacto = Convert.ToString(dataReader["contactoCliente"]),
                        };
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }

            return remision;
        }

        /// <summary>
        /// Se cargna las marcar de las ordenes de embarque 
        /// asignadas a la remision
        /// </summary>
        /// <param name="idRemision"></param>
        /// <returns></returns>
        public static List<DetalleRemision> CargaDestalleRemision(int idRemision)
        {
            var lstRemisiones = new List<Models.DetalleRemision>();
            try
            {
                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarRemisionesDetalle", idRemision))
                {
                    while (dataReader.Read())
                    {
                        lstRemisiones.Add(new Models.DetalleRemision()
                        {
                            id = Convert.ToInt32(dataReader["idRemision"]),
                            Proyecto = Convert.ToString(dataReader["nombreProyecto"]),
                            Marca = Convert.ToString(dataReader["codigoMarca"]),
                            idMarca = Convert.ToInt32(dataReader["idMarca"]),
                            Etapa = Convert.ToString(dataReader["claveEtapa"]),
                            NombrePlano = Convert.ToString(dataReader["codigoPlanoMontaje"]),
                            idOrdenEmbarque = Convert.ToInt32(dataReader["idOrdenEmbarque"]),
                            Piezas = Convert.ToInt32(dataReader["piezasMarca"]),
                            Saldo = Convert.ToInt32(dataReader["piezasMarca"]) - Convert.ToInt32(dataReader["piezasLeidas"]),
                            PiezasLeidas = Convert.ToInt32(dataReader["piezasLeidas"]),
                            PesoCU = Convert.ToDouble(dataReader["pesoMarca"]),
                            PesoTotal = Convert.ToDouble(dataReader["pesoMarca"]) * Convert.ToInt32(dataReader["piezasMarca"]),
                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }

            return lstRemisiones;
        }

        /// <summary>
        /// Se cargan las Remisiones del Proyecto y Etapa
        /// </summary>
        /// <param name="idProyecto"></param>
        /// <param name="idEtapa"></param>
        /// <param name="idEstatus"></param>
        /// <returns></returns>
        public static List<ListaRemisiones> CargaRemisiones(int idProyecto, int idEtapa, int? idEstatus)
        {
            var lstRemisiones = new List<Models.ListaRemisiones>();
            object[] paramArray = new object[3];
            try
            {
                paramArray[0] = idProyecto;
                paramArray[1] = idEtapa;
                paramArray[2] = idEstatus;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarRemisiones", paramArray))
                {
                    while (dataReader.Read())
                    {
                        lstRemisiones.Add(new Models.ListaRemisiones()
                        {
                            id = Convert.ToInt32( dataReader["idRemision"]),
                            NombreCliente = Convert.ToString(dataReader["nombreCliente"]),
                            idCliente = Convert.ToInt32(dataReader["idCliente"]),
                            Transporte = Convert.ToString(dataReader["transporte"]),
                            fechaEnvio = Convert.ToString(dataReader["fechaEnvio"]),
                            fechaRemision = Convert.ToString(dataReader["fechaRemision"])
                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }

            return lstRemisiones;
        }

        /// <summary>
        /// Se actuliza la informacion de la Remision
        /// </summary>
        /// <param name="pobjModelo"></param>
        /// <returns></returns>
        public static void Actualiza(Models.Remision pobjModelo)
        {
            object[] paramArray = new object[6];
            object[] paramArrDetalle = new object[3];
            object result;
            try
            {
                paramArray[0] = pobjModelo.fechaEnvio;
                paramArray[1] = pobjModelo.idCliente;
                paramArray[2] = pobjModelo.transporte.ToUpper();
                paramArray[3] = pobjModelo.placas.ToUpper();
                paramArray[4] = pobjModelo.conductor.ToUpper();
                paramArray[5] = pobjModelo.id;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (DbConnection conn = db.CreateConnection())
                {
                    conn.Open();
                    DbTransaction trans = conn.BeginTransaction();

                    try
                    {
                        var cmdRemision = db.GetStoredProcCommand("usp_ActualizarRemision", paramArray);
                        result = db.ExecuteScalar(cmdRemision, trans);

                        foreach (var valor in pobjModelo.lstOrdenEmbarque)
                        {
                            paramArrDetalle[0] = pobjModelo.id;
                            paramArrDetalle[1] = valor;
                            paramArrDetalle[2] = pobjModelo.usuarioCreacion;

                            var cmdDetalle = db.GetStoredProcCommand("usp_InsertarRemisionDetalle", paramArrDetalle);
                            db.ExecuteScalar(cmdDetalle, trans);
                        }

                        trans.Commit();
                    }
                    catch (Exception exp)
                    {
                        // Roll back the transaction. 
                        trans.Rollback();
                        conn.Close();
                        throw new ApplicationException(exp.Message, exp);
                    }
                    conn.Close();
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }

        /// <summary>
        /// Se guarda la informacion de una nueva Remision
        /// </summary>
        /// <param name="pobjModelo">Datos nuevo Proyecto</param>
        /// <returns>value</returns>
        public static string Guardar(Models.Remision pobjModelo)
        {
            object[] paramArray = new object[8];
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
                paramArray[6] = pobjModelo.idProyecto;
                paramArray[7] = pobjModelo.idEtapa;
                
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

        /// <summary>
        /// Se registra la Marca de acuerdo a la serie de la Orden Embarque 
        /// que pertenece a la Remision
        /// </summary>
        /// <param name="idDetaOrdenEmb"></param>
        /// <param name="idMarca"></param>
        /// <param name="serie"></param>
        /// <param name="idRemision"></param>
        /// <returns></returns>
        public static string GenerarRemision(int idDetaOrdenEmb, int idMarca,
                                              string serie, int idRemision, int idUsuario)
        {
            string resultado = "";
            object[] paramArray = new object[5];
            try
            {
                paramArray[0] = idDetaOrdenEmb;
                paramArray[1] = idMarca;
                paramArray[2] = serie;
                paramArray[3] = idRemision;
                paramArray[4] = idUsuario;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteScalar("usp_RegistraRepcepRemision", paramArray);

                if (result != null)
                {
                    resultado = result.ToString();
                }

            }
            catch (Exception exp)
            {
                if (exp.HResult == -2146232060)
                {
                    throw new ApplicationException("La Serie no corresponde a la Marca de codigo de barras");
                }
                else
                {
                    throw new ApplicationException(exp.Message, exp);
                }

            }

            return resultado;
        }
    }
}
