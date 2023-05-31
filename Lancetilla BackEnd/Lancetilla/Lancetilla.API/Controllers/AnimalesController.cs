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
    public class AnimalesController : ControllerBase
    {

        private readonly ZoologicoServicios _zoologicoServicios;
        private readonly IMapper _mapper;

        public AnimalesController(ZoologicoServicios zoologicoServicios, IMapper mapper)
        {
            _zoologicoServicios = zoologicoServicios;
            _mapper = mapper;
        }
        [HttpGet("ListarAnimales")]
        public IActionResult ListarAnimales()
        {
            var list = _zoologicoServicios.ListarAnimales();
            return Ok(list);
        }

        [HttpPost("BuscarAnimal")]
        public IActionResult BuscarAnimales(AnimalesViewModel item)
        {
            var mantenimientos = _mapper.Map<tbAnimales>(item);
            var List = _zoologicoServicios.BuscarAnimales(item.raza_Id);
            return Ok(List);
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
        }
    }
}
