using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Dapper;
using Lancetilla.Entities.Entities;
using Microsoft.Data.SqlClient;

namespace Lancetilla.DataAccess.Repositories.Bota
{
    public class PlantasRepository : IRepository<tbPlantas>
    {

        Lancetilla con = new Lancetilla();
        public IEnumerable<VW_tbPlantas> ListarPlantas()
        {
            return con.VW_tbPlantas.AsList();
        }
        //public RequestStatus Delete(tbPlantas item)
        //{
        //    using var db = new SqlConnection(Lancetilla.ConnectionString);
        //    var parametros = new DynamicParameters();

        //    parametros.Add("@plan_Id", item.plan_Id, DbType.Int32, ParameterDirection.Input);
           
        //    var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.EliminarPlantas, parametros, commandType: System.Data.CommandType.StoredProcedure);
        //    return result;
        //}

        //public VW_tbPlantas Find(int? id)
        //{
        //    using var db = new SqlConnection(Lancetilla.ConnectionString);
        //    var parametros = new DynamicParameters();

        //    parametros.Add("@plan_Id", id, DbType.Int32, ParameterDirection.Input);

        //    var result = db.QueryFirst<VW_tbPlantas>(ScriptsDataBase.UDP_tbPlantas_FIND, parametros, commandType: System.Data.CommandType.StoredProcedure);
        //    return result;
        //}

        //public RequestStatus Insert(tbPlantas item)
        //{
        //    using var db = new SqlConnection(Lancetilla.ConnectionString);
        //    var parametros = new DynamicParameters();

        //    parametros.Add("@plan_Nombre", item.plan_Nombre, DbType.String, ParameterDirection.Input);
        //    parametros.Add("@plan_NombreCientifico", item.plan_NombreCientifico, DbType.String, ParameterDirection.Input);
        //    parametros.Add("@plan_Reino", item.plan_Reino, DbType.String, ParameterDirection.Input);
        //    parametros.Add("@arbo_Id", item.arbo_Id, DbType.Int32, ParameterDirection.Input);

        //    parametros.Add("@cuid_Id", item.cuid_Id, DbType.Int32, ParameterDirection.Input);
        //    parametros.Add("@plan_UserCreacion", item.plan_UserCreacion, DbType.Int32, ParameterDirection.Input);

        //    var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.InsertarPlantas, parametros, commandType: System.Data.CommandType.StoredProcedure);
        //    return result;
        //}

        //public RequestStatus Update(tbPlantas item)
        //{
        //    using var db = new SqlConnection(Lancetilla.ConnectionString);
        //    var parametros = new DynamicParameters();

        //    parametros.Add("@plan_Id", item.plan_Id, DbType.Int32, ParameterDirection.Input);
        //    parametros.Add("@plan_Nombre", item.plan_Nombre, DbType.String, ParameterDirection.Input);
        //    parametros.Add("@plan_NombreCientifico", item.plan_NombreCientifico, DbType.String, ParameterDirection.Input);
        //    parametros.Add("@plan_Reino", item.plan_Reino, DbType.String, ParameterDirection.Input);
        //    parametros.Add("@arbo_Id", item.arbo_Id, DbType.Int32, ParameterDirection.Input);

        //    parametros.Add("@cuid_Id", item.cuid_Id, DbType.Int32, ParameterDirection.Input);
        //    parametros.Add("@plan_UserModificacion", item.plan_UserCreacion, DbType.Int32, ParameterDirection.Input);

        //    var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.ActualizarPlantas, parametros, commandType: System.Data.CommandType.StoredProcedure);
        //    return result;
        //}

        public IEnumerable<tbPlantas> List()
        {
            throw new NotImplementedException();
        }

        public RequestStatus Update(tbPlantas item, int id)
        {
            throw new NotImplementedException();
        }

        tbPlantas IRepository<tbPlantas>.Find(int? id)
        {
            throw new NotImplementedException();
        }

         
        public RequestStatus Insert(tbPlantas item)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Delete(tbPlantas item)
        {
            throw new NotImplementedException();
        }
    }
}
