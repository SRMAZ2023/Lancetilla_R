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
    public class MantenimientosRepository : IRepository<tbMantenimientos>
    {

        Lancetilla con = new Lancetilla();
        public IEnumerable<VW_tbMantenimientos> ListarMantenimientos()
        {
            return con.VW_tbMantenimientos.AsList();
        }
    

        public tbMantenimientos Find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tbMantenimientos item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@mant_Observaciones", item.mant_Observaciones, DbType.String, ParameterDirection.Input);
            parametros.Add("@tima_Id", item.tima_Id, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@mant_UserCreacion", item.mant_UserCreacion, DbType.Int32, ParameterDirection.Input);

            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.InsertarMantenimiento, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }

        public RequestStatus Update(tbMantenimientos item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@mant_Id", item.mant_Id, DbType.String, ParameterDirection.Input);
            parametros.Add("@mant_Observaciones", item.mant_Observaciones, DbType.String, ParameterDirection.Input);
            parametros.Add("@tima_Id", item.tima_Id, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@mant_UserModificacion", item.mant_UserModificacion, DbType.Int32, ParameterDirection.Input);

            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.ActualizarMantenimiento, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }

        public RequestStatus Delete(tbMantenimientos item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@mant_Id", item.mant_Id, DbType.Int32, ParameterDirection.Input);
        
            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.EliminarMantenimiento, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }

        public IEnumerable<tbMantenimientos> List()
        {
            throw new NotImplementedException();
        }

        public RequestStatus Update(tbMantenimientos item, int id)
        {
            throw new NotImplementedException();
        }
    }
}
