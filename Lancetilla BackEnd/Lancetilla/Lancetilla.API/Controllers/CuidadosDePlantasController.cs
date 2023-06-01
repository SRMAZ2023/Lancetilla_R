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
            var list = _botanicaServicios.ListarCuidados();
            return Ok(list);
        }

        [HttpPost("InsertarCuidados")]
        public IActionResult InsertarCuidados(CuidadosDePlantaViewModel item)
        {
            var  cuidados = _mapper.Map<tbCuidados>(item);
            var List = _botanicaServicios.InsertarCuidados(cuidados);
            return Ok(List);
        }

        [HttpPost("ActualizarCuidado")]
        public IActionResult ActualizarCuidado(CuidadosDePlantaViewModel item)
        {
            var cuidados = _mapper.Map<tbCuidados>(item);
            var List = _botanicaServicios.ActualizarCuidado(cuidados);
            return Ok(List);
        }

        [HttpPost("EliminarCuidado")]
        public IActionResult EliminarCuidado(CuidadosDePlantaViewModel item)
        {
            var cuidados = _mapper.Map<tbCuidados>(item);
            var List = _botanicaServicios.EliminarCuidado(cuidados);
            return Ok(List);
        }
    }
}
