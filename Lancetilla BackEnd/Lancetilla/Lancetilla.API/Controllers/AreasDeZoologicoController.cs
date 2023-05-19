using AutoMapper;
using Lancetilla.BussinessLogic.Servicios.Zoologico_Servicios;
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
    }
}
