using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dapper;
using Lancetilla.Entities.Entities;

namespace Lancetilla.DataAccess.Repositories.Mant
{
    public class TiposDeMantenimientoRepository : IRepository<tbTiposMantenimientos>
    {

        Lancetilla con = new Lancetilla();
        public IEnumerable<VW_tbTiposMantenimientos> ListarDepartamentos()
        {
            return con.VW_tbTiposMantenimientos.AsList();
        }
        public RequestStatus Delete(tbTiposMantenimientos item)
        {
            throw new NotImplementedException();
        }

        public tbTiposMantenimientos Find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tbTiposMantenimientos item)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<tbTiposMantenimientos> List()
        {
            throw new NotImplementedException();
        }

        public RequestStatus Update(tbTiposMantenimientos item, int id)
        {
            throw new NotImplementedException();
        }
    }
}
