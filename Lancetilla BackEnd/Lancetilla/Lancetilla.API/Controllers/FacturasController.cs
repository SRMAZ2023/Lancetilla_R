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

        [HttpPost("EncabezadoFactura")]
        public IActionResult EncabezadoFactura(FacturasViewModel item)
        {
            var municipios = _mapper.Map<tbFacturas>(item);
            var List = _facturaServicios.EncabezadoFactura(municipios);
            return Ok(List);
        }

        [HttpPost("TablaFactura")]
        public IActionResult TablaFactura(FacturasViewModel item)
        {
            var municipios = _mapper.Map<tbFacturas>(item);
            var List = _facturaServicios.TablaFactura(municipios);
            return Ok(List);
        }

        [HttpPost("InsertFactura")]
        public IActionResult InsertFactura(FacturasViewModel item)
        {
            var visitantes = _mapper.Map<tbFacturas>(item);
            var List = _facturaServicios.InsertFactura(visitantes);

            List.Data = _mapper.Map<FacturasViewModel>(List.Data);
            return Ok(List);
        }

        [HttpPost("InsertFacturaMetodoPago")]
        public IActionResult InsertFacturaMetodoPago(FacturasViewModel item)
        {
            var visitantes = _mapper.Map<tbFacturas>(item);
            var List = _facturaServicios.InsertarMetodoDePagoFactura(visitantes);
 
            return Ok(List);
        }

    }
}
