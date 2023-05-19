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
    public class RolesPorPantallaRepository : IRepository<tbRolesPantallas>
    {
       

        public tbRolesPantallas Find(int? id)
        {
            throw new NotImplementedException();
        }

       
        public RequestStatus Insert(tbRolesPantallas item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();


            parametros.Add("@pant_Id", item.pant_Id, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@role_Id", item.role_Id, DbType.Int32, ParameterDirection.Input);
 
            parametros.Add("@ropa_UserCreacion", item.ropa_UserCreacion, DbType.Int32, ParameterDirection.Input);

            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.InsertarRolPorPantalla, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }

        public IEnumerable<tbRolesPantallas> PantallasPorRol(tbRolesPantallas item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

           
            parametros.Add("@role_Id", item.role_Id, DbType.Int32, ParameterDirection.Input);

            var result = db.Query<tbRolesPantallas>(ScriptsDataBase.PantallasRolPorPantalla, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }

        public RequestStatus Delete(tbRolesPantallas item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@pant_Id", item.pant_Id, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@role_Id", item.role_Id, DbType.Int32, ParameterDirection.Input);
          
            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.InsertarUsuarios, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }

        public IEnumerable<tbRolesPantallas> List()
        {
            throw new NotImplementedException();
        }

        public RequestStatus Update(tbRolesPantallas item, int id)
        {
            throw new NotImplementedException();
        }
    }
}
