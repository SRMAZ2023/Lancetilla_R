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
    public class TiposDeMantenimientosController : ControllerBase
    {

        private readonly MantenimientoServicios _mantenimientoServicios;
        private readonly IMapper _mapper;

        public TiposDeMantenimientosController(MantenimientoServicios mantenimientoServicios, IMapper mapper)
        {
            _mantenimientoServicios = mantenimientoServicios;
            _mapper = mapper;
        }
        [HttpGet("ListarTiposDeMantenimientos")]
        public IActionResult ListarTiposDeMantenimientos()
        {
            var list = _mantenimientoServicios.ListarTiposDeMantenimientos();
            return Ok(list);
        }

        [HttpPost("InsertTipoDeMantenimiento")]
        public IActionResult InsertTipoDeMantenimiento(TiposDeMantenimientoViewModel item)
        {
            var  tiposMantenimientos = _mapper.Map<tbTiposMantenimientos>(item);
            var List = _mantenimientoServicios.InsertTipoDeMantenimiento(tiposMantenimientos);
            return Ok(List);
        }

        [HttpPost("ActualizarTipoDeMantenimiento")]
        public IActionResult ActualizarTipoDeMantenimiento(TiposDeMantenimientoViewModel item)
        {
            var tiposMantenimientos = _mapper.Map<tbTiposMantenimientos>(item);
            var List = _mantenimientoServicios.ActualizarTipoDeMantenimiento(tiposMantenimientos);
            return Ok(List);
        }


        [HttpPost("EliminarTipoDeMantenimiento")]
        public IActionResult EliminarTipoDeMantenimiento(TiposDeMantenimientoViewModel item)
        {
            var tiposMantenimientos = _mapper.Map<tbTiposMantenimientos>(item);
            var List = _mantenimientoServicios.EliminarTipoDeMantenimiento(tiposMantenimientos);
            return Ok(List);
        }


    }
}
