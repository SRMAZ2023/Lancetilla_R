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
    public class CargosController : ControllerBase
    {

        private readonly MantenimientoServicios _mantenimientoServicios;
        private readonly IMapper _mapper;

        public CargosController(MantenimientoServicios mantenimientoServicios, IMapper mapper)
        {
            _mantenimientoServicios = mantenimientoServicios;
            _mapper = mapper;
        }
        [HttpGet("ListarCargos")]
        public IActionResult ListarCargos()
        {
            var list = _mantenimientoServicios.ListarCargos();
            return Ok(list);
        }

        [HttpPost("InsertarCargo")]
        public IActionResult InsertarCargo(CargosViewModel item)
        {
            var cargo = _mapper.Map<tbCargos>(item);
            var List = _mantenimientoServicios.InsertarCargo(cargo);
            return Ok(List);
        }

        [HttpPost("ActualizarCargo")]
        public IActionResult ActualizarCargo(CargosViewModel item)
        {
            var cargo = _mapper.Map<tbCargos>(item);
            var List = _mantenimientoServicios.ActualizarCargo(cargo);
            return Ok(List);
        }

        [HttpPost("EliminarCargo")]
        public IActionResult EliminarCargo(CargosViewModel item)
        {
            var cargo = _mapper.Map<tbCargos>(item);
            var List = _mantenimientoServicios.EliminarCargo(cargo);
            return Ok(List);
        }
    }
}
