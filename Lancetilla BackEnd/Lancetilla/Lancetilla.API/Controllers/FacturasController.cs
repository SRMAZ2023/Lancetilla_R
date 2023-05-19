using AutoMapper;
using Lancetilla.BussinessLogic.Servicios.Factura_Servicios;
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
    public class FacturasController : ControllerBase
    {

        private readonly FacturaServicios  _facturaServicios;
        private readonly IMapper _mapper;

        public FacturasController(FacturaServicios  facturaServicios, IMapper mapper)
        {
            _facturaServicios = facturaServicios;
            _mapper = mapper;
        }
        [HttpGet("ListarFacturas")]
        public IActionResult ListarFacturas()
        {
            var list = _facturaServicios.ListarFacturas();
            return Ok(list);
        }
    }
}
