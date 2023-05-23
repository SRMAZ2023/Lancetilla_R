using Dapper;
using Lancetilla.Entities.Entities;
using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Lancetilla.DataAccess.Repositories.Zool
{
    public class HabitatRepository : IRepository<tbHabitat>
    {
        Lancetilla con = new Lancetilla();
        public IEnumerable<VW_tbHabitat> ListarHabitat()
        {
            return con.VW_tbHabitat.AsList();
        }


        public tbHabitat Find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tbHabitat item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();


            parametros.Add("@habi_Descripcion",  item.habi_Descripcion, DbType.String, ParameterDirection.Input);
            parametros.Add("@habi_UserCreacion", item.habi_UserCreacion, DbType.Int32, ParameterDirection.Input);

            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.InsertarHabitat, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }

        public RequestStatus Update(tbHabitat item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@habi_Id",               item.habi_Id, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@habi_Descripcion",      item.habi_Descripcion, DbType.String, ParameterDirection.Input);
            parametros.Add("@habi_UserModificacion", item.habi_UserModificacion, DbType.Int32, ParameterDirection.Input);

            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.ActualizarHabitat, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }

        public RequestStatus Delete(tbHabitat item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@habi_Id", item.habi_Id, DbType.String, ParameterDirection.Input);


            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.EliminacionHabitat, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }



        public IEnumerable<tbHabitat> List()
        {
            throw new NotImplementedException();
        }

        public RequestStatus Update(tbHabitat item, int id)
        {
            throw new NotImplementedException();
        }
    }
}
