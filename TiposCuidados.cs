using AutoMapper;
using Lancetilla.API.Models;
using Lancetilla.BussinessLogic.Servicios.Botanica_Servicios;
using Lancetilla.Entities.Entities;
using Microsoft.AspNetCore.Http;
using Microsoft.AspNetCore.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Lancetilla.API.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    public class TiposCuidadosController : ControllerBase
    {
        private readonly BotanicaServicios _botanicaServicios;
        private readonly IMapper _mapper;

        public TiposCuidadosController(BotanicaServicios botanicaServicios, IMapper mapper)
        {
            _botanicaServicios = botanicaServicios;
            _mapper = mapper;
        }

        [HttpGet("List")]
        public IActionResult ListarTiposPlantas()
        {
            var list = _botanicaServicios.ListarTiposCuidados();
            return Ok(list);
        }
        [HttpGet("Find/{id}")]
        public IActionResult BuscarTiposCuidados(int id)
        {
            var list = _botanicaServicios.BuscarTiposCuidados(id);
            return Ok(list);
        }


        [HttpPost("Insert")]
        public IActionResult InsertarTiposCuidados(tbTiposCuidadosViewModel item)
        {
            var animales = _mapper.Map<tbTiposCuidados>(item);
            var List = _botanicaServicios.InsertarTiposCuidados(animales);
            return Ok(List);
        }

        [HttpPost("Update")]
        public IActionResult ActualizarTiposCuidados(tbTiposCuidadosViewModel item)
        {
            var animales = _mapper.Map<tbTiposCuidados>(item);
            var List = _botanicaServicios.ActualizarTiposCuidados(animales);
            return Ok(List);
        }

        [HttpPost("Delete")]
        public IActionResult EliminarTiposCuidados(tbTiposCuidadosViewModel item)
        {
            var animales = _mapper.Map<tbTiposCuidados>(item);
            var List = _botanicaServicios.EliminarTiposCuidados(animales);
            return Ok(List);
        }

        /*
        [HttpGet("AnimalesPorArea")]
        public IActionResult AnimalesPorArea()
        {
            var list = _botanicaServicios.AnimalesPorArea();

            return Ok(list);
        }
        [HttpGet("AnimalesPorHabitat")]
        public IActionResult AnimalesPorHabitat()
        {
            var list = _zoologicoServicios.AnimalesPorHabitat();

            return Ok(list);
        }*/
    }
}


//////////////////////////////////////////////////////////////

Servicios
 public IEnumerable<VW_tbTiposCuidados> ListarTiposCuidados()
        {
            try
            {
                var list = _tiposCuidados.ListarTiposCuidados();
                return list;
            }
            catch (Exception ex)
            {

                return Enumerable.Empty<VW_tbTiposCuidados>();

            }
        }

        

        public VW_tbCuidadoPlanta BuscarTiposCuidados(int id)
        {
            try
            {
                var list = _tiposCuidados.Find(id);
                return list;
            }
            catch (Exception ex)
            {

                return null;

            }
        }




        public ServiceResult InsertarTiposCuidados(tbTiposCuidados item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _tiposCuidados.Insert(item);
                if (map.CodeStatus == 200)
                {
                    return result.SetMessage(map.MessageStatus, ServiceResultType.Success);

                }
                else if (map.CodeStatus == 409)
                {
                    return result.SetMessage(map.MessageStatus, ServiceResultType.Conflict);
                }
                else
                {
                    return result.SetMessage(map.MessageStatus, ServiceResultType.Error);
                }
            }
            catch (Exception ex)
            {
                return result.Error(ex.Message);
            }
        }

        public ServiceResult ActualizarTiposCuidados(tbTiposCuidados item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _tiposCuidados.Update(item);
                if (map.CodeStatus == 200)
                {
                    return result.SetMessage(map.MessageStatus, ServiceResultType.Success);

                }
                else if (map.CodeStatus == 409)
                {
                    return result.SetMessage(map.MessageStatus, ServiceResultType.Conflict);
                }
                else
                {
                    return result.SetMessage(map.MessageStatus, ServiceResultType.Error);
                }
            }
            catch (Exception ex)
            {
                return result.Error(ex.Message);
            }
        }

        public ServiceResult EliminarTiposCuidados(tbTiposCuidados item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _tiposCuidados.Delete(item);
                if (map.CodeStatus == 200)
                {
                    return result.SetMessage(map.MessageStatus, ServiceResultType.Success);

                }
                else if (map.CodeStatus == 409)
                {
                    return result.SetMessage(map.MessageStatus, ServiceResultType.Conflict);
                }
                else
                {
                    return result.SetMessage(map.MessageStatus, ServiceResultType.Error);
                }
            }
            catch (Exception ex)
            {
                return result.Error(ex.Message);
            }
        }


//////////////////////////////////////////////////////////////////////////////////////////////
Repositprio

using Dapper;
using Lancetilla.Entities.Entities;
using Microsoft.Data.SqlClient;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Lancetilla.DataAccess.Repositories.Bota
{
    public class TiposCuidados : IRepository<tbTiposCuidados>
    {
        Lancetilla con = new Lancetilla();
        public IEnumerable<VW_tbTiposCuidados> ListarTiposCuidados()
        {
            return con.VW_tbTiposCuidados.AsList();
        }

        public RequestStatus Delete(tbTiposCuidados item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@ticu_Id", item.ticu_Id, DbType.Int32, ParameterDirection.Input);

            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.tbTiposCuidados_DELETE, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }

        public VW_tbCuidadoPlanta Find(int? id)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@ticu_Id", id, DbType.Int32, ParameterDirection.Input);

            var result = db.QueryFirst<VW_tbCuidadoPlanta>(ScriptsDataBase.tbTiposCuidados_FIND, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }

        public RequestStatus Insert(tbTiposCuidados item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@ticu_Descripcion", item.ticu_Descripcion, DbType.String, ParameterDirection.Input);
            parametros.Add("@ticu_UserCreacion", item.ticu_UserCreacion, DbType.Int32, ParameterDirection.Input);

            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.tbTiposCuidados_CREATE, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;
        }

        public IEnumerable<tbTiposCuidados> List()
        {
            throw new NotImplementedException();
        }



        public RequestStatus Update(tbTiposCuidados item)
        {
            using var db = new SqlConnection(Lancetilla.ConnectionString);
            var parametros = new DynamicParameters();

            parametros.Add("@ticu_Id", item.ticu_Id, DbType.Int32, ParameterDirection.Input);
            parametros.Add("@ticu_Descripcion", item.ticu_Descripcion, DbType.String, ParameterDirection.Input);
            parametros.Add("@ticu_UserCreacion", item.ticu_UserCreacion, DbType.Int32, ParameterDirection.Input);

            var result = db.QueryFirst<RequestStatus>(ScriptsDataBase.tbTiposCuidados_UPDATE, parametros, commandType: System.Data.CommandType.StoredProcedure);
            return result;

        }

        tbTiposCuidados IRepository<tbTiposCuidados>.Find(int? id)
        {
            throw new NotImplementedException();
        }

        public RequestStatus Update(tbTiposCuidados item, int id)
        {
            throw new NotImplementedException();
        }
    }
}
