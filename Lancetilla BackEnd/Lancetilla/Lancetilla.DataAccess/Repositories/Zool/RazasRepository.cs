using Dapper;
using Lancetilla.Entities.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Lancetilla.DataAccess.Repositories.Zool
{
    public class RazasRepository : IRepository<tbRazas>
    {
        Lancetilla con = new Lancetilla();
        public IEnumerable<VW_tbRazas> ListarRazas()
        {
            return con.VW_tbRazas.AsList();
        }
        public RequestStatus Delete(tbRazas item)
        {
            throw new NotImplementedException();
        }

        public tbRazas Find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tbRazas item)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<tbRazas> List()
        {
            throw new NotImplementedException();
        }

        public RequestStatus Update(tbRazas item, int id)
        {
            throw new NotImplementedException();
        }
    }
}
