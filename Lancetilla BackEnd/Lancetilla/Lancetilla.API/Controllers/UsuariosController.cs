using AutoMapper;
using Lancetilla.API.Models;
using Lancetilla.BussinessLogic.Servicios.Acceso_Servicios;
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


        [HttpPost("ValidarLogin")]
        public IActionResult ValidarLogin(UsuariosViewModel item)
        {
            var resultMapeado = _mapper.Map<tbUsuarios>(item);

            var respuesta = _AccesoServicios.InicioSession(resultMapeado);

            respuesta.Data = _mapper.Map<UsuariosViewModel>(respuesta.Data);

            return Ok(respuesta);
        }
    }
}
