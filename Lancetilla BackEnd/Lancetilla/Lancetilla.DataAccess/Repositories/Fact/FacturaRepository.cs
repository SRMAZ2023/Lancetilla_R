﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dapper;
using Lancetilla.Entities.Entities;

namespace Lancetilla.DataAccess.Repositories.Fact
{
    public class FacturaRepository : IRepository<tbFacturas>
    {

        Lancetilla con = new Lancetilla();
        public IEnumerable<VW_tbFacturas> ListarFacturas()
        {
            return con.VW_tbFacturas.AsList();
        }
        public RequestStatus Delete(tbFacturas item)
        {
            throw new NotImplementedException();
        }

        public tbFacturas Find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tbFacturas item)
        {
            throw new NotImplementedException();
        }

        public IEnumerable<tbFacturas> List()
        {
            throw new NotImplementedException();
        }

        public RequestStatus Update(tbFacturas item, int id)
        {
            throw new NotImplementedException();
        }
    }
}
