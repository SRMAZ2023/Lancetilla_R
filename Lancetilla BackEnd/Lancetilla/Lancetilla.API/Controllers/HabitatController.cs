using AutoMapper;
using Lancetilla.API.Models;
using Lancetilla.BussinessLogic.Servicios.Zoologico_Servicios;
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
    public class HabitatController : ControllerBase
    {

        private readonly ZoologicoServicios _zoologicoServicios;
        private readonly IMapper _mapper;

        public HabitatController(ZoologicoServicios zoologicoServicios, IMapper mapper)
        {
            _zoologicoServicios = zoologicoServicios;
            _mapper = mapper;
        }
        [HttpGet("ListarHabitat")]
        public IActionResult ListarHabitat()
        {
            var list = _zoologicoServicios.ListarHabitat();
            return Ok(list);
        }

        [HttpPost("InsertHabitat")]
        public IActionResult InsertHabitat(HabitatViewModel item)
        {
            var departamento = _mapper.Map<tbHabitat>(item);
            var List = _zoologicoServicios.InsertarHabitat(departamento);
            return Ok(List);
        }

        [HttpPost("ActualizarHabitat")]
        public IActionResult ActualizarHabitat(HabitatViewModel item)
        {
            var departamento = _mapper.Map<tbHabitat>(item);
            var List = _zoologicoServicios.ActualizarHabitat(departamento);
            return Ok(List);
        }

        [HttpPost("EliminarHabitat")]
        public IActionResult EliminarHabitat(HabitatViewModel item)
        {
            var departamento = _mapper.Map<tbHabitat>(item);
            var List = _zoologicoServicios.EliminarHabitat(departamento);
            return Ok(List);
        }

    }
}
