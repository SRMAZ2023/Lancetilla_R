using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dapper;
using Lancetilla.Entities.Entities;

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
            throw new NotImplementedException();
        }

        public tbMetodosPago Find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tbMetodosPago item)
        {
            throw new NotImplementedException();
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
