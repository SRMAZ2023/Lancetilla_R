using Lancetilla.DataAccess.Repositories.Acce;
using Lancetilla.Entities.Entities;
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
        public IEnumerable<VW_tbUsuarios> ListarUsuarios()
        {
            try
            {
                var list = _usuariosRepository.ListarUsuarios();
                return list;
            }
            catch (Exception ex)
            {

                return Enumerable.Empty<VW_tbUsuarios>();

            }
        }

        public IEnumerable<tbUsuarios> ListarEmpleadoNoTieneUser()
        {
            try
            {
                var list = _usuariosRepository.ListarEmpleadoNoTieneUser();
                return list;
            }
            catch (Exception ex)
            {

                return Enumerable.Empty<tbUsuarios>();
            }
        }

        public ServiceResult EliminarUsuario(tbUsuarios item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _usuariosRepository.Delete(item);
                if (map.CodeStatus == 200)
                {
                    return result.SetMessage(map.MessageStatus, ServiceResultType.Success);

                }
                else if (map.CodeStatus == 409)
                {
                    return result.SetMessage(map.MessageStatus, ServiceResultType.Conflict);
                }
                else
                {
                    return result.SetMessage(map.MessageStatus, ServiceResultType.Error);
                }
            }
            catch (Exception ex)
            {
                return result.Error(ex.Message);
            }
        }

        public ServiceResult InsertarUsuario(tbUsuarios item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _usuariosRepository.Insert(item);
                if (map.CodeStatus == 200)
                {
                    return result.SetMessage(map.MessageStatus, ServiceResultType.Success);

                }
                else if (map.CodeStatus == 409)
                {
                    return result.SetMessage(map.MessageStatus, ServiceResultType.Conflict);
                }
                else
                {
                    return result.SetMessage(map.MessageStatus, ServiceResultType.Error);
                }
            }
            catch (Exception ex)
            {
                return result.Error(ex.Message);
            }
        }

        public ServiceResult ActualizarUsuario(tbUsuarios item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _usuariosRepository.Update(item);
                if (map.CodeStatus == 200)
                {
                    return result.SetMessage(map.MessageStatus, ServiceResultType.Success);

                }
                else if (map.CodeStatus == 409)
                {
                    return result.SetMessage(map.MessageStatus, ServiceResultType.Conflict);
                }
                else
                {
                    return result.SetMessage(map.MessageStatus, ServiceResultType.Error);
                }
            }
            catch (Exception ex)
            {
                return result.Error(ex.Message);
            }
        }

        public ServiceResult InicioSession(tbUsuarios item)
        {
            var resultado = new ServiceResult();

            try
            {
                var usuario = _usuariosRepository.InicioSession(item);
                return resultado.Ok(usuario);
            }
            catch (Exception ex)
            {
                return resultado.Error(ex.Message);
            }
        }

        #endregion

        #region Roles Por Pantalla

        public ServiceResult InsertarRolPorPantalla(tbRolesPantallas item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _rolesPorPantallaRepository.Insert(item);
                if (map.CodeStatus == 200)
                {
                    return result.SetMessage(map.MessageStatus, ServiceResultType.Success);

                }
                else if (map.CodeStatus == 409)
                {
                    return result.SetMessage(map.MessageStatus, ServiceResultType.Conflict);
                }
                else
                {
                    return result.SetMessage(map.MessageStatus, ServiceResultType.Error);
                }
            }
            catch (Exception ex)
            {
                return result.Error(ex.Message);
            }
        }

        public ServiceResult EliminarRolPorPantalla(tbRolesPantallas item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _rolesPorPantallaRepository.Delete(item);
                if (map.CodeStatus == 200)
                {
                    return result.SetMessage(map.MessageStatus, ServiceResultType.Success);

                }
                else if (map.CodeStatus == 409)
                {
                    return result.SetMessage(map.MessageStatus, ServiceResultType.Conflict);
                }
                else
                {
                    return result.SetMessage(map.MessageStatus, ServiceResultType.Error);
                }
            }
            catch (Exception ex)
            {
                return result.Error(ex.Message);
            }
        }

        public IEnumerable<tbRolesPantallas> PantallasPorRol(tbRolesPantallas items)
        {
            try
            {
                var list = _rolesPorPantallaRepository.PantallasPorRol(items);
                return list;
            }
            catch (Exception ex)
            {

                return Enumerable.Empty<tbRolesPantallas>();
            }
        }

        public IEnumerable<tbRolesPantallas> PantallasSinRol(tbRolesPantallas items)
        {
            try
            {
                var list = _rolesPorPantallaRepository.PantallasSinRol(items);
                return list;
            }
            catch (Exception ex)
            {

                return Enumerable.Empty<tbRolesPantallas>();
            }
        }

        #endregion

        #region Roles

        public IEnumerable<VW_tbRoles> ListarRoles()
        {
            try
            {
                var list = _rolesRepository.ListarRoles();
                return list;
            }
            catch (Exception ex)
            {

                return Enumerable.Empty<VW_tbRoles>();

            }
        }
       
        public ServiceResult InsertarRol(tbRoles item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _rolesRepository.Insert(item);
                if (map.role_UserCreacion == 200)
                {
                   
                    return result.Ok(map);

                }
                else if (map.role_UserCreacion == 409)
                {


                    return result.SetMessage(map.role_Descripcion, ServiceResultType.Success);
                }
                else
                {
                    return result.SetMessage(map.role_Descripcion, ServiceResultType.Error);
                }
            }
            catch (Exception ex)
            {
                return result.Error(ex.Message);
            }
        }

        public ServiceResult ActualizarRol(tbRoles item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _rolesRepository.Update(item);
                if (map.CodeStatus == 200)
                {
                    return result.SetMessage(map.MessageStatus, ServiceResultType.Success);

                }
                else if (map.CodeStatus == 409)
                {
                    return result.SetMessage(map.MessageStatus, ServiceResultType.Conflict);
                }
                else
                {
                    return result.SetMessage(map.MessageStatus, ServiceResultType.Error);
                }
            }
            catch (Exception ex)
            {
                return result.Error(ex.Message);
            }
        }

        public ServiceResult EliminarRol(tbRoles item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _rolesRepository.Delete(item);
                if (map.CodeStatus == 200)
                {
                    return result.SetMessage(map.MessageStatus, ServiceResultType.Success);

                }
                else if (map.CodeStatus == 409)
                {
                    return result.SetMessage(map.MessageStatus, ServiceResultType.Conflict);
                }
                else
                {
                    return result.SetMessage(map.MessageStatus, ServiceResultType.Error);
                }
            }
            catch (Exception ex)
            {
                return result.Error(ex.Message);
            }
        }



        #endregion

        #region Pantallas

        public IEnumerable<tbPantallas> ListarMunicipioPorId(tbRoles item)
        {
            try
            {
                var list = _pantallasRepository.PantallasPorRol(item);
                return list;
            }
            catch (Exception ex)
            {

                return Enumerable.Empty<tbPantallas>();
            }
        }

        #endregion

    }
}
