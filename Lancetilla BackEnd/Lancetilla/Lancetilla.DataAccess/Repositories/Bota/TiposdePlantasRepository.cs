using Dapper;
using Lancetilla.Entities.Entities;
using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.Data;
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
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@tipl_Id", item.tipl_Id, DbType.Int32, ParameterDirection.Input);

            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.EliminarTipoPlantas, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }


        public IEnumerable<VW_tbTiposPlantas> Find(int id)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@tipl_Id", id, DbType.Int32, ParameterDirection.Input);
            return db.Query<VW_tbTiposPlantas>(ScriptsDataBase.BuscarTipoPlantas, parametros, commandType: CommandType.StoredProcedure);
        }


        public tbTiposPlantas Find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tbTiposPlantas item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@tipl_NombreComun", item.tipl_NombreComun, DbType.String, ParameterDirection.Input);
            parametros.Add("@tipl_NombreCientifico", item.tipl_NombreCientifico, DbType.String, ParameterDirection.Input);
            parametros.Add("@rein_Id", item.rein_Id, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@tipl_UserCreacion", item.tipl_UserCreacion, DbType.Int32, ParameterDirection.Input);

            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.InsertarTipoPlanta, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }

        public IEnumerable<tbTiposPlantas> List()
        {
            throw new NotImplementedException();
        }

        public RequestStatus Update(tbTiposPlantas item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@tipl_Id", item.tipl_Id, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@tipl_NombreComun", item.tipl_NombreComun, DbType.String, ParameterDirection.Input);
            parametros.Add("@tipl_NombreCientifico", item.tipl_NombreCientifico, DbType.String, ParameterDirection.Input);
            parametros.Add("@rein_Id", item.rein_Id, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@tipl_UserModificacion", item.tipl_UserModificacion, DbType.Int32, ParameterDirection.Input);

            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.ActualizarTipoPlantas, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }

        public RequestStatus Update(tbTiposPlantas item, int id)
        {
            throw new NotImplementedException();
        }
    }
}
