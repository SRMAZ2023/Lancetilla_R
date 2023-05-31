using Dapper;
using Lancetilla.Entities.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Lancetilla.DataAccess.Repositories.Bota
{
    public class TiposdePlantasRepository : IRepository<tbTiposPlantas>
    {
        Lancetilla con = new Lancetilla();
        public IEnumerable<VW_tbTiposPlantas> ListarTiposPlantas()
        {
            return con.VW_tbTiposPlantas.AsList();
        }
        public RequestStatus Delete(tbTiposPlantas item)
        {
            throw new NotImplementedException();
        }

        public tbTiposPlantas Find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tbTiposPlantas item)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<tbTiposPlantas> List()
        {
            throw new NotImplementedException();
        }

        public RequestStatus Update(tbTiposPlantas item, int id)
        {
            throw new NotImplementedException();
        }
    }
}
