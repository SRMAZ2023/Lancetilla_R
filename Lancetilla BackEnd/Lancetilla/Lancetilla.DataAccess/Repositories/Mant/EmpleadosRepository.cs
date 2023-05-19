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
    public class EmpleadosRepository : IRepository<tbEmpleados>
    {

        Lancetilla con = new Lancetilla();
        public IEnumerable<VW_tbEmpleados> ListarEmpleados()
        {
            return con.VW_tbEmpleados.AsList();
        }
     

        public RequestStatus Insert(tbEmpleados item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@empl_Nombre", item.empl_Nombre, DbType.String, ParameterDirection.Input);
            parametros.Add("@empl_Apellido", item.empl_Apellido, DbType.String, ParameterDirection.Input);
            parametros.Add("@empl_Identidad", item.empl_Identidad, DbType.String, ParameterDirection.Input);
            parametros.Add("@empl_FechaNacimiento", item.empl_FechaNacimiento, DbType.String, ParameterDirection.Input);
            parametros.Add("@empl_Direccion", item.empl_Direccion, DbType.String, ParameterDirection.Input);
            parametros.Add("@empl_Sexo", item.empl_Sexo, DbType.String, ParameterDirection.Input);
            parametros.Add("@empl_Telefono", item.empl_Telefono, DbType.String, ParameterDirection.Input);
            parametros.Add("@estc_Id", item.estc_Id, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@carg_Id", item.carg_Id, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@muni_Id", item.muni_Id, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@empl_UserCreacion", item.empl_UserCreacion, DbType.Int32, ParameterDirection.Input);

            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.InsertarEmpleados, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }

        public RequestStatus Update(tbEmpleados item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@empl_Id", item.empl_Id, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@empl_Nombre", item.empl_Nombre, DbType.String, ParameterDirection.Input);
            parametros.Add("@empl_Apellido", item.empl_Apellido, DbType.String, ParameterDirection.Input);
            parametros.Add("@empl_Identidad", item.empl_Identidad, DbType.String, ParameterDirection.Input);
            parametros.Add("@empl_FechaNacimiento", item.empl_FechaNacimiento, DbType.String, ParameterDirection.Input);
            parametros.Add("@empl_Direccion", item.empl_Direccion, DbType.String, ParameterDirection.Input);
            parametros.Add("@empl_Sexo", item.empl_Sexo, DbType.String, ParameterDirection.Input);
            parametros.Add("@empl_Telefono", item.empl_Telefono, DbType.String, ParameterDirection.Input);
            parametros.Add("@estc_Id", item.estc_Id, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@carg_Id", item.carg_Id, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@muni_Id", item.muni_Id, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@empl_UserModificacion", item.empl_UserModificacion, DbType.Int32, ParameterDirection.Input);

            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.ActualizarEmpleados, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }

        public RequestStatus Delete(tbEmpleados item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@empl_Id", item.empl_Id, DbType.Int32, ParameterDirection.Input);
          

            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.EliminarEmpleados, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }

        public tbEmpleados Find(int? id)
        {
            throw new NotImplementedException();
        }

       

        public IEnumerable<tbEmpleados> List()
        {
            throw new NotImplementedException();
        }

        public RequestStatus Update(tbEmpleados item, int id)
        {
            throw new NotImplementedException();
        }
    }
}
