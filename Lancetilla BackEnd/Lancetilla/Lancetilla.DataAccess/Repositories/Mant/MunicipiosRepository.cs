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
    public class MunicipiosRepository : IRepository<tbMunicipios>
    {

        Lancetilla con = new Lancetilla();
        public IEnumerable<VW_tbMunicipios> ListarMunicipios()
        {
            return con.VW_tbMunicipios.AsList();
        }
        public RequestStatus Delete(tbMunicipios item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@muni_Id", item.muni_Id, DbType.Int32, ParameterDirection.Input);
          
            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.EliminarMunicipios, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }

        public tbMunicipios Find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tbMunicipios item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@muni_Descripcion", item.muni_Descripcion, DbType.String, ParameterDirection.Input);
            parametros.Add("@dept_Id", item.dept_Id, DbType.Int32, ParameterDirection.Input);

            parametros.Add("@muni_UserCreacion", item.muni_UserCreacion, DbType.Int32, ParameterDirection.Input);


            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.InsertarMunicipios, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }

        public RequestStatus Update(tbMunicipios item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@muni_Id", item.muni_Id, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@muni_Descripcion", item.muni_Descripcion, DbType.String, ParameterDirection.Input);
            parametros.Add("@dept_Id", item.dept_Id, DbType.Int32, ParameterDirection.Input);

            parametros.Add("@muni_UserModificacion", item.muni_UserModificacion, DbType.Int32, ParameterDirection.Input);


            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.ActualizarMunicipios, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }

        public IEnumerable<tbMunicipios> CargarMunicipiosPorDepartamento(tbMunicipios item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();
        
            parametros.Add("@dept_Id", item.dept_Id, DbType.Int32, ParameterDirection.Input);

            var result = db.Query<tbMunicipios>(ScriptsDataBase.CargarMunicipiosPorDepa, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }
        public IEnumerable<tbMunicipios> List()
        {
            throw new NotImplementedException();
        }

        public RequestStatus Update(tbMunicipios item, int id)
        {
            throw new NotImplementedException();
        }
    }
}
