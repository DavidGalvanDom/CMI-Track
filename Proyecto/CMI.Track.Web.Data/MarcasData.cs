///Propósito: Acceso a base de datos Marcas
///Fecha creación: 25/Febrero/2016
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
    public class MarcasData
    {
        /// <summary>
        /// Se carga el listado de Marcas
        /// </summary>
        /// <param name="idPlanoDespiece"></param>
        /// <param name="idEstatus"></param>
        /// <returns>Lista de Marcas</returns>
        public static List<Models.ListaMarcas> CargaMarcas(int idPlanoDespiece, int? idEstatus)
        {
            var lstMarcas = new List<Models.ListaMarcas>();
            object[] paramArray = new object[3];
            try
            {
                paramArray[0] = idPlanoDespiece;
                paramArray[1] = null;
                paramArray[2] = idEstatus;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarMarcas", paramArray))
                {
                    while (dataReader.Read())
                    {
                        lstMarcas.Add(new Models.ListaMarcas()
                        {
                            id = Convert.ToInt32(dataReader["idMarca"]),
                            nombreMarca = Convert.ToString(dataReader["nombreMarca"]),
                            codigoMarca = Convert.ToString(dataReader["codigoMarca"]),
                            Piezas = Convert.ToInt32(dataReader["piezasMarca"]),                           
                            nombreEstatus = Convert.ToString(dataReader["nombreEstatus"])
                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
            return lstMarcas;
        }

        /// <summary>
        /// Se carga la Marca
        /// </summary>
        /// <param name="idMarca"></param>        
        /// <returns>Objeto de Marca</returns>
        public static Models.Marca CargaMarca(int idMarca)
        {
            var objMarca = new Models.Marca();
            object[] paramArray = new object[3];
            try
            {
                paramArray[0] = null;
                paramArray[1] = idMarca;
                paramArray[2] = null;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarMarcas", paramArray))
                {
                    while (dataReader.Read())
                    {
                        objMarca = new Models.Marca()
                        {
                            id = Convert.ToInt32(dataReader["idMarca"]),
                            nombreMarca = Convert.ToString(dataReader["nombreMarca"]),
                            idEstatus = Convert.ToInt32(dataReader["idEstatus"]),                            
                            fechaCreacion = Convert.ToString(dataReader["fechaCreacion"]),
                            codigoMarca = Convert.ToString(dataReader["codigoMarca"]),
                            pesoMarca = Convert.ToDouble(dataReader["pesoMarca"]),
                            piezas = Convert.ToInt32(dataReader["piezasMarca"]),
                            idPlanoDespiece = Convert.ToInt32(dataReader["idPlanoDespiece"]),
                        };
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
            return objMarca;
        }

        /// <summary>
        /// Se guarda la informacion de una nueva Marca
        /// </summary>
        /// <param name="pobjModelo">Datos de la nueva Marca</param>
        /// <returns>value</returns>
        public static string Guardar(Models.Marca pobjModelo)
        {
            object[] paramArray = new object[7];
            try
            {
                paramArray[0] = pobjModelo.idEstatus;
                paramArray[1] = pobjModelo.nombreMarca.ToUpper();
                paramArray[2] = pobjModelo.codigoMarca.ToUpper();
                paramArray[3] = pobjModelo.piezas;
                paramArray[4] = pobjModelo.pesoMarca;                
                paramArray[5] = pobjModelo.idPlanoDespiece;
                paramArray[6] = pobjModelo.usuarioCreacion;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteScalar("usp_InsertarMarca", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }

        /// <summary>
        /// Se actualiza la informacion de la Marca
        /// </summary>
        /// <param name="pobjModelo">Datos de la Marca</param>
        /// <returns>value</returns>
        public static string Actualiza(Models.Marca pobjModelo)
        {
            object[] paramArray = new object[7];
            try
            {
                paramArray[0] = pobjModelo.idEstatus;
                paramArray[1] = pobjModelo.nombreMarca.ToUpper();
                paramArray[2] = pobjModelo.codigoMarca.ToUpper();
                paramArray[3] = pobjModelo.pesoMarca;
                paramArray[4] = pobjModelo.piezas;                
                paramArray[5] = pobjModelo.idPlanoDespiece;
                paramArray[6] = pobjModelo.id;
                
                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteNonQuery("usp_ActualizarMarca", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }

        /// <summary>
        /// Se borra de la base de datos la Marca
        /// </summary>
        /// <param name="idMarca"></param>
        /// <returns></returns>
        public static string Borrar(int idMarca)
        {
            object[] paramArray = new object[1];
            try
            {
                paramArray[0] = idMarca;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteNonQuery("usp_RemueveMarca", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }

    }
}
