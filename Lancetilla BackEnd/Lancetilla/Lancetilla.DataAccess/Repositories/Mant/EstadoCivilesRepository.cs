using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dapper;
using Lancetilla.Entities.Entities;


namespace Lancetilla.DataAccess.Repositories.Mant
{
    public class EstadoCivilesRepository : IRepository<tbEstadosCiviles>
    {
        Lancetilla con = new Lancetilla();
        public IEnumerable<VW_tbEstadosCiviles> ListarEstadoCiviles()
        {
            return con.VW_tbEstadosCiviles.AsList();
        }
        public RequestStatus Delete(tbEstadosCiviles item)
        {
            throw new NotImplementedException();
        }

        public tbEstadosCiviles Find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tbEstadosCiviles item)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<tbEstadosCiviles> List()
        {
            throw new NotImplementedException();
        }

        public RequestStatus Update(tbEstadosCiviles item, int id)
        {
            throw new NotImplementedException();
        }
    }
}
