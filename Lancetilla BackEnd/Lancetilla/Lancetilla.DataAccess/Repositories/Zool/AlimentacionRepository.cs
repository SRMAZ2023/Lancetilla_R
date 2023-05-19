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
    public class AlimentacionRepository : IRepository<tbAlimentacion>
    {

        Lancetilla con = new Lancetilla();
        public IEnumerable<VW_tbALimentacion> ListarAlimentacion()
        {
            return con.VW_tbALimentacion.AsList();
        }
        public RequestStatus Delete(tbAlimentacion item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@alim_Id", item.alim_Id, DbType.Int32, ParameterDirection.Input);
          

            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.EliminacionAlimentacion, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }

        public tbAlimentacion Find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tbAlimentacion item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@alim_Descripcion", item.alim_Descripcion, DbType.String, ParameterDirection.Input);
            parametros.Add("@alim_UserCreacion", item.alim_UserCreacion, DbType.Int32, ParameterDirection.Input);

            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.InsertarAlimentacion, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }

        public RequestStatus Update(tbAlimentacion item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@alim_Id", item.alim_Id, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@alim_Descripcion", item.alim_Descripcion, DbType.String, ParameterDirection.Input);
            parametros.Add("@alim_UserModificacion", item.alim_UserModificacion, DbType.Int32, ParameterDirection.Input);

            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.ActualizarAlimentacion, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
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
