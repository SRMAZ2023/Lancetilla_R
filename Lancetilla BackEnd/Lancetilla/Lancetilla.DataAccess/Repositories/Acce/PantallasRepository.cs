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
    public class PantallasRepository : IRepository<tbPantallas>
    {


        
        public RequestStatus Delete(tbPantallas item)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<tbPantallas> PantallasPorRol(tbRoles item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();
        
            parametros.Add("@role_Id", item.role_Id, DbType.Int32, ParameterDirection.Input);

            var result = db.Query<tbPantallas>(ScriptsDataBase.PantallasRolPorPantalla, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }


        public tbPantallas Find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tbPantallas item)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<tbPantallas> List()
        {
            throw new NotImplementedException();
        }

        public RequestStatus Update(tbPantallas item, int id)
        {
            throw new NotImplementedException();
        }
    }
}
