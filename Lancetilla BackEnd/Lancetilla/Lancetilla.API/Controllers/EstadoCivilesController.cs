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
    public class EstadoCivilesController : ControllerBase
    {


        private readonly MantenimientoServicios _mantenimientoServicios;
        private readonly IMapper _mapper;

        public EstadoCivilesController(MantenimientoServicios mantenimientoServicios, IMapper mapper)
        {
            _mantenimientoServicios = mantenimientoServicios;
            _mapper = mapper;
        }
        [HttpGet("ListarEstadoCiviles")]
        public IActionResult ListarEstadoCiviles()
        {
            var list = _mantenimientoServicios.ListarEstadoCiviles();
            return Ok(list);
        }


        [HttpPost("InsertEstadoCivil")]
        public IActionResult InsertEstadoCivil(EstadoCivilViewModel item)
        {
            var estadosCiviles = _mapper.Map<tbEstadosCiviles>(item);
            var List = _mantenimientoServicios.InsertEstadoCivil(estadosCiviles);
            return Ok(List);
        }

        [HttpPost("ActualizarEstadoCivil")]
        public IActionResult ActualizarEstadoCivil(EstadoCivilViewModel item)
        {
            var estadosCiviles = _mapper.Map<tbEstadosCiviles>(item);
            var List = _mantenimientoServicios.ActualizarEstadoCivil(estadosCiviles);
            return Ok(List);
        }

        [HttpPost("EliminarEstadoCivil")]
        public IActionResult EliminarEstadoCivil(EstadoCivilViewModel item)
        {
            var estadosCiviles = _mapper.Map<tbEstadosCiviles>(item);
            var List = _mantenimientoServicios.EliminarEstadoCivil(estadosCiviles);
            return Ok(List);
        }
    }
}
