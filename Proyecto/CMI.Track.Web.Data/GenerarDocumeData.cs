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
        /// Se carga la informacion del Resumen para LGP
        /// </summary>
        /// <param name="idProyecto"></param>
        /// <param name="idEtapa"></param>
        /// <param name="idUsuario"></param>
        /// <returns></returns>
        public static List<Models.LGPResumen> CargarLGPResumen(int idProyecto, int idEtapa, int idUsuario)
        {
            var lstLGPResumen = new List<Models.LGPResumen>();
            object[] paramArray = new object[2];
            try
            {
                paramArray[0] = idEtapa;
                paramArray[1] = idUsuario;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarLGPResumen", paramArray))
                {
                    while (dataReader.Read())
                    {
                        lstLGPResumen.Add(new LGPResumen()
                        {
                            planoMontaje = dataReader["codigoPlanoMontaje"].ToString(),
                            planoDespiece = dataReader["codigoPlanoDespiece"].ToString(),
                            tipoConstruccion = dataReader["nombreTipoConstruccion"].ToString(),
                            marca = dataReader["codigoMarca"].ToString(),
                            piezaMarca = Convert.ToInt32(dataReader["piezasMarca"]),
                            peso = Convert.ToDouble(dataReader["pesoMarca"])
                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }

            return lstLGPResumen;
        }
        /// <summary>
        /// Se carga la informacion de LGP Detalle
        /// </summary>
        /// <param name="idProyecto"></param>
        /// <param name="idEtapa"></param>
        /// <param name="idUsuario"></param>
        /// <returns></returns>
        public static List<Models.LGPDetalle> CargarLGPDetalle(int idProyecto, int idEtapa, int idUsuario)
        {
            var lstLGPDetalle = new List<Models.LGPDetalle>();
            object[] paramArray = new object[2];
            try
            {
                paramArray[0] = idEtapa;
                paramArray[1] = idUsuario;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarLGPDetalle", paramArray))
                {
                    while (dataReader.Read())
                    {
                        lstLGPDetalle.Add(new LGPDetalle()
                        {
                            planoMontaje = dataReader["codigoPlanoMontaje"].ToString(),
                            planoDespiece = dataReader["codigoPlanoDespiece"].ToString(),
                            tipoConstruccion = dataReader["nombreTipoConstruccion"].ToString(),
                            marca = dataReader["codigoMarca"].ToString(),
                            piezaMarca = Convert.ToInt32(dataReader["piezasMarca"]),
                            submarca = dataReader["codigoSubMarca"].ToString(),
                            perfil = dataReader["perfilSubMarca"].ToString(),
                            piezas = Convert.ToInt32(dataReader["piezasSubMarca"]),
                            corte = Convert.ToDouble(dataReader["corteSubMarca"]),
                            longitud = Convert.ToDouble(dataReader["longitudSubMarca"]),
                            ancho = Convert.ToDouble(dataReader["anchoSubMarca"]),
                            grado = dataReader["gradoSubMarca"].ToString(),
                            kgm = Convert.ToDouble(dataReader["kgmSubMarca"]),
                            totalLA = Convert.ToDouble(dataReader["totalLASubMarca"]),
                            peso = Convert.ToDouble(dataReader["pesoSubMarca"]),
                            total = Convert.ToDouble(dataReader["totalSubMarca"])
                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }

            return lstLGPDetalle;
        }

        /// <summary>
        /// Se carga la informacion de la orden de produccion
        /// </summary>
        /// <param name="idProyecto"></param>
        /// <param name="idEtapa"></param>
        /// <param name="clase"></param>
        /// <returns></returns>
        public static List<Models.OrdenProduccion> CargarOrdenProduccion(int idProyecto, int idEtapa, string clase)
        {
            var lstOrdenProduccion = new List<Models.OrdenProduccion>();
            object[] paramArray = new object[2];
            try
            {
                paramArray[0] = idEtapa;
                paramArray[1] = clase;
               
                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarOrdenProduccion", paramArray))
                {
                    while (dataReader.Read())
                    {
                        lstOrdenProduccion.Add(new OrdenProduccion()
                        {
                            planoMontaje = dataReader["codigoPlanoMontaje"].ToString(),
                            planoDespiece = dataReader["codigoPlanoDespiece"].ToString(),
                            marca = dataReader["codigoMarca"].ToString(),
                            piezaMarca = Convert.ToInt32(dataReader["piezasMarca"]),
                            submarca = dataReader["codigoSubMarca"].ToString(),
                            perfil = dataReader["perfilSubMarca"].ToString(),
                            piezas = Convert.ToInt32(dataReader["piezasSubMarca"]),
                            corte = Convert.ToDouble(dataReader["corteSubMarca"]),
                            longitud = Convert.ToDouble(dataReader["longitudSubMarca"]),
                            ancho = Convert.ToDouble(dataReader["anchoSubMarca"]),
                            grado = dataReader["gradoSubMarca"].ToString(),
                            kgm = Convert.ToDouble(dataReader["kgmSubMarca"]),
                            totalLA = Convert.ToDouble(dataReader["totalLASubMarca"]),
                            peso = Convert.ToDouble(dataReader["pesoSubMarca"]),
                            total = Convert.ToDouble(dataReader["totalSubMarca"])
                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }

            return lstOrdenProduccion;
        }
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

        /// <summary>
        /// Se carga la informacion del Trasmital
        /// </summary>
        /// <param name="idProyecto"></param>
        /// <param name="idEtapa"></param>
        /// <param name="idUsuario"></param>
        /// <returns></returns>
        public static List<Models.Trasmital> CargarTrasmital(int idProyecto, int idEtapa, int idUsuario)
        {
            var lstTrasmital = new List<Models.Trasmital>();
            object[] paramArray = new object[2];
            try
            {
                paramArray[0] = idEtapa;
                paramArray[1] = idUsuario;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarTrasmital", paramArray))
                {
                    while (dataReader.Read())
                    {
                        lstTrasmital.Add(new Trasmital()
                        {
                            planoMontaje = dataReader["nombrePlanoMontaje"].ToString(),
                            planoDespiece = dataReader["nombrePlanoDespiece"].ToString(),
                            claveDespiece = dataReader["codigoPlanoDespiece"].ToString(),
                            claveMontaje = dataReader["codigoPlanoMontaje"].ToString()
                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }

            return lstTrasmital;
        }
    }
}
