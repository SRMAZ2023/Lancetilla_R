using Dapper;
using Lancetilla.Entities.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Lancetilla.DataAccess.Repositories.Zool
{
    public class ReinosRepository : IRepository<tbReinos>
    {
        public RequestStatus Delete(tbReinos item)
        {
            throw new NotImplementedException();
        }

        public tbReinos Find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tbReinos item)
        {
            throw new NotImplementedException();
        }

        Lancetilla con = new Lancetilla();
        public IEnumerable<VW_tbReinos> ListarReinos()
        {
            return con.VW_tbReinos.AsList();
        }

        public RequestStatus Update(tbReinos item, int id)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<tbReinos> List()
        {
            throw new NotImplementedException();
        }
    }
}
