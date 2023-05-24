using Dapper;
using Lancetilla.Entities.Entities;
using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Lancetilla.DataAccess.Repositories.Mant
{
    public class MantenimientoPorAnimalRepository : IRepository<tbMantenimientoAnimal>
    {
        public RequestStatus Delete(tbMantenimientoAnimal item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@maan_Id", item.maan_Id, DbType.Int32, ParameterDirection.Input);
        
            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.EliminarMantenimientoAnimal, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }


        Lancetilla con = new Lancetilla();
        public IEnumerable<VW_MantenimientoAnimales> ListarMantenimientoAnimal()
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            return db.Query<VW_MantenimientoAnimales>(ScriptsDataBase.UDP_tbMantenimientosAnimal_SELECT, null, commandType: CommandType.StoredProcedure);
        }

      

        public IEnumerable<VW_MantenimientoAnimales> Find2(int? id)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@anim_Id", id, DbType.Int32, ParameterDirection.Input);
            return db.Query<VW_MantenimientoAnimales>(ScriptsDataBase.UDP_tbMantenimientosAnimal_FIND, parametros, commandType: CommandType.StoredProcedure);

        }

            public RequestStatus Insert(tbMantenimientoAnimal item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@anim_Id", item.anim_Id, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@tima_Id", item.tima_Id, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@maan_Fecha", item.maan_Fecha, DbType.Date, ParameterDirection.Input);
            parametros.Add("@maan_UserCreacion", item.maan_UserCreacion, DbType.Int32, ParameterDirection.Input);

            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.InsertarMantenimientoAnimal, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }

        public RequestStatus Update(tbMantenimientoAnimal item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@maan_Id", item.maan_Id, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@anim_Id", item.anim_Id, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@tima_Id", item.tima_Id, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@maan_Fecha", item.maan_Fecha, DbType.Date, ParameterDirection.Input);
            parametros.Add("@maan_UserModificacion", item.maan_UserModificacion, DbType.Int32, ParameterDirection.Input);

            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.ActualizarMantenimientoAnimal, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }

        public IEnumerable<tbMantenimientoAnimal> List()
        {
            throw new NotImplementedException();
        }

        public RequestStatus Update(tbMantenimientoAnimal item, int id)
        {
            throw new NotImplementedException();
        }

        tbMantenimientoAnimal IRepository<tbMantenimientoAnimal>.Find(int? id)
        {
            throw new NotImplementedException();
        }
    }
}
