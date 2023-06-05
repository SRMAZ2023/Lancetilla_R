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
    public class PlantasController : ControllerBase
    {

        private readonly BotanicaServicios _botanicaServicios;
        private readonly IMapper _mapper;

        public PlantasController(BotanicaServicios botanicaServicios, IMapper mapper)
        {
            _botanicaServicios = botanicaServicios;
            _mapper = mapper;
        }
        [HttpGet("ListarCuidadosDePlantas")]
        public IActionResult ListarCuidadosDePlantas()
        {
            var list = _botanicaServicios.ListarPlantas();
            return Ok(list);
        }

        [HttpGet("BuscarPlanta/{id}")]
        public IActionResult BuscarPlanta(int id)
        {
            var list = _botanicaServicios.BuscarPlantas(id);
            return Ok(list);
        }

        [HttpPost("InsertarPlanta")]
        public IActionResult InsertarPlanta(PlantasViewModel item)
        {
            var plantas = _mapper.Map<tbPlantas>(item);
            var List = _botanicaServicios.InsertarPlanta(plantas);
            return Ok(List);
        }

        [HttpPost("MantenimientosPorAnimal")]
        public IActionResult MantenimientosPorAnimal(fecaha item)
        {
            var list = _botanicaServicios.MantenimientosPorAnimal(item.fechaInicio, item.FechaFinal);
            return Ok(list);
        }


        [HttpGet("CuidadosPorPlantas")]
        public IActionResult CuidadosPorPlantas()
        {
            var list = _botanicaServicios.CuidadosPorPlantas();

            return Ok(list);
        }

        [HttpGet("ConteoZoologico")]
        public IActionResult ConteoZoologico()
        {
            var list = _botanicaServicios.ConteoZoologico();

            return Ok(list);
        }

        [HttpGet("ConteoBotanica")]
        public IActionResult ConteoBotanica()
        {
            var list = _botanicaServicios.ConteoBotanica();

            return Ok(list);
        }
        [HttpGet("qntienemasmantenimientos")]
        public IActionResult qntienemasmantenimientos()
        {
            var list = _botanicaServicios.qntienemasmantenimientos();

            return Ok(list);
        }
              [HttpGet("AnimalesPorAreas")]
        public IActionResult AnimalesPorAreas()
        {
            var list = _botanicaServicios.AnimalesPorAreas();

            return Ok(list);
        }




        [HttpPost("ActualizarPlanta")]
        public IActionResult ActualizarPlanta(PlantasViewModel item)
        {
            var plantas = _mapper.Map<tbPlantas>(item);
            var List = _botanicaServicios.ActualizarPlanta(plantas);
            return Ok(List);
        }

        [HttpPost("EliminarPlanta")]
        public IActionResult EliminarPlanta(PlantasViewModel item)
        {
            var plantas = _mapper.Map<tbPlantas>(item);
            var List = _botanicaServicios.EliminarPlanta(plantas);
            return Ok(List);
        }


    }
}
