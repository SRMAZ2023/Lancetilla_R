using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dapper;
using Lancetilla.Entities.Entities;

namespace Lancetilla.DataAccess.Repositories.Zool
{
    public class EspeciesRepository : IRepository<tbEspecies>
    {

        Lancetilla con = new Lancetilla();
        public IEnumerable<VW_tbEspecies> ListarDepartamentos()
        {
            return con.VW_tbEspecies.AsList();
        }
        public RequestStatus Delete(tbEspecies item)
        {
            throw new NotImplementedException();
        }

        public tbEspecies Find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tbEspecies item)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<tbEspecies> List()
        {
            throw new NotImplementedException();
        }

        public RequestStatus Update(tbEspecies item, int id)
        {
            throw new NotImplementedException();
        }
    }
}
