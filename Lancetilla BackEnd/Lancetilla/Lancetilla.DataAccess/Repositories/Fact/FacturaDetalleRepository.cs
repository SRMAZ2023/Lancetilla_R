using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dapper;
using Lancetilla.Entities.Entities;

namespace Lancetilla.DataAccess.Repositories.Fact
{
    public class FacturaDetalleRepository : IRepository<tbFacturasDetalles>
    {

        Lancetilla con = new Lancetilla();
        public IEnumerable<VW_FacturasDetalle> ListarFacturasDetalles()
        {
            return con.VW_FacturasDetalle.AsList();
        }
        public RequestStatus Delete(tbFacturasDetalles item)
        {
            throw new NotImplementedException();
        }

        public tbFacturasDetalles Find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tbFacturasDetalles item)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<tbFacturasDetalles> List()
        {
            throw new NotImplementedException();
        }

        public RequestStatus Update(tbFacturasDetalles item, int id)
        {
            throw new NotImplementedException();
        }
    }
}
