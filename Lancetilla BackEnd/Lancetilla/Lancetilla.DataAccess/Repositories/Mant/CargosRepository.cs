using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dapper;
using Lancetilla.Entities.Entities;
using Microsoft.Data.SqlClient;

namespace Lancetilla.DataAccess.Repositories.Mant
{
    public class CargosRepository : IRepository<tbCargos>
    {
        Lancetilla con = new Lancetilla();
        public IEnumerable<VW_tbCargos> ListarCargos()
        {
            return con.VW_tbCargos.AsList();
        }
        public RequestStatus Delete(tbCargos item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@carg_Id", item.carg_Id, DbType.String, ParameterDirection.Input);
           

            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.EliminarCargos, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }

        public tbCargos Find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tbCargos item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();


            parametros.Add("@carg_Descripcion", item.carg_Descripcion, DbType.String, ParameterDirection.Input);
            parametros.Add("@carg_UserCreacion", item.carg_UserCreacion, DbType.Int32, ParameterDirection.Input);

            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.InsertarCargos, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }

        public RequestStatus Update(tbCargos item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@carg_Id", item.carg_Id, DbType.String, ParameterDirection.Input);
            parametros.Add("@carg_Descripcion", item.carg_Descripcion, DbType.String, ParameterDirection.Input);
            parametros.Add("@carg_UserModificacion", item.carg_UserModificacion, DbType.Int32, ParameterDirection.Input);

            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.ActualizarCargos, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }
        public IEnumerable<tbCargos> List()
        {
            throw new NotImplementedException();
        }

        public RequestStatus Update(tbCargos item, int id)
        {
            throw new NotImplementedException();
        }
    }
}
