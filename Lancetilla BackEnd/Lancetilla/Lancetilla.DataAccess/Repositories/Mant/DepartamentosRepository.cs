using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dapper;
using Lancetilla.Entities.Entities;

namespace Lancetilla.DataAccess.Repositories.Mant
{
    public class DepartamentosRepository : IRepository<tbDepartamentos>
    {

        Lancetilla con = new Lancetilla();
        public IEnumerable<VW_tbDepartamentos> ListarDepartamentos()
        {
            return con.VW_tbDepartamentos.AsList();
        }

        public RequestStatus Delete(tbDepartamentos item)
        {
            throw new NotImplementedException();
        }

        public tbDepartamentos Find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tbDepartamentos item)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<tbDepartamentos> List()
        {
            throw new NotImplementedException();
        }

        public RequestStatus Update(tbDepartamentos item, int id)
        {
            throw new NotImplementedException();
        }
    }
}
