using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dapper;
using Lancetilla.Entities.Entities;
using Microsoft.Data.SqlClient;

namespace Lancetilla.DataAccess.Repositories.Zool
{
    public class AreasZoologicoRepository : IRepository<tbAreasZoologico>
    {

        Lancetilla con = new Lancetilla();
        public IEnumerable<VW_tbAreasZoologico> ListarAreasDeZoologico()
        {
            return con.VW_tbAreasZoologico.AsList();
        }
        public RequestStatus Delete(tbAreasZoologico item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@arzo_Id", item.arzo_Id, DbType.Int32, ParameterDirection.Input);
          

            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.EliminarAreaZoologico, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }

        public tbAreasZoologico Find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tbAreasZoologico item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@arzo_Descripcion", item.arzo_Descripcion, DbType.String, ParameterDirection.Input);
            parametros.Add("@arzo_UserCreacion", item.arzo_UserCreacion, DbType.Int32, ParameterDirection.Input);
            
            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.InsertarAreaZoologico, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }

        public RequestStatus Update(tbAreasZoologico item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@arzo_Id", item.arzo_Id, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@arzo_Descripcion", item.arzo_Descripcion, DbType.String, ParameterDirection.Input);
            parametros.Add("@arzo_UserModificacion", item.arzo_UserModificacion, DbType.Int32, ParameterDirection.Input);

            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.ActualizarAreaZoologico, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
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
