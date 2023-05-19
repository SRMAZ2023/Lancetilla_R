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
    public class EspeciesRepository : IRepository<tbEspecies>
    {

        Lancetilla con = new Lancetilla();
        public IEnumerable<VW_tbEspecies> ListarEspecies()
        {
            return con.VW_tbEspecies.AsList();
        }
       

        public tbEspecies Find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tbEspecies item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();


            parametros.Add("@espe_Descripcion", item.espe_Descripcion, DbType.String, ParameterDirection.Input);
            parametros.Add("@espe_UserCreacion", item.espe_UserCreacion, DbType.Int32, ParameterDirection.Input);

            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.InsertarEspecie, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }

        public RequestStatus Update(tbEspecies item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@espe_Id", item.espe_Id, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@espe_Descripcion", item.espe_Descripcion, DbType.String, ParameterDirection.Input);
            parametros.Add("@espe_UserModificacion", item.espe_UserModificacion, DbType.Int32, ParameterDirection.Input);

            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.ActualizarEspecie, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }

        public RequestStatus Delete(tbEspecies item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@espe_Id", item.espe_Id, DbType.String, ParameterDirection.Input);
          

            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.EliminarEspecie, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }



        public IEnumerable<tbEspecies> List()
        {
            throw new NotImplementedException();
        }

        public RequestStatus Update(tbEspecies item, int id)
        {
            throw new NotImplementedException();
        }
    }
}
