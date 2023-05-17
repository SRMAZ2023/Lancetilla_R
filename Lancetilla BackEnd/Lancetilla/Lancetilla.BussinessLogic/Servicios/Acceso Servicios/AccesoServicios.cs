using Lancetilla.DataAccess.Repositories.Acce;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Lancetilla.BussinessLogic.Servicios.Acceso_Servicios
{
    public class AccesoServicios
    {

        private readonly UsuariosRepository _usuariosRepository;
        private readonly RolesPorPantallaRepository _rolesPorPantallaRepository;
        private readonly RolesRepository _rolesRepository;
        private readonly PantallasRepository _pantallasRepository;

        public AccesoServicios(PantallasRepository pantallasRepository, RolesRepository rolesRepository, RolesPorPantallaRepository rolesPorPantallaRepository, UsuariosRepository usuariosRepository)
        {
            _usuariosRepository = usuariosRepository;
            _rolesPorPantallaRepository = rolesPorPantallaRepository;
            _rolesRepository = rolesRepository;
            _pantallasRepository = pantallasRepository;
        }

        #region Usuarios
        #endregion

        #region Roles Por Pantalla

        #endregion

        #region Roles

        #endregion

        #region Pantallas

        #endregion

    }
}
