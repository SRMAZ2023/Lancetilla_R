
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
    public class TiposCuidados : IRepository<tbTiposCuidados>
    {
        Lancetilla con = new Lancetilla();
        public IEnumerable<VW_tbTiposCuidados> ListarTiposCuidados()
        {
            return con.VW_tbTiposCuidados.AsList();
        }

        public RequestStatus Delete(tbTiposCuidados item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@ticu_Id", item.ticu_Id, DbType.Int32, ParameterDirection.Input);

            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.tbTiposCuidados_DELETE, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }

        

        public RequestStatus Insert(tbTiposCuidados item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@ticu_Descripcion", item.ticu_Descripcion, DbType.String, ParameterDirection.Input);
            parametros.Add("@ticu_UserCreacion", item.ticu_UserCreacion, DbType.Int32, ParameterDirection.Input);

            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.tbTiposCuidados_CREATE, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }

        public IEnumerable<tbTiposCuidados> List()
        {
            throw new NotImplementedException();
        }



        public RequestStatus Update(tbTiposCuidados item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@ticu_Id", item.ticu_Id, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@ticu_Descripcion", item.ticu_Descripcion, DbType.String, ParameterDirection.Input);
            parametros.Add("@ticu_UserCreacion", item.ticu_UserCreacion, DbType.Int32, ParameterDirection.Input);

            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.tbTiposCuidados_UPDATE, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;

        }

        tbTiposCuidados IRepository<tbTiposCuidados>.Find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Update(tbTiposCuidados item, int id)
        {
            throw new NotImplementedException();
        }
    }
}