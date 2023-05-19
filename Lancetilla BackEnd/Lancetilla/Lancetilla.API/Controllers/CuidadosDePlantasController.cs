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
    public class CuidadosDePlantasController : ControllerBase
    {


        private readonly BotanicaServicios _botanicaServicios;
        private readonly IMapper _mapper;

        public CuidadosDePlantasController(BotanicaServicios botanicaServicios, IMapper mapper)
        {
            _botanicaServicios = botanicaServicios;
            _mapper = mapper;
        }
        [HttpGet("ListarCuidadosDePlantas")]
        public IActionResult ListarCuidadosDePlantas()
        {
            var list = _botanicaServicios.ListarCuidadosDePlantas();
            return Ok(list);
        }
    }
}
