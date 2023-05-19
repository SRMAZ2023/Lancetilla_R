using AutoMapper;
using Lancetilla.API.Models;
using Lancetilla.BussinessLogic.Servicios.Mantenimiento_Servicios;
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
    public class DepartamentoController : ControllerBase
    {

        private readonly MantenimientoServicios  _mantenimientoServicios;
        private readonly IMapper _mapper;

        public DepartamentoController(MantenimientoServicios  mantenimientoServicios, IMapper mapper)
        {
            _mantenimientoServicios = mantenimientoServicios;
            _mapper = mapper;
        }
        [HttpGet("ListarDepartamentos")]
        public IActionResult ListarDepartamentos()
        {
            var list = _mantenimientoServicios.ListarDepartamentos();
            return Ok(list);
        }

        [HttpPost("InsertarDedepartamento")]
        public IActionResult InsertarDepartamento(DepartamentosViewModel item)
        {
            var departamento = _mapper.Map<tbDepartamentos>(item);
            var List = _mantenimientoServicios.InsertDepartamento(departamento);
            return Ok(List);
        }


        [HttpPost("ActualizarDepartamento")]
        public IActionResult ActualizarDepartamento(DepartamentosViewModel item)
        {
            var departamento = _mapper.Map<tbDepartamentos>(item);
            var List = _mantenimientoServicios.ActualizarDepartamento(departamento);
            return Ok(List);
        }

        [HttpPost("EliminarDepartamento")]
        public IActionResult EliminarDepartamento(DepartamentosViewModel item)
        {
            var departamento = _mapper.Map<tbDepartamentos>(item);
            var List = _mantenimientoServicios.EliminarDepartamento(departamento);
            return Ok(List);
        }
    }
}
