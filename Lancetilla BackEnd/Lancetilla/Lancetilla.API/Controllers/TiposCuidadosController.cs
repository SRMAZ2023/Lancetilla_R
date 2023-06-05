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
    public class TiposCuidadosController : ControllerBase
    {
        private readonly BotanicaServicios _botanicaServicios;
        private readonly IMapper _mapper;

        public TiposCuidadosController(BotanicaServicios botanicaServicios, IMapper mapper)
        {
            _botanicaServicios = botanicaServicios;
            _mapper = mapper;
        }

        [HttpGet("MantenimientosPorAnimal")]
        public IActionResult MantenimientosPorAnimal()
        {
            var list = _botanicaServicios.MantenimientoPorAnimal();

            return Ok(list);
        }


        [HttpGet("List")]
        public IActionResult ListarTiposPlantas()
        {
            var list = _botanicaServicios.ListarTiposCuidados();
            return Ok(list);
        }
        [HttpGet("CuidadoPorPlanta")]
        public IActionResult CuidadoPorPlanta()
        {
            var list = _botanicaServicios.CuidadoPorPlanta();

            return Ok(list);
        }



        [HttpPost("Insert")]
        public IActionResult InsertarTiposCuidados(tbTiposCuidadosViewModel item)
        {
            var animales = _mapper.Map<tbTiposCuidados>(item);
            var List = _botanicaServicios.InsertarTiposCuidados(animales);
            return Ok(List);
        }

        [HttpPost("Update")]
        public IActionResult ActualizarTiposCuidados(tbTiposCuidadosViewModel item)
        {
            var animales = _mapper.Map<tbTiposCuidados>(item);
            var List = _botanicaServicios.ActualizarTiposCuidados(animales);
            return Ok(List);
        }

        [HttpPost("Delete")]
        public IActionResult EliminarTiposCuidados(tbTiposCuidadosViewModel item)
        {
            var animales = _mapper.Map<tbTiposCuidados>(item);
            var List = _botanicaServicios.EliminarTiposCuidados(animales);
            return Ok(List);
        }

   
    }
}