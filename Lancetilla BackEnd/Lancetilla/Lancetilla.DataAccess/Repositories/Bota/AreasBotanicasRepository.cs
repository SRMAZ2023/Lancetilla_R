using Dapper;
using Lancetilla.Entities.Entities;
using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Lancetilla.DataAccess.Repositories.Bota
{
    public class AreasBotanicasRepository : IRepository<tbAreasBotanicas>
    {

        Lancetilla con = new Lancetilla();
        public IEnumerable<VW_tbAreasBotanicas> ListarAreasBotanicas()
        {
            return con.VW_tbAreasBotanicas.AsList();
        }
        public RequestStatus Delete(tbAreasBotanicas item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@arbo_Id", item.arbo_Id, DbType.Int32, ParameterDirection.Input);
          
            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.EliminarAreaBotanica, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }
        public RequestStatus Insert(tbAreasBotanicas item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@arbo_Descripcion", item.arbo_Descripcion, DbType.String, ParameterDirection.Input);
            parametros.Add("@arbo_UserCreacion", item.arbo_UserCreacion, DbType.Int32, ParameterDirection.Input);
           
            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.InsertarAreaBotanica, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }

        public RequestStatus Update(tbAreasBotanicas item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@arbo_Id", item.arbo_Id, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@arbo_Descripcion", item.arbo_Descripcion, DbType.String, ParameterDirection.Input);
            parametros.Add("@arbo_UserModificacion", item.arbo_UserModificacion, DbType.Int32, ParameterDirection.Input);

            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.ActualizarAreaBotanica, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }

        public tbAreasBotanicas Find(int? id)
        {
            throw new NotImplementedException();
        }

      

        public IEnumerable<tbAreasBotanicas> List()
        {
            throw new NotImplementedException();
        }

        public RequestStatus Update(tbAreasBotanicas item, int id)
        {
            throw new NotImplementedException();
        }
    }
}
