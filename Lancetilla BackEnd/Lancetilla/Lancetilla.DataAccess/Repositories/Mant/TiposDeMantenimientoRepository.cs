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
    public class TiposDeMantenimientoRepository : IRepository<tbTiposMantenimientos>
    {

        Lancetilla con = new Lancetilla();
        public IEnumerable<VW_tbTiposMantenimientos> ListarTiposDeMantenimientos()
        {
            return con.VW_tbTiposMantenimientos.AsList();
        }
        public RequestStatus Delete(tbTiposMantenimientos item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@tima_Id", item.tima_Id, DbType.Int32, ParameterDirection.Input);
        
            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.EliminarTiposDeMantenimiento, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }
        public tbTiposMantenimientos Find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tbTiposMantenimientos item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@tima_Descripcion", item.tima_Descripcion, DbType.String, ParameterDirection.Input);
            parametros.Add("@tima_UserCreacion", item.tima_UserCreacion, DbType.Int32, ParameterDirection.Input);
          


            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.InsertarTiposDeMantenimiento, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }


        public RequestStatus Update(tbTiposMantenimientos item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@tima_Id", item.tima_Id, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@tima_Descripcion", item.tima_Descripcion, DbType.String, ParameterDirection.Input);
            parametros.Add("@tima_UserModificacion", item.tima_UserModificacion, DbType.Int32, ParameterDirection.Input);



            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.ActualizarTiposDeMantenimiento, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }

        public IEnumerable<tbTiposMantenimientos> List()
        {
            throw new NotImplementedException();
        }

        public RequestStatus Update(tbTiposMantenimientos item, int id)
        {
            throw new NotImplementedException();
        }
    }
}
