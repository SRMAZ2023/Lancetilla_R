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
    public class DepartamentosRepository : IRepository<tbDepartamentos>
    {

        Lancetilla con = new Lancetilla();
    
        public IEnumerable<VW_tbDepartamentos> ListarDepartamentos()
        {
            return con.VW_tbDepartamentos.AsList();
        }


        public RequestStatus Delete(tbDepartamentos item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();
            parametros.Add("@dept_Id", item.dept_Id, DbType.String, ParameterDirection.Input);         
    
            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.EliminarDepartamentos, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }

        public tbDepartamentos Find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tbDepartamentos item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@dept_Id", item.dept_Id, DbType.String, ParameterDirection.Input);
            parametros.Add("@dept_Descripcion", item.dept_Descripcion, DbType.String, ParameterDirection.Input);
            parametros.Add("@dept_UserCreacion", item.dept_UserCreacion, DbType.Int32, ParameterDirection.Input);

            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.InsertarDepartamentos, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }

        public IEnumerable<tbDepartamentos> List()
        {
            throw new NotImplementedException();
        }

        public RequestStatus Update(tbDepartamentos item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@dept_Id", item.dept_Id, DbType.String, ParameterDirection.Input);
            parametros.Add("@dept_Descripcion", item.dept_Descripcion, DbType.String, ParameterDirection.Input);
            parametros.Add("@dept_UserModificacion", item.dept_UserModificacion, DbType.Int32, ParameterDirection.Input);

            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.ActualizarDepartamentos, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }

        public RequestStatus Update(tbDepartamentos item, int id)
        {
            throw new NotImplementedException();
        }
    }
}
