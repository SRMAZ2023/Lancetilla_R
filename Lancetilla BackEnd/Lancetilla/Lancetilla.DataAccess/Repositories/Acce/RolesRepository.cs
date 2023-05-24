using Dapper;
using Lancetilla.Entities.Entities;
using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Lancetilla.DataAccess.Repositories.Acce
{
    public class RolesRepository : IRepository<tbRoles>
    {

        Lancetilla con = new Lancetilla();
        public IEnumerable<VW_tbRoles> ListarRoles()
        {
            return con.VW_tbRoles.AsList();
        }

        public RequestStatus Delete(tbRoles item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@role_Id", item.role_Id, DbType.Int32, ParameterDirection.Input);
           
            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.EliminarRol, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }

        public tbRoles Find(int? id)
        {
            throw new NotImplementedException();
        }

       

        public RequestStatus Insert(tbRoles item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();


            parametros.Add("@role_Descripcion", item.role_Descripcion, DbType.String, ParameterDirection.Input);
            parametros.Add("@role_UserCreacion", item.role_UserCreacion, DbType.Int32, ParameterDirection.Input);
           

            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.InsertarRol, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }

        public RequestStatus Update(tbRoles item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();


            parametros.Add("@role_Id", item.role_Id, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@role_Descripcion", item.role_Descripcion, DbType.String, ParameterDirection.Input);
            parametros.Add("@role_UserModificacion", item.role_UserModificacion, DbType.Int32, ParameterDirection.Input);


            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.ActualizarRol, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }

        public IEnumerable<tbRoles> List()
        {
            throw new NotImplementedException();
        }

        public RequestStatus Update(tbRoles item, int id)
        {
            throw new NotImplementedException();
        }
    }
}
