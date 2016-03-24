///Propósito: Acceso a base de datos Carga de Lista general de parte
///Fecha creación: 21/Marzo/2016
///Creador: David Galvan
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
    public class ListaGeneralData
    {
        /// <summary>
        /// Se carga el listado de Planos Despiece
        /// </summary>
        /// <param name="idPlanoMontaje"></param>
        /// <param name="idEstatus"></param>
        /// <returns>Lista de Etapas</returns>
        public static void GuardarInformacion(int idProyecto, int idEtapa, 
                                                List<LGMMarcas> lstLGMMarcas, int idUsuario)
        {   
            try
            {
                var db = DatabaseFactory.CreateDatabase("SQLStringConn");

                using (DbConnection conn = db.CreateConnection())
                {
                    conn.Open();
                    DbTransaction trans = conn.BeginTransaction();
                    try
                    {
                        //Se insertan primero todas las marcas.
                        foreach (var marca in lstLGMMarcas)
                        {
                            var cmdMarca = db.GetSqlStringCommand(@"
                                                INSERT INTO [cmiMarcas] 
                                                            ([idPlanoDespiece],[codigoMarca] ,[nombreMarca] ,[piezasMarca] ,[pesoMarca] ,[idEstatus] ,
                                                                [usuarioCreacion]  ,[fechaCreacion],[fechaUltModificacion]) 
                                                OUTPUT INSERTED.IdMarca
                                                VALUES (@idPlanoDespiece, @codigoMarca,@codigoMarca,@piezas,0,1,@usuarioCreacion,GETDATE(),GETDATE()) ");
                            
                            db.AddInParameter(cmdMarca,"@idPlanoDespiece",DbType.Int32,marca.idPlanoDespiece);
                            db.AddInParameter(cmdMarca,"@codigoMarca",DbType.String,marca.codigoMarca);
                            db.AddInParameter(cmdMarca,"@piezas",DbType.Double,marca.piezas);
                            db.AddInParameter(cmdMarca,"@usuarioCreacion",DbType.Int32,idUsuario);

                            // Datos de la marca
                            var idMarca =  db.ExecuteScalar(cmdMarca, trans);

                            marca.id = Convert.ToInt32(idMarca);
                            
                            var cmdSeries = db.GetStoredProcCommand(@"usp_InsertarSeries");

                            db.AddInParameter(cmdSeries, "@idMarca", DbType.Int32, marca.id);
                            db.AddInParameter(cmdSeries, "@numPiezas", DbType.Int32, marca.piezas);
                            db.AddInParameter(cmdSeries, "@idEstatus", DbType.Int32, 1);
                            db.AddInParameter(cmdSeries, "@idUsuarioCreacion", DbType.Int32, idUsuario);

                            db.ExecuteNonQuery(cmdSeries, trans);

                            //Se insertan las submarcas 
                            foreach (var subMarca in marca.listaSubMarcas)
                            {
                                var cmdSubMarca = db.GetSqlStringCommand(@"
                                            INSERT INTO [cmiSubMarcas] 
                                            ([idMarca],[perfilSubMarca],[piezasSubMarca],[corteSubMarca],[longitudSubMarca],[anchoSubMarca]
                                            ,[gradoSubMarca],[kgmSubMarca],[totalLASubMarca],[pesoSubMarca],[codigoSubMarca],[claseSubMarca]
                                            ,[totalSubMarca],[idOrdenProduccion],[alturaSubMarca],[idEstatus],[usuarioCreacion],[fechaCreacion]
                                            ,[fechaUltModificacion])                                                
                                            VALUES (@idMarca, @perfil,@piezas,@corte,@longitud,@ancho,
                                            @grado,@kgm, @totalLA,@peso,@codigo,@clase,
                                            @total,@idOrdenProduccion,@altura,1,@usuarioCreacion,GETDATE(),
                                            GETDATE()) ");

                                db.AddInParameter(cmdSubMarca, "@idMarca", DbType.Int32, marca.id);
                                db.AddInParameter(cmdSubMarca, "@perfil", DbType.String, subMarca.perfilSubMarca);
                                db.AddInParameter(cmdSubMarca, "@piezas", DbType.Double, subMarca.piezasSubMarcas);
                                db.AddInParameter(cmdSubMarca, "@corte", DbType.Double, subMarca.corteSubMarcas);
                                db.AddInParameter(cmdSubMarca, "@longitud", DbType.Double, subMarca.longitudSubMarcas);
                                db.AddInParameter(cmdSubMarca, "@ancho", DbType.Double, subMarca.anchoSubMarcas);
                                db.AddInParameter(cmdSubMarca, "@grado", DbType.String, subMarca.gradoSubMarcas);
                                db.AddInParameter(cmdSubMarca, "@kgm", DbType.Double, subMarca.kgmSubMarcas);
                                db.AddInParameter(cmdSubMarca, "@totalLA", DbType.Double, subMarca.totalLASubMarcas);
                                db.AddInParameter(cmdSubMarca, "@peso", DbType.Double, subMarca.pesoSubMarcas);
                                db.AddInParameter(cmdSubMarca, "@codigo", DbType.String, subMarca.codigoSubMarca);
                                db.AddInParameter(cmdSubMarca, "@clase", DbType.String, subMarca.claseSubMarca);
                                db.AddInParameter(cmdSubMarca, "@total", DbType.Double, subMarca.totalSubMarcas);
                                db.AddInParameter(cmdSubMarca, "@idOrdenProduccion", DbType.Int32, idEtapa);
                                db.AddInParameter(cmdSubMarca, "@altura", DbType.Int32, subMarca.alturaSubMarcas);
                                db.AddInParameter(cmdSubMarca, "@usuarioCreacion", DbType.Int32, idUsuario);

                                // Datos de las submarca
                                db.ExecuteNonQuery(cmdSubMarca, trans);
                            }

                        }                       

                        // Commit the transaction.
                        trans.Commit();                        
                    }
                    catch(Exception exp)
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
    }
}
