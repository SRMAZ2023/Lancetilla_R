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

        public static string InsertarUsuarios = "mant.UDP_tbUsuarios_INSERT";

        public static string ActualizarUsuarios = "mant.UDP_tbUsuarios_UPDATE";

        public static string EliminarUsuario = "mant.UDP_tbUsuarios_DELETE";

       

        #endregion

        #region Roles Por Pantalla

        #endregion

        #region Roles

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

        public static string CargarInfoEmpleados = "mant.UDP_tbEmpleados_FIND";

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

        #endregion

        ////////////////////////////////////////////////////////////////////////////////////////////// 

        #region Apartado de Botanica

        #region Areas de Botanica

        //  public static string InsertarDepartamentos = "mant.UDP_tbDepartamentos_CREATE";

        //public static string ActualizarDepartamentos = "mant.UDP_tbDepartamentos_UPDATE";

        // public static string EliminarDepartamentos = "mant.UDP_tbDepartamentos_DELETE";



        #endregion

        #region Cuidados de Plantas

        // public static string InsertarEstadoCivil = "mant.UDP_tbEstadosCiviles_CREATE";

        // public static string ActualizarEstadoCivil = "mant.UDP_tbEstadosCiviles_UPDATE";

        // public static string EliminarEstadoCivil = "mant.UDP_tbEstadosCiviles_DELETE";


        #endregion

        #region Plantas

        // public static string InsertarMunicipios = "mant.UDP_tbMunicipios_CREATE";

        // public static string ActualizarMunicipios = "mant.UDP_tbMunicipios_UPDATE";

        // public static string EliminarMunicipios = "mant.UDP_tbMunicipios_DELETE";

        // public static string CargarMunicipiosPorDepa = "mant.UDP_tbMunicipios_MUNISPORDEPTO";


        #endregion

        #endregion

        //////////////////////////////////////////////////////////////////////////////////////////////    

        #region Apartado de Factura

        #endregion

        ////////////////////////////////////////////////////////////////////////////////////////////// 

        #region Apartado de Zoologico

        public static string InsertarEspecie = "zool.UDP_tbtbEspecies_CREATE";

        public static string ActualizarEspecie = "zool.UDP_tbEspecie_UPDATE";

        public static string EliminarEspecie = "zool.UDP_tbEspecies_DELETE";
        #endregion

        ////////////////////////////////////////////////////////////////////////////////////////////// 

    }
}
