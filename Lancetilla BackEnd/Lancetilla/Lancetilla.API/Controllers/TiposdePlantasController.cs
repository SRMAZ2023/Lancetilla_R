﻿using AutoMapper;
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
    public class TiposdePlantasController : ControllerBase
    {
        private readonly BotanicaServicios _botanicaServicios;
        private readonly IMapper _mapper;

        public TiposdePlantasController(BotanicaServicios botanicaServicios, IMapper mapper)
        {
            _botanicaServicios = botanicaServicios;
            _mapper = mapper;
        }

    [HttpGet("ListarTiposPlantas")]
        public IActionResult ListarTiposPlantas()
        {
            var list = _botanicaServicios.ListarTiposPlantas();
            return Ok(list);
        }
        /*
        [HttpGet("BuscarAnimal/{id}")]
        public IActionResult BuscarPlanta(int id)
        {
            var list = _zoologicoServicios.BuscarAnimales(id);
            return Ok(list);
        }
    

        [HttpPost("InsertarAnimales")]
        public IActionResult InsertarAnimales(AnimalesViewModel item)
        {
            var animales = _mapper.Map<tbAnimales>(item);
            var List = _zoologicoServicios.InsertarAnimales(animales);
            return Ok(List);
        }

        [HttpPost("ActualizarAnimales")]
        public IActionResult ActualizarAnimales(AnimalesViewModel item)
        {
            var animales = _mapper.Map<tbAnimales>(item);
            var List = _zoologicoServicios.ActualizarAnimales(animales);
            return Ok(List);
        }

        [HttpPost("EliminarAnimales")]
        public IActionResult EliminarAnimales(AnimalesViewModel item)
        {
            var animales = _mapper.Map<tbAnimales>(item);
            var List = _zoologicoServicios.EliminarAnimales(animales);
            return Ok(List);
        }

        [HttpGet("AnimalesPorArea")]
        public IActionResult AnimalesPorArea()
        {
            var list = _zoologicoServicios.AnimalesPorArea();

            return Ok(list);
        }
        [HttpGet("AnimalesPorHabitat")]
        public IActionResult AnimalesPorHabitat()
        {
            var list = _zoologicoServicios.AnimalesPorHabitat();

            return Ok(list);
        }*/
    }
}
