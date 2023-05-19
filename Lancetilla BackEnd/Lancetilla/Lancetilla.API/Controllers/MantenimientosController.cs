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
    public class MantenimientosController : ControllerBase
    {

        private readonly MantenimientoServicios _mantenimientoServicios;
        private readonly IMapper _mapper;

        public MantenimientosController(MantenimientoServicios mantenimientoServicios, IMapper mapper)
        {
            _mantenimientoServicios = mantenimientoServicios;
            _mapper = mapper;
        }
        [HttpGet("ListarMantenimientos")]
        public IActionResult ListarMantenimientos()
        {
            var list = _mantenimientoServicios.ListarMantenimientos();
            return Ok(list);
        }

        [HttpPost("InsertMantenimiento")]
        public IActionResult InsertMantenimiento(MantenimientosViewModel item)
        {
            var mantenimientos = _mapper.Map<tbMantenimientos>(item);
            var List = _mantenimientoServicios.InsertMantenimiento(mantenimientos);
            return Ok(List);
        }

        [HttpPost("ActualizarMantenimiento")]
        public IActionResult ActualizarMantenimiento(MantenimientosViewModel item)
        {
            var mantenimientos = _mapper.Map<tbMantenimientos>(item);
            var List = _mantenimientoServicios.ActualizarMantenimiento(mantenimientos);
            return Ok(List);
        }

        [HttpPost("EliminarMantenimiento")]
        public IActionResult EliminarMantenimiento(MantenimientosViewModel item)
        {
            var mantenimientos = _mapper.Map<tbMantenimientos>(item);
            var List = _mantenimientoServicios.EliminarMantenimiento(mantenimientos);
            return Ok(List);
        }
    }
}
