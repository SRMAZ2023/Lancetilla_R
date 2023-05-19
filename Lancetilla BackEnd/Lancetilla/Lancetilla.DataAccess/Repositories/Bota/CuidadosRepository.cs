using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dapper;
using Lancetilla.Entities.Entities;

namespace Lancetilla.DataAccess.Repositories.Bota
{
    public class CuidadosRepository : IRepository<tbCuidados>
    {

        Lancetilla con = new Lancetilla();
        public IEnumerable<VW_tbCuidados> ListarCuidadosDePlantas()
        {
            return con.VW_tbCuidados.AsList();
        }

        public RequestStatus Delete(tbCuidados item)
        {
            throw new NotImplementedException();
        }

        public tbCuidados Find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tbCuidados item)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<tbCuidados> List()
        {
            throw new NotImplementedException();
        }

        public RequestStatus Update(tbCuidados item, int id)
        {
            throw new NotImplementedException();
        }
    }
}
