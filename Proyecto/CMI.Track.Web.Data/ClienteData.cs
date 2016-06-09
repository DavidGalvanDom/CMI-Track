///Propósito: Datos de Clientes
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
    public class ClienteData
    {
        /// <summary>
        /// Se carga el listado de clientes
        /// </summary>
        /// <returns>Lista clientes</returns>
        public static List<Models.ListaCliente> CargaClientes()
        {
            var listaClientes = new List<Models.ListaCliente>();
            object[] paramArray = new object[2];
            try
            {
                paramArray[0] = null;
                paramArray[1] = null;
                
                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarCLientes", paramArray))
                {
                    while (dataReader.Read())
                    {
                        listaClientes.Add(new Models.ListaCliente()
                        {
                            id = Convert.ToInt32(dataReader["idCliente"]),
                            NombreCliente = Convert.ToString(dataReader["nombreCliente"]),
                            DireccionEntrega = Convert.ToString(dataReader["direccionEntregaCliente"]),
                            ColoniaCliente = Convert.ToString(dataReader["coloniaCliente"]),
                            CpCliente = Convert.ToInt32(dataReader["cpCliente"]),
                            CiudadCliente = Convert.ToString(dataReader["ciudadCliente"]),
                            EstadoCliente = Convert.ToString(dataReader["estadoCliente"]),
                            PaisCliente = Convert.ToString(dataReader["paisCliente"]),
                            ContactoCliente = Convert.ToString(dataReader["contactoCliente"]),
                            Estatus = Convert.ToString(dataReader["nombreEstatus"]),
                            
                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }

            return listaClientes;
        }

        /// <summary>
        /// Se carga el listado de clientes
        /// </summary>
        /// <returns>Lista clientes</returns>
        public static List<Models.ListaCliente> CargaClientesActivos()
        {
            var listaClientes = new List<Models.ListaCliente>();
            object[] paramArray = new object[2];
            try
            {
                paramArray[0] = null;
                paramArray[1] = 1;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarCLientes", paramArray))
                {
                    while (dataReader.Read())
                    {
                        listaClientes.Add(new Models.ListaCliente()
                        {
                            id = Convert.ToInt32(dataReader["idCliente"]),
                            NombreCliente = Convert.ToString(dataReader["nombreCliente"]),
                            DireccionEntrega = Convert.ToString(dataReader["direccionEntregaCliente"]),
                            ColoniaCliente = Convert.ToString(dataReader["coloniaCliente"]),
                            CpCliente = Convert.ToInt32(dataReader["cpCliente"]),
                            CiudadCliente = Convert.ToString(dataReader["ciudadCliente"]),
                            EstadoCliente = Convert.ToString(dataReader["estadoCliente"]),
                            PaisCliente = Convert.ToString(dataReader["paisCliente"]),
                            ContactoCliente = Convert.ToString(dataReader["contactoCliente"]),
                            Estatus = Convert.ToString(dataReader["nombreEstatus"]),

                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }

            return listaClientes;
        }


        /// <summary>
        /// Se carga el listado de clientes
        /// </summary>
        /// <returns>Lista Clientes</returns>
        public static Models.Cliente CargaCliente(string idCliente)
        {
            object[] paramArray = new object[2];
            try
            {
                paramArray[0] = idCliente == "" ? null : idCliente;
                paramArray[1] = null;
                
                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarCLientes", paramArray))
                {
                    while (dataReader.Read())
                    {
                        var objCliente = new Models.Cliente()
                        {
                            id = Convert.ToInt32(dataReader["idCliente"]),
                            NombreCliente = Convert.ToString(dataReader["nombreCliente"]),
                            DireccionEntrega = Convert.ToString(dataReader["direccionEntregaCliente"]),
                            ColoniaCliente = Convert.ToString(dataReader["coloniaCliente"]),
                            CpCliente = Convert.ToInt32(dataReader["cpCliente"]),
                            CiudadCliente = Convert.ToString(dataReader["ciudadCliente"]),
                            EstadoCliente = Convert.ToString(dataReader["estadoCliente"]),
                            PaisCliente = Convert.ToString(dataReader["paisCliente"]),
                            ContactoCliente = Convert.ToString(dataReader["contactoCliente"]),
                            Estatus = Convert.ToString(dataReader["idEstatus"]),                           
                        };

                        return objCliente;
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
        /// Se guarda la informacion de un nuevo cliente
        /// </summary>
        /// <param name="pobjModelo">Datos nuevoCliente</param>
        /// <returns>value</returns>
        public static string Guardar(Models.Cliente pobjModelo)
        {
            object[] paramArray = new object[10];
            try
            {             
                paramArray[0] = pobjModelo.NombreCliente.ToUpper();
                paramArray[1] = pobjModelo.DireccionEntrega.ToUpper();
                paramArray[2] = pobjModelo.ColoniaCliente.ToUpper();
                paramArray[3] = pobjModelo.CpCliente;
                paramArray[4] = pobjModelo.CiudadCliente.ToUpper();
                paramArray[5] = pobjModelo.EstadoCliente.ToUpper();
                paramArray[6] = pobjModelo.PaisCliente.ToUpper();
                paramArray[7] = pobjModelo.ContactoCliente.ToUpper();
                paramArray[8] = pobjModelo.usuarioCreacion;
                paramArray[9] = pobjModelo.Estatus;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteScalar("usp_InsertarCliente", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }

        /// <summary>
        /// Se actuliza la informacion del cliente
        /// </summary>
        /// <param name="pobjModelo">Datos del Cliente</param>
        /// <returns>value</returns>
        public static string Actualiza(Models.Cliente pobjModelo)
        {
            object[] paramArray = new object[10];
            try
            {
                paramArray[0] = pobjModelo.id;
                paramArray[1] = pobjModelo.Estatus;
                paramArray[2] = pobjModelo.NombreCliente.ToUpper();
                paramArray[3] = pobjModelo.DireccionEntrega.ToUpper();
                paramArray[4] = pobjModelo.ColoniaCliente.ToUpper();
                paramArray[5] = pobjModelo.CpCliente;
                paramArray[6] = pobjModelo.CiudadCliente.ToUpper();
                paramArray[7] = pobjModelo.EstadoCliente.ToUpper();
                paramArray[8] = pobjModelo.PaisCliente.ToUpper();
                paramArray[9] = pobjModelo.ContactoCliente.ToUpper();

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteNonQuery("usp_ActualizarCliente", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }

        /// <summary>
        /// Remueve de base de datos el cliente
        /// </summary>
        /// <param name="idCliente"></param>
        /// <returns></returns>
        public static string Borrar(string idCliente)
        {
            object[] paramArray = new object[1];
            try
            {
                paramArray[0] = idCliente;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteNonQuery("usp_RemueveCliente", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }

       
    }
}
