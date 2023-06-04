using System;
using System.Collections;
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
    public class VisitantesRepository : IRepository<tbVisitantes>
    {

        Lancetilla con = new Lancetilla();
        public IEnumerable<VW_tbVisitantes> ListarVisitantes()
        {
            return con.VW_tbVisitantes.AsList();
        }
        public RequestStatus Delete(tbVisitantes item)
        {
            throw new NotImplementedException();
        }

        public IEnumerable VisitantesSexo()
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            return db.Query(ScriptsDataBase.Visitantes, null, commandType: System.Data.CommandType.StoredProcedure);
        }

        public tbVisitantes Insert(tbVisitantes item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@visi_Nombres", item.visi_Nombres, DbType.String, ParameterDirection.Input);
            parametros.Add("@visi_Apellido", item.visi_Apellido, DbType.String, ParameterDirection.Input);
            parametros.Add("@visi_RTN", item.visi_RTN, DbType.String, ParameterDirection.Input);
            parametros.Add("@visi_Sexo", item.visi_Sexo, DbType.String, ParameterDirection.Input);
            parametros.Add("@visi_UserCreacion", item.visi_UserCreacion, DbType.Int32, ParameterDirection.Input);
          

            var result = db.QueryFirst<tbVisitantes>(ScriptsDataBase.InsertarVisitante, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }

      

        public RequestStatus Update(tbVisitantes item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@visi_Id", item.visi_Id, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@visi_Nombres", item.visi_Nombres, DbType.String, ParameterDirection.Input);
            parametros.Add("@visi_Apellido", item.visi_Apellido, DbType.String, ParameterDirection.Input);
            parametros.Add("@visi_RTN", item.visi_RTN, DbType.String, ParameterDirection.Input);
            parametros.Add("@visi_Sexo", item.visi_Sexo, DbType.String, ParameterDirection.Input);
            parametros.Add("@visi_UserModificacion", item.visi_UserModificacion, DbType.Int32, ParameterDirection.Input);


            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.ActualizarVisitante, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }

        public tbVisitantes Find(int? id)
        {
            throw new NotImplementedException();
        }

      

        public IEnumerable<tbVisitantes> List()
        {
            throw new NotImplementedException();
        }

        public RequestStatus Update(tbVisitantes item, int id)
        {
            throw new NotImplementedException();
        }

        RequestStatus IRepository<tbVisitantes>.Insert(tbVisitantes item)
        {
            throw new NotImplementedException();
        }
    }
}
