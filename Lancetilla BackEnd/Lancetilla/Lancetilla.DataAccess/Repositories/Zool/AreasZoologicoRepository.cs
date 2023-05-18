using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dapper;
using Lancetilla.Entities.Entities;

namespace Lancetilla.DataAccess.Repositories.Zool
{
    public class AreasZoologicoRepository : IRepository<tbAreasZoologico>
    {

        Lancetilla con = new Lancetilla();
        public IEnumerable<VW_tbAreasZoologico> ListarDepartamentos()
        {
            return con.VW_tbAreasZoologico.AsList();
        }
        public RequestStatus Delete(tbAreasZoologico item)
        {
            throw new NotImplementedException();
        }

        public tbAreasZoologico Find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tbAreasZoologico item)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<tbAreasZoologico> List()
        {
            throw new NotImplementedException();
        }

        public RequestStatus Update(tbAreasZoologico item, int id)
        {
            throw new NotImplementedException();
        }
    }
}
