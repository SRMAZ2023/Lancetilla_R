using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Lancetilla.DataAccess
{
    public class ScriptsDataBase
    {
        ////////////////////////////////////////////////////////////////////////////////////////////// 

        #region Apartado de Seguridad

        #region Usuarios

        public static string InsertarUsuarios = "acce.UDP_tbUsuarios_INSERT";

        public static string ActualizarUsuarios = "acce.UDP_tbUsuarios_UPDATE";

        public static string EliminarUsuario = "acce.UDP_tbUsuarios_DELETE";

    
        public static string IniciarSesion = "acce.UDP_tbUsuarios_LOGIN";



        #endregion

        #region Roles Por Pantalla

        public static string InsertarRolPorPantalla = "acce.UDP_tbRolesPantalla_CREATE";


        public static string EliminarRolPorPantalla = "acce.UDP_tbRoles_DELETE";


        public static string PantallasRolPorPantalla = "acce.UDP_tbRolesPantallas_PANTALLAROL";



        #endregion

        #region Roles

        public static string InsertarRol = "acce.UDP_tbRoles_CREATE";

        public static string ActualizarRol = "acce.UDP_tbRoles_UPDATE";

        public static string EliminarRol = "acce.UDP_tbRoles_DELETE";


        #endregion

        #region Pantallas

        #endregion

        #endregion

        ////////////////////////////////////////////////////////////////////////////////////////////// 

        #region Apartado de Mantenimiento

        #region Departamentos
        public static string InsertarDepartamentos = "mant.UDP_tbDepartamentos_CREATE";

        public static string ActualizarDepartamentos = "mant.UDP_tbDepartamentos_UPDATE";

        public static string EliminarDepartamentos = "mant.UDP_tbDepartamentos_DELETE";



        #endregion 

        #region Estados Civiles

        public static string InsertarEstadoCivil = "mant.UDP_tbEstadosCiviles_CREATE";

        public static string ActualizarEstadoCivil = "mant.UDP_tbEstadosCiviles_UPDATE";

        public static string EliminarEstadoCivil = "mant.UDP_tbEstadosCiviles_DELETE";


        #endregion

        #region Municipios

        public static string InsertarMunicipios = "mant.UDP_tbMunicipios_CREATE";

        public static string ActualizarMunicipios = "mant.UDP_tbMunicipios_UPDATE";

        public static string EliminarMunicipios = "mant.UDP_tbMunicipios_DELETE";

        public static string CargarMunicipiosPorDepa = "mant.UDP_tbMunicipios_MUNISPORDEPTO";


        #endregion

        #region Visitantes

        public static string InsertarVisitante = "mant.UDP_tbVisitantes_CREATE";

        public static string ActualizarVisitante = "mant.UDP_tbVisitantes_UPDATE";

      

        #endregion

        #region Empleados
        public static string InsertarEmpleados = "mant.UDP_tbEmpleados_CREATE";

        public static string ActualizarEmpleados = "mant.UDP_tbEmpleados_UPDATE";

        public static string EliminarEmpleados = "mant.UDP_tbEmpleados_DELETE";

        public static string UDP_tbEmpleados_FIND = "mant.UDP_tbEmpleados_FIND";

        #endregion

        #region Cargos

        public static string InsertarCargos = "mant.UDP_tbCargos_CREATE";

        public static string ActualizarCargos = "mant.UDP_tbCargos_UPDATE";

        public static string EliminarCargos = "mant.UDP_tbCargos_DELETE";




        #endregion

        #region Mantenimientos

        public static string InsertarMantenimiento = "mant.UDP_tbMantenimientos_CREATE";

        public static string ActualizarMantenimiento = "mant.UDP_tbMantenimientos_UPDATE";

        public static string EliminarMantenimiento = "mant.UDP_tbMantenimientos_DELETE";


        #endregion

        #region Tipos de Mantenimientos

        public static string InsertarTiposDeMantenimiento = "mant.UDP_tbTiposMantenimientos_CREATE";

        public static string ActualizarTiposDeMantenimiento = "mant.UDP_tbTiposMantenimientos_UPDATE";

        public static string EliminarTiposDeMantenimiento = "mant.UDP_tbTiposMantenimientos_DELETE";

        #endregion

        #region Mantenimientos Animal

        public static string InsertarMantenimientoAnimal = "mant.UDP_tbMantenimientosAnimal_CREATE";

        public static string ActualizarMantenimientoAnimal = "mant.UDP_tbMantenimientosAnimal_UPDATE";

        public static string EliminarMantenimientoAnimal = "mant.UDP_tbMantenimientoAnimal_DELETE";


        #endregion


        #endregion

        ////////////////////////////////////////////////////////////////////////////////////////////// 

        #region Apartado de Botanica

        #region Areas de Botanica

        public static string InsertarAreaBotanica = "bota.UDP_tbAreasBotanicas_CREATE";

         public static string ActualizarAreaBotanica = "bota.UDP_tbAreasBotanicas_UPDATE";

         public static string EliminarAreaBotanica = "bota.UDP_tbAreasBotanicas_DELETE";



        #endregion

        #region Cuidados de Plantas

        public static string InsertarCuidados = "bota.UDP_tbCuidados_CREATE";

        public static string ActualizarCuidados = "bota.UDP_tbCuidados_UPDATE";

        public static string EliminarCuidados = "bota.UDP_tbCuidados_DELETE";


        #endregion

        #region Plantas

        public static string InsertarPlantas = "bota.UDP_tbPlantas_CREATE";

        public static string UDP_tbPlantas_FIND = "bota.UDP_tbPlantas_FIND";

        public static string ActualizarPlantas = "bota.UDP_tbPlantas_UPDATE";

        public static string EliminarPlantas = "bota.UDP_tbPlanta_DELETE";


        #endregion

        #endregion

        //////////////////////////////////////////////////////////////////////////////////////////////    

        #region Apartado de Factura

        #region Tickets

        public static string InsertarTicket = "fact.UDP_tbTickets_CREATE";


        #endregion

        #region Metodo de Pago

        public static string InsertarMetodoDePago = "fact.UDP_tbMetodosPago_CREATE";

        public static string ActualizarMetodoDePago = "fact.UDP_tbMetodosPago_UPDATE";

        public static string EliminarMetodoDePago = "fact.UDP_tbMetodosPago_DELETE";


        #endregion

        #region Factura




        #endregion

        #region Factura Detalle




        #endregion


        #endregion

        ////////////////////////////////////////////////////////////////////////////////////////////// 

        #region Apartado de Zoologico

        #region Areas de Zoologico


        public static string InsertarAreaZoologico = "zool.UDP_tbAreasZoologico_CREATE";

        public static string ActualizarAreaZoologico = "zool.UDP_tbAreasZoologico_UPDATE";

        public static string EliminarAreaZoologico = "zool.UDP_tbAreasZoologico_DELETE";

        #endregion


        #region Especies

        public static string InsertarEspecie = "zool.UDP_tbtbEspecies_CREATE";

        public static string ActualizarEspecie = "zool.UDP_tbEspecie_UPDATE";

        public static string EliminarEspecie = "zool.UDP_tbEspecies_DELETE";

        #endregion

       
        #region Alimentacion

        public static string InsertarAlimentacion = "zool.UDP_tbAlimentacion_CREATE";

        public static string ActualizarAlimentacion = "zool.UDP_tbAlimentacion_UPDATE";

        public static string EliminacionAlimentacion = "zool.UDP_tbAlimentacion_DELETE";

        #endregion


        #region Animales

        public static string InsertarAnimales = "zool.UDP_tbAnimales_CREATE";

        public static string ActualizarAnimales = "zool.UDP_tbAnimales_UPDATE";

        public static string EliminacionAnimales = "zool.UDP_tbAnimales_DELETE";

        #endregion


        #endregion

        ////////////////////////////////////////////////////////////////////////////////////////////// 

    }
}
