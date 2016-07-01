///Propósito: Acceso a base de datos Planos Montaje
///Fecha creación: 20/Febrero/2016
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
    public class ReqGralMaterialData
    {
        /// <summary>
        /// Se carga el listado de Planos Montaje
        /// </summary>
        /// <param name="idEtapa"></param>
        /// <param name="idEstatus"></param>
        /// <returns>Lista de Etapas</returns>
        public static List<Models.ListaReqGralMaterial> CargaRequerimientosGeneral(int idEtapa, int idProyecto, int? idEstatus)
        {
            var listaReqGralMateriales = new List<Models.ListaReqGralMaterial>();
            object[] paramArray = new object[3];
            try
            {
                paramArray[0] = idEtapa;
                paramArray[1] = idProyecto;
                paramArray[2] = idEstatus;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarRequerimientosGral", paramArray))
                {
                    while (dataReader.Read())
                    {
                        listaReqGralMateriales.Add(new Models.ListaReqGralMaterial()
                        {
                            id = Convert.ToInt32(dataReader["idRequerimiento"]),
                            //idProyecto = Convert.ToInt32(dataReader["idProyecto"]),
                            folioRequerimiento = Convert.ToString(dataReader["folioRequerimiento"]),
                            etapaProyecto = Convert.ToInt32(dataReader["idEtapa"]),
                            Nombre = Convert.ToString(dataReader["nombreProyecto"]),
                            nombreEstatus = Convert.ToString(dataReader["nombreEstatus"]),
                            fechaIniEtapa = Convert.ToString(dataReader["fechaInicioEtapa"]),
                            fechaFinEtapa = Convert.ToString(dataReader["fechaFinEtapa"]),
                            fechaSolicitud = Convert.ToString(dataReader["fechaSolicitud"]),
                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
            return listaReqGralMateriales;
        }

        /// <summary>
        /// Se carga el listado de Planos Montaje
        /// </summary>
        /// <param name="idEtapa"></param>
        /// <param name="idEstatus"></param>
        /// <returns>Lista de Etapas</returns>
        public static List<Models.ListaReqGralMaterial> CargaRequerimientosGeneralId(int idEtapa, int idProyecto, int idRequerimiento, int? idEstatus)
        {
            var listaReqGralMateriales = new List<Models.ListaReqGralMaterial>();
            object[] paramArray = new object[4];
            try
            {
                paramArray[0] = idEtapa;
                paramArray[1] = idProyecto;
                paramArray[2] = idRequerimiento;
                paramArray[3] = 1;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarRequerimientosGralId", paramArray))
                {
                    while (dataReader.Read())
                    {
                        listaReqGralMateriales.Add(new Models.ListaReqGralMaterial()
                        {
                            id = Convert.ToInt32(dataReader["numeroRenglon"]),
                            perfilSubMarca = Convert.ToString(dataReader["perfilDetalleReq"]),
                            piezasSubMarca = Convert.ToInt32(dataReader["piezasDetalleReq"]),
                            corteSubMarca = Convert.ToInt32(dataReader["cortesDetalleReq"]),
                            longitudSubMarca = Convert.ToInt32(dataReader["logitudDetalleReq"]),
                            anchoSubMarca = Convert.ToInt32(dataReader["anchoDetalleReq"]),
                            gradoSubMarca = Convert.ToString(dataReader["gradoDetalleReq"]),
                            kgmSubMarca = Convert.ToInt32(dataReader["kgmDetalleReq"]),
                            totalLASubMarca = Convert.ToDouble(dataReader["totalLADetalleReq"]),
                            pesoSubMarca = Convert.ToInt32(dataReader["pesoDetalleReq"]),
                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
            return listaReqGralMateriales;
        }
    }
}
