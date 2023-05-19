using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dapper;
using Lancetilla.Entities.Entities;
using Microsoft.Data.SqlClient;

namespace Lancetilla.DataAccess.Repositories.Fact
{
    public class MetodoDePagoRepository : IRepository<tbMetodosPago>
    {
        Lancetilla con = new Lancetilla();
        public IEnumerable<VW_tbMetodosPago> ListarMetodosDePago()
        {
            return con.VW_tbMetodosPago.AsList();
        }
        public RequestStatus Delete(tbMetodosPago item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@meto_Id", item.meto_Id, DbType.Int32, ParameterDirection.Input);

            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.EliminarMetodoDePago, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }
        public tbMetodosPago Find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tbMetodosPago item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@meto_Descripcion", item.meto_Descripcion, DbType.String, ParameterDirection.Input);
          
            parametros.Add("@meto_UserCreacion", item.meto_UserCreacion, DbType.Int32, ParameterDirection.Input);


            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.InsertarMetodoDePago, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }

        public RequestStatus Update(tbMetodosPago item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();
            
            parametros.Add("@meto_Id", item.meto_Id, DbType.Int32, ParameterDirection.Input);


            parametros.Add("@meto_Descripcion", item.meto_Descripcion, DbType.String, ParameterDirection.Input);

            parametros.Add("@meto_UserModificacion", item.meto_UserModificacion, DbType.Int32, ParameterDirection.Input);


            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.ActualizarMetodoDePago, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }
        public IEnumerable<tbMetodosPago> List()
        {
            throw new NotImplementedException();
        }

        public RequestStatus Update(tbMetodosPago item, int id)
        {
            throw new NotImplementedException();
        }
    }
}
