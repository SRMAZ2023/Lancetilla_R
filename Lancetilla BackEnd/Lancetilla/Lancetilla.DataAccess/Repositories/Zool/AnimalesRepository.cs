using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dapper;
using Lancetilla.Entities.Entities;

namespace Lancetilla.DataAccess.Repositories.Zool
{
    public class AnimalesRepository : IRepository<tbAnimales>
    {

        Lancetilla con = new Lancetilla();
        public IEnumerable<VW_tbAnimales> ListarAnimales()
        {
            return con.VW_tbAnimales.AsList();
        }
        public RequestStatus Delete(tbAnimales item)
        {
            throw new NotImplementedException();
        }

        public tbAnimales Find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tbAnimales item)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<tbAnimales> List()
        {
            throw new NotImplementedException();
        }

        public RequestStatus Update(tbAnimales item, int id)
        {
            throw new NotImplementedException();
        }
    }
}
