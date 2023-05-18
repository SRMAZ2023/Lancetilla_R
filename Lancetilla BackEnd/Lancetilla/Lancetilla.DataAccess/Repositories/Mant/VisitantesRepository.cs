using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dapper;
using Lancetilla.Entities.Entities;

namespace Lancetilla.DataAccess.Repositories.Mant
{
    public class VisitantesRepository : IRepository<tbVisitantes>
    {

        Lancetilla con = new Lancetilla();
        public IEnumerable<VW_tbVisitantes> ListarDepartamentos()
        {
            return con.VW_tbVisitantes.AsList();
        }
        public RequestStatus Delete(tbVisitantes item)
        {
            throw new NotImplementedException();
        }

        public tbVisitantes Find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tbVisitantes item)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<tbVisitantes> List()
        {
            throw new NotImplementedException();
        }

        public RequestStatus Update(tbVisitantes item, int id)
        {
            throw new NotImplementedException();
        }
    }
}
