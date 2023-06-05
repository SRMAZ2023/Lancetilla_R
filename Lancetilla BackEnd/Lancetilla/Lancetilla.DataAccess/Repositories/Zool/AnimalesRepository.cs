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

namespace Lancetilla.DataAccess.Repositories.Zool
{
    public class AnimalesRepository : IRepository<tbAnimales>
    {

        Lancetilla con = new Lancetilla();
        public IEnumerable<VW_tbAnimales> ListarAnimales()
        {
            return con.VW_tbAnimales.AsList();
        }
        public RequestStatus Delete(tbAnimales item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@anim_Id", item.anim_Id, DbType.Int32, ParameterDirection.Input);

            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.EliminacionAnimales, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }

        public IEnumerable<VW_tbAnimales>  Find(int id)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@raza_Id", id, DbType.Int32, ParameterDirection.Input);
            return db.Query<VW_tbAnimales>(ScriptsDataBase.AnimalesRaza, parametros, commandType: CommandType.StoredProcedure);
        }


        public IEnumerable AnimalesPorHabitat()
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            return db.Query(ScriptsDataBase.AnimalesPorHabitat, null, commandType: System.Data.CommandType.StoredProcedure);
        }


        public RequestStatus Insert(tbAnimales item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@anim_Codigo", item.anim_Codigo, DbType.String, ParameterDirection.Input);
            parametros.Add("@anim_Nombre", item.anim_Nombre, DbType.String, ParameterDirection.Input);
            parametros.Add("@raza_Id", item.raza_Id, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@arzo_Id", item.arzo_Id, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@alim_Id", item.alim_Id, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@anim_UserCreacion", item.anim_UserCreacion, DbType.Int32, ParameterDirection.Input);



            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.InsertarAnimales, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }

        public RequestStatus Update(tbAnimales item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@anim_Id", item.anim_Id, DbType.String, ParameterDirection.Input);
            parametros.Add("@anim_Codigo", item.anim_Codigo, DbType.String, ParameterDirection.Input);
            parametros.Add("@anim_Nombre", item.anim_Nombre, DbType.String, ParameterDirection.Input);
            parametros.Add("@raza_Id", item.raza_Id, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@arzo_Id", item.arzo_Id, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@alim_Id", item.alim_Id, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@anim_UserModificacion", item.anim_UserModificacion, DbType.Int32, ParameterDirection.Input);



            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.ActualizarAnimales, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }

        public IEnumerable<tbAnimales> List()
        {
            throw new NotImplementedException();
        }

        public RequestStatus Update(tbAnimales item, int id)
        {
            throw new NotImplementedException();
        }

        tbAnimales IRepository<tbAnimales>.Find(int? id)
        {
            throw new NotImplementedException();
        }
    }
}
