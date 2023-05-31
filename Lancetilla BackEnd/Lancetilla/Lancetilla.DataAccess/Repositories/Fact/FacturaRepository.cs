using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dapper;
using Lancetilla.Entities.Entities;
using Microsoft.Data.SqlClient;

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

        public IEnumerable<tbFacturas> EncabezadoFactura(tbFacturas item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@visi_Id", item.visi_Id, DbType.String, ParameterDirection.Input);

            var result = db.Query<tbFacturas>(ScriptsDataBase.EncabezadoFactura, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }

        public IEnumerable<tbFacturas> TablaFactura(tbFacturas item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@fact_Id", item.fact_Id, DbType.String, ParameterDirection.Input);

            var result = db.Query<tbFacturas>(ScriptsDataBase.TablaFactura, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
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
