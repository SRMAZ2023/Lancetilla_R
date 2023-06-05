using System;
using System.Collections;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dapper;
using Lancetilla.Entities.Entities;
using Microsoft.Data.SqlClient;

namespace Lancetilla.DataAccess.Repositories.Bota
{
    public class CuidadosRepository : IRepository<tbCuidados>
    {

        Lancetilla con = new Lancetilla();
        public IEnumerable<VW_tbCuidados> ListarCuidados()
        {
            return con.VW_tbCuidados.AsList();
        }

        public IEnumerable MantenimientoPorAnimal()
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            return db.Query(ScriptsDataBase.Grafica, null, commandType: System.Data.CommandType.StoredProcedure);
        }
        public IEnumerable CuidadoPorPlanta()
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            return db.Query(ScriptsDataBase.Grafica2, null, commandType: System.Data.CommandType.StoredProcedure);
        }

        public RequestStatus Delete(tbCuidados item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@cuid_Id", item.cuid_Id, DbType.Int32, ParameterDirection.Input);
          
            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.EliminarCuidados, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }


        public tbCuidados Find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tbCuidados item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@cuid_Observacion", item.cuid_Observacion, DbType.String, ParameterDirection.Input);
            parametros.Add("@ticu_Id", item.ticu_Id, DbType.String, ParameterDirection.Input);
            parametros.Add("@cuid_UserCreacion", item.cuid_UserCreacion, DbType.Int32, ParameterDirection.Input);

            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.InsertarCuidados, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }

        public RequestStatus Update(tbCuidados item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@cuid_Id", item.cuid_Id, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@cuid_Observacion", item.cuid_Observacion, DbType.String, ParameterDirection.Input);
            parametros.Add("@ticu_Id", item.ticu_Id, DbType.String, ParameterDirection.Input);
            parametros.Add("@cuid_UserModificacion", item.cuid_UserModificacion, DbType.Int32, ParameterDirection.Input);

            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.ActualizarCuidados, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }

        public IEnumerable<tbCuidados> List()
        {
            throw new NotImplementedException();
        }

        public RequestStatus Update(tbCuidados item, int id)
        {
            throw new NotImplementedException();
        }
    }
}
