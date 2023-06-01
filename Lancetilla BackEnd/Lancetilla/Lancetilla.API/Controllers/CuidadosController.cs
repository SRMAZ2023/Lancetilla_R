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
    public class CuidadosController : ControllerBase
    {


        private readonly BotanicaServicios _botanicaServicios;
        private readonly IMapper _mapper;

        public CuidadosController(BotanicaServicios botanicaServicios, IMapper mapper)
        {
            _botanicaServicios = botanicaServicios;
            _mapper = mapper;
        }
        [HttpGet("List")]
        public IActionResult ListarCuidadosDePlantas()
        {
            var list = _botanicaServicios.ListarCuidados();
            return Ok(list);
        }

        [HttpPost("Insert")]
        public IActionResult InsertarCuidados(CuidadosViewModel item)
        {
            var cuidados = _mapper.Map<tbCuidados>(item);
            var List = _botanicaServicios.InsertarCuidados(cuidados);
            return Ok(List);
        }

        [HttpPost("Update")]
        public IActionResult ActualizarCuidado(CuidadosViewModel item)
        {
            var cuidados = _mapper.Map<tbCuidados>(item);
            var List = _botanicaServicios.ActualizarCuidado(cuidados);
            return Ok(List);
        }

        [HttpPost("Delte")]
        public IActionResult EliminarCuidado(CuidadosViewModel item)
        {
            var cuidados = _mapper.Map<tbCuidados>(item);
            var List = _botanicaServicios.EliminarCuidado(cuidados);
            return Ok(List);
        }
    }
}
