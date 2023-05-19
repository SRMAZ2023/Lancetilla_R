using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dapper;
using Lancetilla.Entities.Entities;

namespace Lancetilla.DataAccess.Repositories.Zool
{
    public class AlimentacionRepository : IRepository<tbAlimentacion>
    {

        Lancetilla con = new Lancetilla();
        public IEnumerable<VW_tbALimentacion> ListarAlimentacion()
        {
            return con.VW_tbALimentacion.AsList();
        }
        public RequestStatus Delete(tbAlimentacion item)
        {
            throw new NotImplementedException();
        }

        public tbAlimentacion Find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tbAlimentacion item)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<tbAlimentacion> List()
        {
            throw new NotImplementedException();
        }

        public RequestStatus Update(tbAlimentacion item, int id)
        {
            throw new NotImplementedException();
        }
    }
}
