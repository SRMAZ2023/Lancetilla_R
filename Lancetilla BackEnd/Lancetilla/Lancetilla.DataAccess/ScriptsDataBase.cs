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

        public static string ListarEmpleadoNoTieneUser = "Acce.UDP_tbUsuarios_DDLempleadosTieneusuario";

        public static string IniciarSesion = "acce.UDP_tbUsuarios_LOGIN";



        #endregion

        #region Roles Por Pantalla

        public static string InsertarRolPorPantalla = "acce.UDP_tbRolesPantalla_CREATE";

        public static string EliminarRolPorPantalla = "acce.UDP_tbRolesPantalla_Eliminar";




        public static string PantallasRolSinPantalla = "acce.UDP_tbRolesPantallas_PantallasNoTiene";


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

        public static string CargarFacturasPorVisitante = "fact.UDP_FacturasPorVisitante";



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

        public static string UDP_tbMantenimientosAnimal_SELECT = "mant.UDP_tbMantenimientosAnimal_SELECT";
        public static string UDP_tbMantenimientosAnimal_SELECTMOMENT = "mant.UDP_tbMantenimientosAnimal_SELECTMOMENT";
        public static string UDP_tbMantenimientosAnimal_FIND = "mant.UDP_tbMantenimientosAnimal_FIND";

        public static string InsertarMantenimientoAnimal = "mant.UDP_tbMantenimientosAnimal_CREATE";

        public static string ActualizarMantenimientoAnimal = "mant.UDP_tbMantenimientosAnimal_UPDATE";

        public static string EliminarMantenimientoAnimal = "mant.UDP_tbMantenimientoAnimal_DELETE";


        #endregion


        #endregion

        ////////////////////////////////////////////////////////////////////////////////////////////// 

        #region Apartado de Botanica

        #region Cuidados

        public static string InsertarCuidados = "bota.UDP_tbCuidados_CREATE";

        public static string ActualizarCuidados = "bota.UDP_tbCuidados_UPDATE";

        public static string EliminarCuidados = "bota.UDP_tbCuidados_DELETE";

        #endregion

        #region CuidadoPlantas

        public static string tbCuidadoPlanta_FINDArea = "bota.tbCuidadoPlanta_FINDArea ";

        public static string tbCuidadoPlanta_CREATE = "bota.tbCuidadoPlanta_CREATE";

        public static string tbCuidadoPlanta_UPDATE = "bota.tbCuidadoPlanta_UPDATE";

        public static string tbCuidadoPlanta_DELETE = "bota.tbCuidadoPlanta_DELETE";

        #endregion

        #region TiposCuidados

        public static string tbTiposCuidados_CREATE = "bota.tbTiposCuidados_CREATE";

        public static string tbTiposCuidados_UPDATE = "bota.tbTiposCuidados_UPDATE";

        public static string tbTiposCuidados_DELETE = "bota.tbTiposCuidados_DELETE";


        #endregion

        #region Areas de Botanica

        public static string InsertarAreaBotanica = "bota.UDP_tbAreasBotanicas_CREATE";

         public static string ActualizarAreaBotanica = "bota.UDP_tbAreasBotanicas_UPDATE";

         public static string EliminarAreaBotanica = "bota.UDP_tbAreasBotanicas_DELETE";



        #endregion

        #region Plantas

        public static string InsertarPlantas = "bota.UDP_tbPlantas_CREATE";

        public static string UDP_tbPlantas_FIND = "bota.UDP_tbPlantas_FIND";

        public static string ActualizarPlantas = "bota.UDP_tbPlantas_UPDATE";

        public static string EliminarPlantas = "bota.UDP_tbPlanta_DELETE";


        #endregion

        #region Tipos de plantas

        public static string InsertarTipoPlanta = "bota.UDP_tbTiposPlantas_CREATE";

        public static string ActualizarTipoPlantas = "bota.UDP_tbTiposPlantas_UPDATE";

        public static string EliminarTipoPlantas = "bota.UDP_tbTiposPlantas_DELETE";

        public static string BuscarTipoPlantas = "bota.UDP_tbTiposPlantas_Find";


        #endregion

        #endregion

        //////////////////////////////////////////////////////////////////////////////////////////////    

        #region Apartado de Factura

        #region Tickets

        public static string ActualizarPrecioTicket = "fact.UDP_tbTickets_EditarPrecio";


        #endregion

        #region Metodo de Pago

        public static string InsertarMetodoDePago = "fact.UDP_tbMetodosPago_CREATE";

        public static string ActualizarMetodoDePago = "fact.UDP_tbMetodosPago_UPDATE";

        public static string EliminarMetodoDePago = "fact.UDP_tbMetodosPago_DELETE";


        #endregion

        #region Factura

        public static string EncabezadoFactura = "fact.UPD_CargarInformacionDelEncabezado_Factura";

        public static string TablaFactura = "fact.UPD_CargarInformacionTabla_Factura";

        public static string FacturaInsert = "fact.UDP_InsertarFactura";

        public static string FacturaInsertMetodoPago = "fact.UDP_InsertarFacturaMetodoDePago";


        #endregion

        #region Factura Detalle


        public static string InsertarDetallesFactura = "fact.UDP_InsertarFacturaDetalle";

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

        public static string AnimalesRaza = "zool.UDP_tbAnimales_RAZAS";

        #endregion


        #region Habitat
        public static string InsertarHabitat= "zool.UDP_tbHabitat_CREATE";

        public static string ActualizarHabitat= "zool.UDP_tbHabitat_UPDATE";

        public static string EliminacionHabitat= "zool.UDP_tbHabitat_DELETE";

        #endregion


        #region Razas
        public static string InsertarRaza= "zool.UDP_tbRazas_CREATE";

        public static string ActualizarRaza= "zool.UDP_tbRazas_UPDATE";

        public static string EliminacionRaza= "zool.UDP_tbRazas_DELETE";

        #endregion


        #endregion

        ////////////////////////////////////////////////////////////////////////////////////////////// 

        #region Gráficas

        public static string PlantasPorArea = "bota.UDP_tbPlantas_Grafica";
        public static string AnimalesPorArea = "zool.UDP_tbAnimales_Grafica";
        public static string Visitantes = "mant.UDP_tbVisitantes_Grafica";
        public static string AnimalesPorHabitat = "zool.UDP_tbAnimales_AnimalesHabitatGrafica";


        #endregion


    }
}
