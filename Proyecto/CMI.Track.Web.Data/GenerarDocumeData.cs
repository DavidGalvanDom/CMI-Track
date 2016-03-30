///Propósito: Generacion de documentos para Requisiciones
///Fecha creación: 28/Marzo/2016
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
    public  class GenerarDocumeData
    {

        /// <summary>
        /// Se genera los requerimientos iniciales de la etapa
        /// </summary>
        /// <param name="idProyecto"></param>
        /// <param name="idEtapa"></param>
        /// <param name="idUsuario"></param>
        /// <returns></returns>
        public static Models.ReqGralMaterial GenerarRequerimientos(int idProyecto, int idEtapa, int idUsuario)
        {
            var requerimientoGenMat = new Models.ReqGralMaterial() { id=0};
            object[] paramArray = new object[3];
            try
            {
                paramArray[0] = idProyecto;
                paramArray[1] = idEtapa;
                paramArray[2] = idUsuario;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                db.ExecuteNonQuery("usp_GenerarRequerimientos", paramArray);

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarReqGenMat", idProyecto, idEtapa))
                {
                    while (dataReader.Read())
                    {
                        if (requerimientoGenMat.id <= 0)
                        {
                            requerimientoGenMat.codigoProyecto = dataReader["codigoProyecto"].ToString();
                            requerimientoGenMat.idProyecto = idProyecto;
                            requerimientoGenMat.id = Convert.ToInt32(dataReader["idRequerimiento"]);
                            requerimientoGenMat.etapaProyecto = idEtapa;
                            requerimientoGenMat.nombreEtapa = dataReader["nombreEtapa"].ToString();
                            requerimientoGenMat.claveEtapa = dataReader["claveEtapa"].ToString();
                            requerimientoGenMat.folioRequerimiento = dataReader["folioRequerimiento"].ToString();
                            requerimientoGenMat.solicitado = string.Format("{0} {1} {2}",
                                                                dataReader["nombreUsuario"].ToString(),
                                                                dataReader["apePaternoUsuario"].ToString(),
                                                                dataReader["apeMaternoUsuario"].ToString());
                            requerimientoGenMat.revisionProyecto = dataReader["revisionProyecto"].ToString();
                            requerimientoGenMat.departamentoP = dataReader["nombreDepartamento"].ToString();
                            requerimientoGenMat.fechaSolicitud = dataReader["fechaSolicitud"].ToString();
                            requerimientoGenMat.lstDetalle = new List<DetalleReqGenMat>();
                        }

                        requerimientoGenMat.lstDetalle.Add(new DetalleReqGenMat()
                        {
                            numRenglon = Convert.ToInt32(dataReader["numeroRenglon"]),
                            perfilReqGenMat = dataReader["perfilDetalleReq"].ToString(),
                            piezasReqGenMat = Convert.ToInt32(dataReader["piezasDetalleReq"]),
                            corteReqGenMat = Convert.ToDouble(dataReader["cortesDetalleReq"]),
                            longitudReqGenMat = Convert.ToDouble(dataReader["logitudDetalleReq"]),
                            anchoReqGenMat = Convert.ToDouble(dataReader["anchoDetalleReq"]),
                            gradoReqGenMat= dataReader["gradoDetalleReq"].ToString(),
                            kgmReqGenMat = Convert.ToDouble(dataReader["kgmDetalleReq"]),
                            totalLAReqGenMat= Convert.ToDouble(dataReader["totalLADetalleReq"]),
                            pesoReqGenMat = Convert.ToDouble(dataReader["pesoDetalleReq"]),
                            areaReqGenMat= Convert.ToDouble(dataReader["areaDetalleReq"]),                            
                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }

            return requerimientoGenMat;
        }                
    }
}
