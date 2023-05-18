using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dapper;
using Lancetilla.Entities.Entities;

namespace Lancetilla.DataAccess.Repositories.Fact
{
    public class TicketsRepository : IRepository<tbTickets>
    {

        Lancetilla con = new Lancetilla();
        public IEnumerable<VW_tbTickets> ListarDepartamentos()
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
            throw new NotImplementedException();
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
