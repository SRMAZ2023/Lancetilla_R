using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dapper;
using Lancetilla.Entities.Entities;

namespace Lancetilla.DataAccess.Repositories.Mant
{
    public class MantenimientosRepository : IRepository<tbMantenimientos>
    {

        Lancetilla con = new Lancetilla();
        public IEnumerable<VW_tbMantenimientos> ListarDepartamentos()
        {
            return con.VW_tbMantenimientos.AsList();
        }
        public RequestStatus Delete(tbMantenimientos item)
        {
            throw new NotImplementedException();
        }

        public tbMantenimientos Find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tbMantenimientos item)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<tbMantenimientos> List()
        {
            throw new NotImplementedException();
        }

        public RequestStatus Update(tbMantenimientos item, int id)
        {
            throw new NotImplementedException();
        }
    }
}
