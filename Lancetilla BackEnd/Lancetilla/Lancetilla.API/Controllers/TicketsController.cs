using AutoMapper;
using Lancetilla.API.Models;
using Lancetilla.BussinessLogic.Servicios.Factura_Servicios;
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

        [HttpPost("InsertarTicket")]
        public IActionResult InsertarTicket(TicketsViewModel item)
        {
            var tickets = _mapper.Map<tbTickets>(item);
            var List = _facturaServicios.InsertarTicket(tickets);
            return Ok(List);
        }
    }
}
