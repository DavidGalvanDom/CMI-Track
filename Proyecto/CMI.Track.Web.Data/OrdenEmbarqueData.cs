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
using Microsoft.Practices.EnterpriseLibrary.Data;
using CMI.Track.Web.Models;

namespace CMI.Track.Web.Data
{
    public class OrdenEmbarqueData
    {


        /// <summary>
        /// Se carga el listado de Marcas
        /// </summary>
        /// <param name="idRequerimiento"></param>
        /// <param name="idEstatus"></param>
        /// <returns>Lista de Marcas</returns>
        public static List<Models.ListaOrdenEmbarque> CargaOrdenEmbarque(int idProyecto, int idEtapa,
                                                                    string idOrden)
        {
            var lstOrdenEmbarque = new List<Models.ListaOrdenEmbarque>();
            object[] paramArray = new object[3];
            try
            {
                paramArray[0] = idProyecto;
                paramArray[1] = idEtapa;
                paramArray[2] = idOrden == "undefined" ? null : idOrden;
           

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarOrdenEmbarque", paramArray))
                {
                    while (dataReader.Read())
                    {
                        lstOrdenEmbarque.Add(new Models.ListaOrdenEmbarque()
                        {
                            id = Convert.ToInt32(dataReader["rank"]),
                            NombreProyecto = Convert.ToString(dataReader["nombreProyecto"]),
                            idEtapa = Convert.ToInt32(dataReader["idEtapa"]),
                            NombreMarca = Convert.ToString(dataReader["nombreMarca"]),
                            Piezas = Convert.ToDouble(dataReader["piezasMarca"]),
                            Peso = Convert.ToDouble(dataReader["pesoMarca"]),
                            Total = Convert.ToDouble(dataReader["Total"]),
                            NombrePlano = Convert.ToString(dataReader["nombrePlanoMontaje"])
                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
            return lstOrdenEmbarque;
        }

        /// <summary>
        /// Se carga el listado de marcas
        /// </summary>
        /// <returns>Lista marcas</returns>
        public static List<Models.ListaOrdenEmbarque> CargaMarcas(int idProyecto, int idEtapa)
        {
            var listaMateriales = new List<Models.ListaOrdenEmbarque>();
            object[] paramArray = new object[2];
            try
            {
                paramArray[0] = idProyecto;
                paramArray[1] = idEtapa;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarMarcasOrdenEmb", paramArray))
                {
                    while (dataReader.Read())
                    {
                        listaMateriales.Add(new Models.ListaOrdenEmbarque()
                        {
                            id = Convert.ToInt32(dataReader["idMarca"]),
                            NombreProyecto = Convert.ToString(dataReader["nombreProyecto"]),
                            idEtapa = Convert.ToInt32(dataReader["idEtapa"]),
                            NombreMarca = Convert.ToString(dataReader["nombreMarca"]),
                            Piezas = Convert.ToDouble(dataReader["piezasMarca"]),
                            Peso = Convert.ToDouble(dataReader["pesoMarca"]),
                            Total = Convert.ToDouble(dataReader["Total"]),
                            NombrePlano = Convert.ToString(dataReader["nombrePlanoMontaje"])

                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }

            return listaMateriales;
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
        /// Se carga el listado de ordenes
        /// </summary>
        /// <returns>Lista categorias</returns>
        public static List<Models.ListaOrdenEmbarque> CargaOrdenes()
        {
            var listaOrdenes = new List<Models.ListaOrdenEmbarque>();
            try
            {

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarOrdenes"))
                {
                    while (dataReader.Read())
                    {
                        listaOrdenes.Add(new Models.ListaOrdenEmbarque()
                        {
                            idOrdenEmb = Convert.ToInt32(dataReader["idOrdenEmbarque"]),

                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }

            return listaOrdenes;
        }
      

        /// <summary>
        /// Se guarda la informacion de una nueva categora
        /// </summary>
        /// <param name="pobjModelo">Datos nueva Categoria</param>
        /// <returns>value</returns>
        public static string Guardar(Models.OrdenEmbarque pobjModelo)
        {
            object[] paramArray = new object[7];
            try
            {             
                paramArray[0] = pobjModelo.idProyecto;
                paramArray[1] = pobjModelo.idEtapa;
                paramArray[2] = pobjModelo.EstatusOE;
                paramArray[3] = pobjModelo.Obervaciones.ToUpper();
                paramArray[4] = pobjModelo.Revision;
                paramArray[5] = pobjModelo.idMarca;
                paramArray[6] = pobjModelo.usuarioCreacion;


                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteScalar("usp_InsertarOrdenEmbarque", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }

        /// <summary>
        /// Se registra la Marca de acuerdo a la serie
        /// </summary>
        /// <param name="idDetaOrdenEmb"></param>
        /// <param name="idMarca"></param>
        /// <param name="serie"></param>
        /// <param name="origen"></param>
        /// <returns></returns>
        public static string GenerarEmbarque(int idDetaOrdenEmb, int idMarca,
                                              string serie, string origen, int idUsuario)
        {
            string resultado = "";
            object[] paramArray = new object[5];
            try
            {
                paramArray[0] = idDetaOrdenEmb;
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
                            id = Convert.ToInt32(dataReader["idDetalleOrdenEmbarque"]),
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
        public static List<Models.ListaOrdenEmbarqueBusqueda> CargarOrdenesEmbarque(int idProyecto, string revision,
                                                                        int idEtapa, int? idEstatus, bool sinRemision)
        {
            var lstOrdenesEmbarque = new List<Models.ListaOrdenEmbarqueBusqueda>();
            object[] paramArray = new object[5];
            try
            {
                paramArray[0] = idProyecto;
                paramArray[1] = revision;
                paramArray[2] = idEtapa;
                paramArray[3] = idEstatus;
                paramArray[4] = sinRemision;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarOrdenesEmbarque", paramArray))
                {
                    while (dataReader.Read())
                    {

                        lstOrdenesEmbarque.Add(new Models.ListaOrdenEmbarqueBusqueda()
                        {
                            id = Convert.ToInt32(dataReader["idOrdenEmbarque"]),
                            idOrdenProduccion = Convert.ToInt32(dataReader["idOrdenProduccion"]),
                            observacionOrdenEmbarque = Convert.ToString(dataReader["observacionOrdenEmbarque"]),
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
    }
}
