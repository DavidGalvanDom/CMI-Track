///Propósito: Datos de ordenes de embarque
///Fecha creación: 02/Febrero/2016
///Creador: David Jasso
///Fecha modifiacción: 
///Modificó:
///Dependencias de conexiones e interfaces: SQLServer

using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Data;
using System.Data.Common;
using Microsoft.Practices.EnterpriseLibrary.Data;
using CMI.Track.Web.Models;

namespace CMI.Track.Web.Data
{
    public class OrdenEmbarqueData
    {

        /// <summary>
        /// Se carga la orden de embarque
        /// </summary>
        /// <param name="idOrdenEmbarque"></param>
        /// <returns></returns>
        public static OrdenEmbarque CargarOrdenEmbarque(int idOrdenEmbarque)
        {
            var objOrdenEmbarque = new OrdenEmbarque() { id = -1};
            string id = "";
            object[] paramArray = new object[1];
            try
            {
                paramArray[0] = idOrdenEmbarque;
                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarOrdenEmbarque", paramArray))
                {
                    while (dataReader.Read())
                    {
                        if (objOrdenEmbarque.id == -1)
                        {
                            objOrdenEmbarque.id = idOrdenEmbarque;
                            objOrdenEmbarque.Obervaciones = Convert.ToString(dataReader["observacionOrdenEmbarque"]);
                            objOrdenEmbarque.EstatusOE = Convert.ToInt32(dataReader["estatusOrdenEmbarque"]);
                            objOrdenEmbarque.fechaCreacion = Convert.ToString(dataReader["fechaCreacion"]);

                            objOrdenEmbarque.lstMS = new List<string>();
                            objOrdenEmbarque.lstMarcasExis = new List<ListaMarcasOrdenEm>();
                           
                        }
                        id = Convert.ToString(dataReader["idMarca"]) + Convert.ToString(dataReader["idSerie"]);
                         objOrdenEmbarque.lstMS.Add(id);

                         objOrdenEmbarque.lstMarcasExis.Add(new ListaMarcasOrdenEm() {
                             id = id,
                             idMarca = Convert.ToInt32(dataReader["idMarca"]),
                             idSerie =  Convert.ToString(dataReader["idSerie"]),
                             NombreMarca = Convert.ToString(dataReader["nombreMarca"]),
                             NombrePlano = Convert.ToString(dataReader["nombrePlanoMontaje"]),
                             Peso = Convert.ToDouble(dataReader["pesoMarca"]),
                             Piezas = Convert.ToInt32(dataReader["piezasMarca"])
                         });

                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }

            return objOrdenEmbarque;

        }
        
        /// <summary>
        /// Carga el detalle de las ordenes de embarque 
        /// </summary>
        /// <param name="idOrdenEmbarque"></param>
        /// <returns></returns>
        public static List<ReportOrdenEmbarque> CargaReporteDetaOE(int idOrdenEmbarque)
        {
            var listaOrdenEmbar = new List<Models.ReportOrdenEmbarque>();
            object[] paramArray = new object[1];
            try
            {
                paramArray[0] = idOrdenEmbarque;


                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarReporteDetaOE", paramArray))
                {
                    while (dataReader.Read())
                    {
                        listaOrdenEmbar.Add(new Models.ReportOrdenEmbarque()
                        {

                            idMarca = Convert.ToInt32(dataReader["idMarca"]),
                            nombrePlano = Convert.ToString(dataReader["nombrePlanoMontaje"]),
                            nombreMarca = Convert.ToString(dataReader["nombreMarca"]),
                            piezas = Convert.ToInt32(dataReader["piezasMarca"]),
                            peso = Convert.ToDouble(dataReader["pesoMarca"]),
                            pesoTotal = Convert.ToInt32(dataReader["piezasMarca"]) * Convert.ToDouble(dataReader["pesoMarca"])
                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }

            return listaOrdenEmbar;
        }
        /// <summary>
        /// Se carga el listado de marcas
        /// </summary>
        /// <returns>Lista marcas</returns>
        public static List<Models.ListaMarcasOrdenEm> CargaMarcas(int idProyecto, int idEtapa)
        {
            var listaMarcas = new List<Models.ListaMarcasOrdenEm>();
            object[] paramArray = new object[2];
            try
            {
                paramArray[0] = idProyecto;
                paramArray[1] = idEtapa;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarMarcasDispoOrdenEmb", paramArray))
                {
                    while (dataReader.Read())
                    {
                        listaMarcas.Add(new Models.ListaMarcasOrdenEm()
                        {
                            id = string.Format("{0}{1}", Convert.ToInt32(dataReader["idMarca"]) ,Convert.ToString(dataReader["idSerie"])) ,
                            idMarca = Convert.ToInt32(dataReader["idMarca"]),
                            idSerie = Convert.ToString(dataReader["idSerie"]),
                            NombreMarca = Convert.ToString(dataReader["nombreMarca"]),
                            Piezas = Convert.ToDouble(dataReader["piezasMarca"]),
                            Peso = Convert.ToDouble(dataReader["pesoMarca"]),
                            NombrePlano = Convert.ToString(dataReader["nombrePlanoMontaje"])
                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }

            return listaMarcas;
        }

        /// <summary>
        /// Se carga el reporte de requisiciones
        /// </summary>
        /// <returns>Lista Requerimiento</returns>
        public static List<Models.ListaOrdenEmbarque> CargaHeaderOrdeEmb(int idProyecto, int idEtapa, int idOrden)
        {
            var listaRptOrdenEmbarque = new List<Models.ListaOrdenEmbarque>();
            object[] paramArray = new object[3];
            try
            {
                paramArray[0] = idProyecto;
                paramArray[1] = idEtapa;
                paramArray[2] = idOrden;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarHeaderOrdenEmbarque", paramArray))
                {
                    while (dataReader.Read())
                    {
                        listaRptOrdenEmbarque.Add(new Models.ListaOrdenEmbarque()
                        {
                            NombreEtapa = Convert.ToString(dataReader["Etapa"]),
                            Codigo = Convert.ToString(dataReader["codigoProyecto"]),
                            Revision = Convert.ToString(dataReader["revisionProyecto"]),
                            idOrdenEmb = Convert.ToInt32(dataReader["idOrdenEmbarque"]),
                            NombreProyecto = Convert.ToString(dataReader["nombreProyecto"]),
                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }

            return listaRptOrdenEmbarque;
        }

        /// <summary>
        /// Se actuliza la informacion de la Orden de Embarque.
        /// </summary>
        /// <param name="pobjModelo"></param>
        /// <returns></returns>
        public static void Actualizar (Models.OrdenEmbarque pobjModelo)
        {
            object[] paramArray = new object[3];
            object[] paramArrDetalle = new object[4];
            DbCommand cmdDetalle;

            try
            {
                paramArray[0] = pobjModelo.EstatusOE;
                paramArray[1] = pobjModelo.Obervaciones.ToUpper();
                paramArray[2] = pobjModelo.id;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (DbConnection conn = db.CreateConnection())
                {
                    conn.Open();
                    DbTransaction trans = conn.BeginTransaction();

                    try
                    {
                        var cmdOrdenEmbarque = db.GetStoredProcCommand("usp_ActulizarOrdenEmbarque", paramArray);
                        db.ExecuteScalar(cmdOrdenEmbarque, trans);

                        foreach (var valorMS in pobjModelo.lstMS)
                        {
                            string[] arrValor = valorMS.Split('|');

                            paramArrDetalle[0] = pobjModelo.id;
                            paramArrDetalle[1] = arrValor[0].Substring(0, arrValor[0].Length - 2);
                            paramArrDetalle[2] = arrValor[0].Substring(arrValor[0].Length - 2, 2);
                            paramArrDetalle[3] = pobjModelo.usuarioCreacion;

                            if (arrValor[1] == "0")
                            {
                                cmdDetalle = db.GetStoredProcCommand("usp_RemueveDetalleOrdenEmbarque", paramArrDetalle);
                            }
                            else
                            {
                                cmdDetalle = db.GetStoredProcCommand("usp_InsertarDetalleOrdenEmbarque", paramArrDetalle);
                            }

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
        /// Se guarda la informacion de una nueva categora
        /// </summary>
        /// <param name="pobjModelo">Datos nueva Categoria</param>
        /// <returns>value</returns>
        public static string Guardar(Models.OrdenEmbarque pobjModelo)
        {
            object[] paramArray = new object[5];
            object[] paramArrDetalle = new object[4];
            object result;

            try
            {
                paramArray[0] = pobjModelo.idProyecto;
                paramArray[1] = pobjModelo.idEtapa;
                paramArray[2] = pobjModelo.EstatusOE;
                paramArray[3] = pobjModelo.Obervaciones.ToUpper();
                paramArray[4] = pobjModelo.usuarioCreacion;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (DbConnection conn = db.CreateConnection())
                {
                    conn.Open();
                    DbTransaction trans = conn.BeginTransaction();

                    try
                    {
                        var cmdOrdenEmbarque = db.GetStoredProcCommand("usp_InsertarOrdenEmbarque", paramArray);
                        result = db.ExecuteScalar(cmdOrdenEmbarque, trans);

                        foreach (var valor in pobjModelo.lstMS)
                        {
                            paramArrDetalle[0] = Convert.ToInt32(result);
                            paramArrDetalle[1] = valor.Substring(0, valor.Length - 2);
                            paramArrDetalle[2] = valor.Substring(valor.Length - 2, 2);
                            paramArrDetalle[3] = pobjModelo.usuarioCreacion;

                            var cmdDetalle = db.GetStoredProcCommand("usp_InsertarDetalleOrdenEmbarque", paramArrDetalle);
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

            return (Convert.ToString(result));
        }

        /// <summary>
        /// Se registra la Marca de acuerdo a la serie
        /// </summary>
        /// <param name="idOrdenEmbarque"></param>
        /// <param name="idMarca"></param>
        /// <param name="serie"></param>
        /// <param name="origen"></param>
        /// <returns></returns>
        public static string GenerarEmbarque(int idOrdenEmbarque, int idMarca,
                                              string serie, string origen, int idUsuario)
        {
            string resultado = "";
            object[] paramArray = new object[5];
            try
            {
                paramArray[0] = idOrdenEmbarque;
                paramArray[1] = idMarca;
                paramArray[2] = serie;
                paramArray[3] = origen;
                paramArray[4] = idUsuario;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteScalar("usp_RegistraEmbarque", paramArray);

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

        /// <summary>
        /// Se carga la lista del detalle de Orden de Embarque
        /// </summary>
        /// <param name="idOrdenEmbarque"></param>
        /// <returns></returns>
        public static List<Models.DetalleOrdenEmbarque> CargarDetalleOrdenEmbarque(int idOrdenEmbarque, string tipo)
        {
            var lstDetalleOrdEmbar = new List<Models.DetalleOrdenEmbarque>();
            string spNombre = tipo == "EM" ? "usp_CargarDetalleOrdenEmbar" : "usp_CargarDetalleOrdenEmbar2";
            object[] paramArray = new object[1];
            try
            {
                paramArray[0] = idOrdenEmbarque;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader(spNombre, paramArray))
                {
                    while (dataReader.Read())
                    {
                        if (dataReader["Mensaje"].ToString() != string.Empty)
                        {
                            throw new ApplicationException(dataReader["Mensaje"].ToString());
                        }

                        lstDetalleOrdEmbar.Add(new Models.DetalleOrdenEmbarque()
                        {
                            id = string.Format("{0}{1}", Convert.ToInt32(dataReader["idOrdenEmbarque"]),Convert.ToInt32(dataReader["idMarca"])),
                            idOrdenEmbarque = Convert.ToInt32(dataReader["idOrdenEmbarque"]),
                            idMarca = Convert.ToInt32(dataReader["idMarca"]),
                            claveEtapa = Convert.ToString(dataReader["claveEtapa"]),
                            nombreProyecto = Convert.ToString(dataReader["nombreProyecto"]),
                            nombreMarca = Convert.ToString(dataReader["codigoMarca"]),
                            nombrePlano = Convert.ToString(dataReader["codigoPlanoMontaje"]),
                            piezas = Convert.ToInt32(dataReader["piezasMarca"]),
                            piezasLeidas = Convert.ToInt32(dataReader["piezasLeidas"]),
                            peso = Convert.ToDouble(dataReader["pesoMarca"]),
                            pesoTotal = Convert.ToDouble(dataReader["pesoMarca"]) * Convert.ToInt32(dataReader["piezasMarca"]),
                            Saldo = Convert.ToInt32(dataReader["piezasMarca"]) - Convert.ToInt32(dataReader["piezasLeidas"])
                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }

            return lstDetalleOrdEmbar;
        }

        /// <summary>
        /// Se carga la lista de Ordenes de Embarque de acuerdo al criterio de busqueda
        /// </summary>
        /// <param name="idProyecto"></param>
        /// <param name="revision"></param>
        /// <param name="idEtapa"></param>
        /// <param name="idEstatus"></param>
        /// <returns></returns>
        public static List<Models.ListaOrdenEmbarqueBusqueda> CargarOrdenesEmbarque(int idProyecto, int idEtapa, 
                                                                                    int? idEstatus, bool sinRemision)
        {
            var lstOrdenesEmbarque = new List<Models.ListaOrdenEmbarqueBusqueda>();
            object[] paramArray = new object[4];
            try
            {
                paramArray[0] = idProyecto;
                paramArray[1] = idEtapa;
                paramArray[2] = idEstatus;
                paramArray[3] = sinRemision;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarOERemision", paramArray))
                {
                    while (dataReader.Read())
                    {
                        lstOrdenesEmbarque.Add(new Models.ListaOrdenEmbarqueBusqueda()
                        {
                            id = Convert.ToInt32(dataReader["idOrdenEmbarque"]),
                            idOrdenProduccion = Convert.ToInt32(dataReader["idOrdenProduccion"]),
                            observacionOrdenEmbarque= Convert.ToString(dataReader["observacionOrdenEmbarque"]),
                            estatuOrdeEmbarque = Convert.ToString(dataReader["estatusOrdenEmbarque"]) == "1" ? "ABIERTO" : "CERRADO",
                            fechaCreacion = Convert.ToString(dataReader["fechaCreacion"])
                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }

            return lstOrdenesEmbarque;
        }

        /// <summary>
        /// Se borra el detalle y la orden demembarque 
        /// </summary>
        /// <param name="idOrdenEmbarque"></param>
        public static void Borrar(int idOrdenEmbarque)
        {
            object[] paramArray = new object[1];
            try
            {
                paramArray[0] = idOrdenEmbarque;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteNonQuery("usp_RemueveOrdenEmbarque", paramArray);

            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }
    }
}
