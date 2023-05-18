using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dapper;
using Lancetilla.Entities.Entities;

namespace Lancetilla.DataAccess.Repositories.Bota
{
    public class PlantasRepository : IRepository<tbPlantas>
    {

        Lancetilla con = new Lancetilla();
        public IEnumerable<VW_tbPlantas> ListarDepartamentos()
        {
            return con.VW_tbPlantas.AsList();
        }
        public RequestStatus Delete(tbPlantas item)
        {
            throw new NotImplementedException();
        }

        public tbPlantas Find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tbPlantas item)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<tbPlantas> List()
        {
            throw new NotImplementedException();
        }

        public RequestStatus Update(tbPlantas item, int id)
        {
            throw new NotImplementedException();
        }
    }
}
