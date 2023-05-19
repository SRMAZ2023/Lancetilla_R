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
    public class TicketsController : ControllerBase
    {
        private readonly FacturaServicios _facturaServicios;
        private readonly IMapper _mapper;

        public TicketsController(FacturaServicios facturaServicios, IMapper mapper)
        {
            _facturaServicios = facturaServicios;
            _mapper = mapper;
        }
        [HttpGet("ListarTickets")]
        public IActionResult ListarTickets()
        {
            var list = _facturaServicios.ListarTickets();
            return Ok(list);
        }
    }
}
