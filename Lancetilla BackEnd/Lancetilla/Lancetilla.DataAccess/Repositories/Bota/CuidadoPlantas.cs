using System;
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
    public class CuidadoPlantas : IRepository<tbCuidadoPlanta>
    {

        Lancetilla con = new Lancetilla();
        public IEnumerable<VW_tbCuidadoPlanta> ListarCuidados()
        {
            return con.VW_tbCuidadoPlanta.AsList();
        }

        public RequestStatus Delete(tbCuidadoPlanta item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@cupl_Id", item.cupl_Id, DbType.Int32, ParameterDirection.Input);

            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.tbCuidadoPlanta_DELETE, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }

        public IEnumerable<VW_tbCuidadoPlanta> Find2(int? id)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@arbo", id, DbType.Int32, ParameterDirection.Input);
            return db.Query<VW_tbCuidadoPlanta>(ScriptsDataBase.tbCuidadoPlanta_FINDArea, parametros, commandType: CommandType.StoredProcedure);

        }


        public tbCuidadoPlanta Find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tbCuidadoPlanta item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@plan_Id", item.plan_Id, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@ticu_Id", item.ticu_Id, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@cupl_Fecha", item.cupl_Fecha, DbType.String, ParameterDirection.Input);
            parametros.Add("@cupl_UserCreacion", item.cupl_UserCreacion, DbType.Int32, ParameterDirection.Input);

            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.tbCuidadoPlanta_CREATE, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }

        public RequestStatus Update(tbCuidadoPlanta item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@@cupl_Id", item.@cupl_Id, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@plan_Id", item.plan_Id, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@ticu_Id", item.ticu_Id, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@cupl_Fecha", item.cupl_Fecha, DbType.String, ParameterDirection.Input);
            parametros.Add("@cupl_UserCreacion", item.cupl_UserCreacion, DbType.Int32, ParameterDirection.Input);

            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.tbCuidadoPlanta_UPDATE, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }

        public IEnumerable<tbCuidadoPlanta> List()
        {
            throw new NotImplementedException();
        }

        public RequestStatus Update(tbCuidadoPlanta item, int id)
        {
            throw new NotImplementedException();
        }
    }
}
