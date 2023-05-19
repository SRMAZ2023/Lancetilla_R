using AutoMapper;
using Lancetilla.BussinessLogic.Servicios.Mantenimiento_Servicios;
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
    }
}
