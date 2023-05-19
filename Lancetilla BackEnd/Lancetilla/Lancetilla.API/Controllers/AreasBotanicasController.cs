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

        [HttpPost("InsertarAreaBotanica")]
        public IActionResult InsertarAreaBotanica(AreasBotanicasViewModel item)
        {
            var areasBotanicas = _mapper.Map<tbAreasBotanicas>(item);
            var List = _botanicaServicios.InsertarAreaBotanica(areasBotanicas);
            return Ok(List);
        }


        [HttpPost("ActualizarAreaBotanica")]
        public IActionResult ActualizarAreaBotanica(AreasBotanicasViewModel item)
        {
            var areasBotanicas = _mapper.Map<tbAreasBotanicas>(item);
            var List = _botanicaServicios.ActualizarAreaBotanica(areasBotanicas);
            return Ok(List);
        }

        [HttpPost("EliminarAreaBotanica")]
        public IActionResult EliminarAreaBotanica(AreasBotanicasViewModel item)
        {
            var areasBotanicas = _mapper.Map<tbAreasBotanicas>(item);
            var List = _botanicaServicios.EliminarAreaBotanica(areasBotanicas);
            return Ok(List);
        }
    }
}
