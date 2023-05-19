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
    public class AlimentacionController : ControllerBase
    {

        private readonly ZoologicoServicios  _zoologicoServicios;
        private readonly IMapper _mapper;

        public AlimentacionController(ZoologicoServicios  zoologicoServicios, IMapper mapper)
        {
            _zoologicoServicios = zoologicoServicios;
            _mapper = mapper;
        }
        [HttpGet("ListarAlimentacion")]
        public IActionResult ListarAlimentacion()
        {
            var list = _zoologicoServicios.ListarAlimentacion();
            return Ok(list);
        }
    }
}
