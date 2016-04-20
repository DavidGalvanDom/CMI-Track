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
        /// Se da un Avance a un elemento
        /// </summary>
        /// <param name="pobjModelo"></param>
        /// <returns>value</returns>
        public static string DarAvance(Models.Avance pobjModelo)
        {
            object[] paramArray = new object[4];
            try
            {
                paramArray[0] = pobjModelo.claseAvance.ToUpper();
                paramArray[1] = pobjModelo.idMarca_Submarca;
                paramArray[2] = pobjModelo.idSerie;
                paramArray[3] = pobjModelo.idUsuario;
                
                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteScalar("usp_DarAvance", paramArray);
                
                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }

        /// <summary>
        /// Se da un Avance a un elemento
        /// </summary>
        /// <param name="pobjModelo"></param>
        /// <returns>value</returns>
        public static string DarRegistroCalidad(Models.RegistroCalidad pobjModelo)
        {
            object[] paramArray = new object[11];
            try
            {
                paramArray[0] = pobjModelo.claseRegistro.ToUpper();
                paramArray[1] = pobjModelo.idMarca_Submarca;
                paramArray[2] = pobjModelo.idSerie;
                paramArray[3] = pobjModelo.idUsuario;
                paramArray[4] = (pobjModelo.observacionesRegistroCalidad == null ? "" : pobjModelo.observacionesRegistroCalidad.ToUpper());
                paramArray[5] = pobjModelo.idEstatus;
                paramArray[6] = pobjModelo.bLongitud;
                paramArray[7] = pobjModelo.bBarrenacion;
                paramArray[8] = pobjModelo.bPlaca;
                paramArray[9] = pobjModelo.bSoldadura;
                paramArray[10] = pobjModelo.bPintura;

                var db = DatabaseFactory.CreateDatabase("SQLStringConn");
                var result = db.ExecuteScalar("usp_DarRegistroCalidad", paramArray);

                return (result.ToString());
            }
            catch (Exception exp)
            {
                throw new ApplicationException(exp.Message, exp);
            }
        }
    }
}
