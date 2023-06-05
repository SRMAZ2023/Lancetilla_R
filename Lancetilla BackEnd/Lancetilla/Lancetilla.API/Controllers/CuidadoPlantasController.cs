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
    public class CuidadoPlantasController : ControllerBase
    {

        private readonly BotanicaServicios _botanicaServicios;
        private readonly IMapper _mapper;

        public CuidadoPlantasController(BotanicaServicios botanicaServicios, IMapper mapper)
        {
            _botanicaServicios = botanicaServicios;
            _mapper = mapper;
        }
        [HttpGet("List")]
        public IActionResult ListarCuidadoPlantas()
        {
            var list = _botanicaServicios.ListarCuidadoPlantas();
            return Ok(list);
        }


        [HttpPost("Buscar")]
        public IActionResult BuscarMantenimientoAnimal(CuidadoPlantasViewModel item)
        {
            var mantenimientos = _mapper.Map<tbCuidadoPlanta>(item);
            var List = _botanicaServicios.BuscarCuidadoPlantas(item.arbo_Id);
            return Ok(List);
        }
        [HttpPost("Buscar2")]
        public IActionResult BuscarMantenimientoAnimal2(CuidadoPlantasViewModel item)
        {
            var mantenimientos = _mapper.Map<tbCuidadoPlanta>(item);
            var List = _botanicaServicios.BuscarCuidadoPlantas2(item.arbo_Id);
            return Ok(List);
        }

        [HttpPost("Inser")]
        public IActionResult InsertarCuidadoPlantas(CuidadoPlantasViewModel item)
        {
            var CuidadoPlantas = _mapper.Map<tbCuidadoPlanta>(item);
            var List = _botanicaServicios.InsertarCuidadoPlantas(CuidadoPlantas);
            return Ok(List);
        }


        [HttpPost("Update")]
        public IActionResult ActualizarCuidadoPlantas(CuidadoPlantasViewModel item)
        {
            var CuidadoPlantas = _mapper.Map<tbCuidadoPlanta>(item);
            var List = _botanicaServicios.ActualizarCuidadoPlantas(CuidadoPlantas);
            return Ok(List);
        }

        [HttpPost("Delete")]
        public IActionResult EliminarCuidadoPlantas(CuidadoPlantasViewModel item)
        {
            var CuidadoPlantas = _mapper.Map<tbCuidadoPlanta>(item);
            var List = _botanicaServicios.EliminarCuidadoPlantas(CuidadoPlantas);
            return Ok(List);
        }
    }
}

