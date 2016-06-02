///Propósito: Acceso a base de datos Avance
///Fecha creación: 25/Febrero/2016
///Creador: Juan Lopepe
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
    public  class AvanceData
    {

        /// <summary>
        /// Se carga el Avance
        /// </summary>
        /// <returns>Listado del Elementos</returns>
        public static List<Models.ListaAvance> CargarAvance(int idEtapa, int idProceso, string codigoBarras)
        {
            var lstAvance = new List<Models.ListaAvance>();
            object[] paramArray = new object[3];
            try
            {
                paramArray[0] = idEtapa;
                paramArray[1] = idProceso;
                paramArray[2] = codigoBarras;
                
                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarAvance", paramArray))
                {
                    while (dataReader.Read())
                    {
                        lstAvance.Add(new Models.ListaAvance()
                        {
                            id              = Convert.ToString(dataReader["id"]),
                            codigoBarra     = Convert.ToString(dataReader["codigoBarras"]),
                            tipo            = Convert.ToString(dataReader["tipo"]),
                            perfil          = Convert.ToString(dataReader["perfil"]),
                            clase           = Convert.ToString(dataReader["clase"]),
                            estatusCalidad  = (dataReader["estatusCalidad"].Equals("RECHAZADO") ? "<b>RECHAZADO</b>" : Convert.ToString(dataReader["estatusCalidad"])),
                            procesoActual   = Convert.ToString(dataReader["procesoActual"]),
                            link            = "<a href='#' class='btn btn-info btn-xs btnInfo-DarAvance" + (dataReader["estatusCalidad"].Equals("RECHAZADO") ? " disabled " : "") + "' data-id='" + dataReader["id"] + "'>Dar Avance</a>"
                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
            return lstAvance;
        }

        /// <summary>
        /// Se carga la Revision
        /// </summary>
        /// <returns>Listado del Elementos</returns>
        public static List<Models.ListaAvance> CargarRevision(int idEtapa, int idProceso, string codigoBarras)
        {
            var lstAvance = new List<Models.ListaAvance>();
            object[] paramArray = new object[3];
            try
            {
                paramArray[0] = idEtapa;
                paramArray[1] = idProceso;
                paramArray[2] = codigoBarras;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (IDataReader dataReader = db.ExecuteReader("usp_CargarAvance", paramArray))
                {
                    while (dataReader.Read())
                    {
                        lstAvance.Add(new Models.ListaAvance()
                        {
                            id = Convert.ToString(dataReader["id"]),
                            codigoBarra = Convert.ToString(dataReader["codigoBarras"]),
                            tipo = Convert.ToString(dataReader["tipo"]),
                            perfil = Convert.ToString(dataReader["perfil"]),
                            clase = Convert.ToString(dataReader["clase"]),
                            estatusCalidad = (dataReader["estatusCalidad"].Equals("RECHAZADO") ? "<b>RECHAZADO</b>" : Convert.ToString(dataReader["estatusCalidad"])),
                            procesoActual = Convert.ToString(dataReader["procesoActual"]),
                            link = "<a href='#' class='btn btn-info btn-xs btnInfo-DarRevision ' data-id='" + dataReader["id"] + "'>Revision</a>"
                        });
                    }
                }
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
            return lstAvance;
        }

        /// <summary>
        /// Se da un Avance o registro de calidad a un elemento
        /// </summary>
        /// <param name="pobjModelo"></param>
        /// <returns>value</returns>
        public static string InsertarActividadProduccion(Models.ActividadProduccion pobjModelo)
        {
            object[] paramArray = new object[15];
            try
            {
                pobjModelo.piezas = (pobjModelo.piezas == null ? 1 : pobjModelo.piezas);
                pobjModelo.piezas = (pobjModelo.piezas == 0 ? 1 : pobjModelo.piezas);

                paramArray[0] = pobjModelo.tipo.ToUpper();
                paramArray[1] = pobjModelo.clase.ToUpper();
                paramArray[2] = pobjModelo.idSubmarca;
                paramArray[3] = pobjModelo.idMarca;
                paramArray[4] = pobjModelo.idSerie;
                paramArray[5] = pobjModelo.piezas;
                paramArray[6] = pobjModelo.idUsuarioFabrico;
                paramArray[7] = pobjModelo.idEstatus_Calidad;
                paramArray[8] = pobjModelo.observaciones;
                paramArray[9] = pobjModelo.longitud;
                paramArray[10] = pobjModelo.barrenacion;
                paramArray[11] = pobjModelo.placa;
                paramArray[12] = pobjModelo.soldadura;
                paramArray[13] = pobjModelo.pintura;
                paramArray[14] = pobjModelo.usuarioCreacion;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteScalar("usp_InsertarActividadProduccion", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }
    }
}
