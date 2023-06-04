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

        public IEnumerable<tbFacturas> EncabezadoFactura(tbFacturas item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@visi_Id", item.visi_Id, DbType.String, ParameterDirection.Input);

            var result = db.Query<tbFacturas>(ScriptsDataBase.EncabezadoFactura, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }

        public RequestStatus InsertarFacturaDetalle(tbFacturasDetalles item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@fact_Id", item.fact_Id, DbType.String, ParameterDirection.Input);
            parametros.Add("@tick_Id", item.tick_Id, DbType.String, ParameterDirection.Input);
            parametros.Add("@fade_Cantidad", item.fade_Cantidad, DbType.String, ParameterDirection.Input);
            parametros.Add("@fade_UserCreacion", item.fade_UserCreacion, DbType.String, ParameterDirection.Input);

            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.InsertarDetallesFactura, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
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
