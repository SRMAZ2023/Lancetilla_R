using AutoMapper;
using Lancetilla.BussinessLogic.Servicios.Acceso_Servicios;
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
    public class UsuariosController : ControllerBase
    {

        private readonly AccesoServicios _AccesoServicios;
        private readonly IMapper _mapper;

        public UsuariosController(AccesoServicios accesoServicios, IMapper mapper)
        {
            _AccesoServicios = accesoServicios;
            _mapper = mapper;
        }
        [HttpGet("ListarUsuarios")]
        public IActionResult ListarUsuarios()
        {
            var list = _AccesoServicios.ListarUsuarios();
            return Ok(list);
        }
    }
}
