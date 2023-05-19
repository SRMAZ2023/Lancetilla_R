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
    public class AreasDeZoologicoController : ControllerBase
    {

        private readonly ZoologicoServicios _zoologicoServicios;
        private readonly IMapper _mapper;

        public AreasDeZoologicoController(ZoologicoServicios zoologicoServicios, IMapper mapper)
        {
            _zoologicoServicios = zoologicoServicios;
            _mapper = mapper;
        }
        [HttpGet("ListarAreasDeZoologico")]
        public IActionResult ListarAreasDeZoologico()
        {
            var list = _zoologicoServicios.ListarAreasDeZoologico();
            return Ok(list);
        }

        [HttpPost("InsertarAreasDeZoologico")]
        public IActionResult InsertarAreasDeZoologico(AreasDeZoologicoViewModel item)
        {
            var  areasZoologico = _mapper.Map<tbAreasZoologico>(item);
            var List = _zoologicoServicios.InsertarAreasDeZoologico(areasZoologico);
            return Ok(List);
        }

        [HttpPost("ActualizarAreasDeZoologico")]
        public IActionResult ActualizarAreasDeZoologico(AreasDeZoologicoViewModel item)
        {
            var areasZoologico = _mapper.Map<tbAreasZoologico>(item);
            var List = _zoologicoServicios.ActualizarAreasDeZoologico(areasZoologico);
            return Ok(List);
        }

        [HttpPost("EliminarAreasDeZoologico")]
        public IActionResult EliminarAreasDeZoologico(AreasDeZoologicoViewModel item)
        {
            var areasZoologico = _mapper.Map<tbAreasZoologico>(item);
            var List = _zoologicoServicios.EliminarAreasDeZoologico(areasZoologico);
            return Ok(List);
        }
    }
}
