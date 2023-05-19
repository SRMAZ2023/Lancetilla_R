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
            return con.VW_MantenimientoAnimales.AsList();
        }

        public tbMantenimientoAnimal Find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tbMantenimientoAnimal item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@anim_Id", item.anim_Id, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@mant_Id", item.mant_Id, DbType.Int32, ParameterDirection.Input);
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
            parametros.Add("@mant_Id", item.mant_Id, DbType.Int32, ParameterDirection.Input);
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
    }
}
