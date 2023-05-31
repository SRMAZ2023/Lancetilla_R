using Dapper;
using Lancetilla.Entities.Entities;
using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Lancetilla.DataAccess.Repositories.Zool
{
    public class RazasRepository : IRepository<tbRazas>
    {
        Lancetilla con = new Lancetilla();
        public IEnumerable<VW_tbRazas> ListarRazas()
        {
            return con.VW_tbRazas.AsList();
        }
        public RequestStatus Delete(tbRazas item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@raza_Id", item.raza_Id, DbType.Int32, ParameterDirection.Input);

            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.EliminacionRaza, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }

        public tbRazas Find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tbRazas item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@raza_Descripcion", item.raza_Descripcion, DbType.String, ParameterDirection.Input);
            parametros.Add("@raza_NombreCientifico", item.raza_NombreCientifico, DbType.String, ParameterDirection.Input);
            parametros.Add("@rein_Id", item.rein_Id, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@habi_Id", item.habi_Id, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@espe_Id", item.espe_Id, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@raza_UserCreacion", item.raza_UserCreacion, DbType.Int32, ParameterDirection.Input);



            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.InsertarRaza, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;

        }

        public IEnumerable<tbRazas> List()
        {
            throw new NotImplementedException();
        }

        public RequestStatus Update(tbRazas item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@raza_Id", item.raza_Id, DbType.String, ParameterDirection.Input);
            parametros.Add("@raza_Descripcion", item.raza_Descripcion, DbType.String, ParameterDirection.Input);
            parametros.Add("@raza_NombreCientifico", item.raza_NombreCientifico, DbType.String, ParameterDirection.Input);
            parametros.Add("@rein_Id", item.rein_Id, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@habi_Id", item.habi_Id, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@espe_Id", item.espe_Id, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@raza_UserModificacion", item.raza_UserModificacion, DbType.Int32, ParameterDirection.Input);



            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.ActualizarRaza, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;

        }

        public RequestStatus Update(tbRazas item, int id)
        {
            throw new NotImplementedException();
        }
    }
}
