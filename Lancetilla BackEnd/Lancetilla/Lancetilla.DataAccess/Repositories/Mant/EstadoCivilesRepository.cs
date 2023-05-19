using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dapper;
using Lancetilla.Entities.Entities;
using Microsoft.Data.SqlClient;

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
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@estc_Id", item.estc_Id, DbType.Int32, ParameterDirection.Input);
           
            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.EliminarEstadoCivil, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }

        public tbEstadosCiviles Find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tbEstadosCiviles item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@estc_Descripcion", item.estc_Descripcion, DbType.String, ParameterDirection.Input);

            parametros.Add("@estc_UserCreacion", item.estc_UserCreacion, DbType.Int32, ParameterDirection.Input);


            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.InsertarEstadoCivil, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }


        public RequestStatus Update(tbEstadosCiviles item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@estc_Id", item.estc_Id, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@estc_Descripcion", item.estc_Descripcion, DbType.String, ParameterDirection.Input);

            parametros.Add("@estc_UserModificacion", item.estc_UserModificacion, DbType.Int32, ParameterDirection.Input);


            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.ActualizarEstadoCivil, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
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
