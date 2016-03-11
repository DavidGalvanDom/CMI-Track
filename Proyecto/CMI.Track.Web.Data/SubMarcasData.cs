///Propósito: Acceso a base de datos SubMarcas
///Fecha creación: 08/Marzo/2016
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
    public class SubMarcasData
    {
        /// <summary>
        /// Se carga el listado de SubMarcas
        /// </summary>
        /// <param name="idMarca"></param>
        /// <param name="idEstatus"></param>
        /// <returns>Lista de SubMarcas</returns>
        public static List<Models.ListaSubMarcas> CargaSubMarcas(int idMarca, int? idEstatus)
        {
            var lstSubMarcas = new List<Models.ListaSubMarcas>();
            object[] paramArray = new object[3];
            try
            {
                paramArray[0] = idMarca;
                paramArray[1] = null;
                paramArray[2] = idEstatus;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarSubMarcas", paramArray))
                {
                    while (dataReader.Read())
                    {
                        lstSubMarcas.Add(new Models.ListaSubMarcas()
                        {
                            id = Convert.ToInt32(dataReader["idSubMarca"]),
                            codigoSubMarca = Convert.ToString(dataReader["codigoSubMarca"]),                            
                            piezasSubMarcas = Convert.ToInt32(dataReader["piezasSubMarca"]),
                            pesoSubMarcas = Convert.ToDouble(dataReader["pesoSubMarca"]),
                            kgmSubMarcas = Convert.ToDouble(dataReader["kgmSubMarca"]),
                            totalLASubMarcas = Convert.ToDouble(dataReader["totalLASubMarca"]),
                            anchoSubMarcas = Convert.ToDouble(dataReader["anchoSubMarca"]),
                            corteSubMarcas = Convert.ToDouble(dataReader["corteSubMarca"]),
                            longitudSubMarcas = Convert.ToDouble(dataReader["longitudSubMarca"]),
                            nombreEstatus = Convert.ToString(dataReader["nombreEstatus"]),
                            gradoSubMarcas = Convert.ToString(dataReader["gradoSubMarca"]),
                            perfilSubMarca = Convert.ToString(dataReader["perfilSubMarca"]),
                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
            return lstSubMarcas;
        }

        /// <summary>
        /// Se carga la SubMarca
        /// </summary>
        /// <param name="idMarca"></param>        
        /// <returns>Objeto de SubMarca</returns>
        public static Models.SubMarcas CargaSubMarca(int idSubMarca)
        {
            var objSubMarca = new Models.SubMarcas();
            object[] paramArray = new object[3];
            try
            {
                paramArray[0] = null;
                paramArray[1] = idSubMarca;
                paramArray[2] = null;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarSubMarcas", paramArray))
                {
                    while (dataReader.Read())
                    {
                        objSubMarca = new Models.SubMarcas()
                        {
                            id = Convert.ToInt32(dataReader["idSubMarca"]),
                            codigoSubMarca = Convert.ToString(dataReader["codigoSubMarca"]),
                            piezasSubMarcas = Convert.ToInt32(dataReader["piezasSubMarca"]),
                            pesoSubMarcas = Convert.ToDouble(dataReader["pesoSubMarca"]),
                            kgmSubMarcas = Convert.ToDouble(dataReader["kgmSubMarca"]),
                            totalLASubMarcas = Convert.ToDouble(dataReader["totalLASubMarca"]),
                            anchoSubMarcas = Convert.ToDouble(dataReader["anchoSubMarca"]),
                            corteSubMarcas = Convert.ToDouble(dataReader["corteSubMarca"]),
                            longitudSubMarcas = Convert.ToDouble(dataReader["longitudSubMarca"]),
                            idEstatus = Convert.ToInt32(dataReader["idEstatus"]),
                            fechaCreacion = Convert.ToString(dataReader["fechaCreacion"]),                            
                            idMarca = Convert.ToInt32(dataReader["idMarca"]),
                            claseSubMarca = Convert.ToString(dataReader["claseSubMarca"]),
                            gradoSubMarcas = Convert.ToString(dataReader["gradoSubMarca"]),
                            perfilSubMarca = Convert.ToString(dataReader["perfilSubMarca"]),
                            totalSubMarcas = Convert.ToDouble(dataReader["totalSubMarca"])
                        };
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
            return objSubMarca;
        }

        /// <summary>
        /// Se guarda la informacion de una nueva SubMarca
        /// </summary>
        /// <param name="pobjModelo">Datos de la nueva SubMarca</param>
        /// <returns>value</returns>
        public static string Guardar(Models.SubMarcas pobjModelo)
        {
            object[] paramArray = new object[16];
            try
            {
                paramArray[0] = pobjModelo.idEstatus;
                paramArray[1] = pobjModelo.idMarca;
                paramArray[2] = pobjModelo.codigoSubMarca.ToUpper();
                paramArray[3] = pobjModelo.perfilSubMarca.ToUpper();
                paramArray[4] = pobjModelo.piezasSubMarcas;
                paramArray[5] = pobjModelo.corteSubMarcas;
                paramArray[6] = pobjModelo.longitudSubMarcas;
                paramArray[7] = pobjModelo.anchoSubMarcas;
                paramArray[8] = pobjModelo.gradoSubMarcas;
                paramArray[9] = pobjModelo.kgmSubMarcas;
                paramArray[10] = pobjModelo.totalLASubMarcas;
                paramArray[11] = pobjModelo.pesoSubMarcas;
                paramArray[12] = pobjModelo.idOrdenProduccion;
                paramArray[13] = pobjModelo.claseSubMarca;
                paramArray[14] = pobjModelo.totalSubMarcas;
                paramArray[15] = pobjModelo.usuarioCreacion;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteScalar("usp_InsertarSubMarca", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }

        /// <summary>
        /// Se actualiza la informacion de la SubMarca
        /// </summary>
        /// <param name="pobjModelo">Datos de la SubMarca</param>
        /// <returns>value</returns>
        public static string Actualiza(Models.SubMarcas pobjModelo)
        {
            object[] paramArray = new object[15];
            try
            {
                paramArray[0] = pobjModelo.idEstatus;
                paramArray[1] = pobjModelo.idMarca;
                paramArray[2] = pobjModelo.codigoSubMarca.ToUpper();
                paramArray[3] = pobjModelo.perfilSubMarca.ToUpper();
                paramArray[4] = pobjModelo.piezasSubMarcas;
                paramArray[5] = pobjModelo.corteSubMarcas;
                paramArray[6] = pobjModelo.longitudSubMarcas;
                paramArray[7] = pobjModelo.anchoSubMarcas;
                paramArray[8] = pobjModelo.gradoSubMarcas;
                paramArray[9] = pobjModelo.kgmSubMarcas;
                paramArray[10] = pobjModelo.totalLASubMarcas;
                paramArray[11] = pobjModelo.pesoSubMarcas;
                paramArray[12] = pobjModelo.claseSubMarca;
                paramArray[13] = pobjModelo.totalSubMarcas;
                paramArray[14] = pobjModelo.id;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteNonQuery("usp_ActualizarSubMarca", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }

        /// <summary>
        /// Se borra de la base de datos la SubMarca
        /// </summary>
        /// <param name="idSubMarca"></param>
        /// <returns></returns>
        public static string Borrar(int idSubMarca)
        {
            object[] paramArray = new object[1];
            try
            {
                paramArray[0] = idSubMarca;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteNonQuery("usp_RemueveSubMarca", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }
    }
}
