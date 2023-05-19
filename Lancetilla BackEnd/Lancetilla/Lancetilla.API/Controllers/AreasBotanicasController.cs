using AutoMapper;
using Lancetilla.BussinessLogic.Servicios.Botanica_Servicios;
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
    public class AreasBotanicasController : ControllerBase
    {

        private readonly BotanicaServicios  _botanicaServicios;
        private readonly IMapper _mapper;

        public AreasBotanicasController(BotanicaServicios  botanicaServicios, IMapper mapper)
        {
            _botanicaServicios = botanicaServicios;
            _mapper = mapper;
        }
        [HttpGet("ListarAreasBotanicas")]
        public IActionResult ListarAreasBotanicas()
        {
            var list = _botanicaServicios.ListarAreasBotanicas();
            return Ok(list);
        }
    }
}
