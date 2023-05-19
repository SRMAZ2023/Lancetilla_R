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
    public class TicketsRepository : IRepository<tbTickets>
    {

        Lancetilla con = new Lancetilla();
        public IEnumerable<VW_tbTickets> ListarTickets()
        {
            return con.VW_tbTickets.AsList();
        }
        public RequestStatus Delete(tbTickets item)
        {
            throw new NotImplementedException();
        }

        public tbTickets Find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tbTickets item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@tick_Descripcion", item.tick_Descripcion, DbType.String, ParameterDirection.Input);
            parametros.Add("@tick_Precio", item.tick_Precio, DbType.Decimal, ParameterDirection.Input);
            parametros.Add("@tick_UserCreacion", item.tick_UserCreacion, DbType.Int32, ParameterDirection.Input);
           

            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.InsertarTicket, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }

       

        public IEnumerable<tbTickets> List()
        {
            throw new NotImplementedException();
        }

        public RequestStatus Update(tbTickets item, int id)
        {
            throw new NotImplementedException();
        }
    }
}
