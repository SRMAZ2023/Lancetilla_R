using Dapper;
using Lancetilla.Entities.Entities;
using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Lancetilla.DataAccess.Repositories.Acce
{
    public class UsuariosRepository : IRepository<tbUsuarios>
    {


        Lancetilla con = new Lancetilla();
        public IEnumerable<VW_tbUsuarios> ListarUsuarios()
        {
            return con.VW_tbUsuarios.AsList();
        }
        

        public tbUsuarios Find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Insert(tbUsuarios item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();


            parametros.Add("@usua_NombreUsuario", item.usua_NombreUsuario, DbType.String, ParameterDirection.Input);
            parametros.Add("@empl_Id", item.empl_Id, DbType.Int32, ParameterDirection.Input);
            //parametros.Add("@usua_Clave", item.usua_Clave, DbType.String, ParameterDirection.Input);
            parametros.Add("@usua_Admin", item.usua_Admin, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@role_Id", item.role_Id, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@usua_UserCreacion", item.usua_UserCreacion, DbType.Int32, ParameterDirection.Input);

            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.InsertarUsuarios, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }

        public RequestStatus Update(tbUsuarios item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();


            parametros.Add("@usua_Id", item.usua_Id, DbType.Int32, ParameterDirection.Input);        
            parametros.Add("@empl_Id", item.empl_Id, DbType.Int32, ParameterDirection.Input);       
            parametros.Add("@usua_Admin", item.usua_Admin, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@role_Id", item.role_Id, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@usua_UserModificacion", item.usua_UserModificacion, DbType.Int32, ParameterDirection.Input);

            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.ActualizarUsuarios, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }

        public RequestStatus Delete(tbUsuarios item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();


            parametros.Add("@usua_Id", item.usua_Id, DbType.Int32, ParameterDirection.Input);
            

            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.EliminarUsuario, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }

        public tbUsuarios InicioSession(tbUsuarios item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();


            //parametros.Add("@usua_NombreUsuario", item.usua_NombreUsuario, DbType.String, ParameterDirection.Input);
            //parametros.Add("@usua_Clave", item.usua_Clave, DbType.String, ParameterDirection.Input);


            return db.QueryFirst<tbUsuarios>(ScriptsDataBase.IniciarSesion, parametros, commandType: CommandType.StoredProcedure);
        }

        public IEnumerable<tbUsuarios> ListarEmpleadoNoTieneUser()
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            return db.Query<tbUsuarios>(ScriptsDataBase.ListarEmpleadoNoTieneUser, commandType: CommandType.StoredProcedure);
        }



        public IEnumerable<tbUsuarios> List()
        {
            throw new NotImplementedException();
        }

        public RequestStatus Update(tbUsuarios item, int id)
        {
            throw new NotImplementedException();
        }
    }
}
