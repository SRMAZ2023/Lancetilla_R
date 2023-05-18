using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dapper;
using Lancetilla.Entities.Entities;

namespace Lancetilla.DataAccess.Repositories.Mant
{
    public class CargosRepository : IRepository<tbCargos>
    {
        Lancetilla con = new Lancetilla();
        public IEnumerable<VW_tbCargos> ListarCargos()
        {
            return con.VW_tbCargos.AsList();
        }
        public RequestStatus Delete(tbCargos item)
        {
            throw new NotImplementedException();
        }

        public tbCargos Find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tbCargos item)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<tbCargos> List()
        {
            throw new NotImplementedException();
        }

        public RequestStatus Update(tbCargos item, int id)
        {
            throw new NotImplementedException();
        }
    }
}
