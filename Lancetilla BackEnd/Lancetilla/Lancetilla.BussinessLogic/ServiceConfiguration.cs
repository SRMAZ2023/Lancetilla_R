
using Microsoft.Extensions.DependencyInjection;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;


using Lancetilla.BussinessLogic.Servicios.Acceso_Servicios;
using Lancetilla.BussinessLogic.Servicios.Botanica_Servicios;
using Lancetilla.BussinessLogic.Servicios.Factura_Servicios;
using Lancetilla.BussinessLogic.Servicios.Mantenimiento_Servicios;
using Lancetilla.BussinessLogic.Servicios.Zoologico_Servicios;

using Lancetilla.DataAccess.Repositories.Acce;
using Lancetilla.DataAccess.Repositories.Bota;
using Lancetilla.DataAccess.Repositories.Fact;
using Lancetilla.DataAccess.Repositories.Mant;
using Lancetilla.DataAccess.Repositories.Zool;


namespace Lancetilla.BussinessLogic
{
    public static class ServiceConfiguration
    {
        public static void DataAccess(this IServiceCollection services, string connection)
        {
            

            Lancetilla.DataAccess.Lancetilla.BuildConnectionString(connection);
            
            //Acceso
            services.AddScoped<PantallasRepository>();
            services.AddScoped<RolesPorPantallaRepository>();
            services.AddScoped<RolesRepository>();
            services.AddScoped<UsuariosRepository>();

            //Mantenimiento
            services.AddScoped<CargosRepository>();
            services.AddScoped<DepartamentosRepository>();
            services.AddScoped<EmpleadosRepository>();
            services.AddScoped<EstadoCivilesRepository>();
            services.AddScoped<MantenimientosRepository>();
            services.AddScoped<MunicipiosRepository>();
            services.AddScoped<TiposDeMantenimientoRepository>();
            services.AddScoped<VisitantesRepository>();
            services.AddScoped<MantenimientoPorAnimalRepository>();


            //Botanica
            services.AddScoped<AreasBotanicasRepository>();
            services.AddScoped<CuidadosRepository>();
            services.AddScoped<PlantasRepository>();
            services.AddScoped<TiposCuidados>();

            //Factura
            services.AddScoped<FacturaDetalleRepository>();
            services.AddScoped<FacturaRepository>();
            services.AddScoped<MetodoDePagoRepository>();
            services.AddScoped<TicketsRepository>();

            //Zoologico
            services.AddScoped<AlimentacionRepository>();
            services.AddScoped<AnimalesRepository>();
            services.AddScoped<AreasZoologicoRepository>();
            services.AddScoped<EspeciesRepository>();
            services.AddScoped<HabitatRepository>();


        }


        public static void BussinessLogic(this IServiceCollection services)
        {
            services.AddScoped<AccesoServicios>();
            services.AddScoped<FacturaServicios>();
            services.AddScoped<MantenimientoServicios>();
            services.AddScoped<ZoologicoServicios>();
            services.AddScoped<BotanicaServicios>();
        }
    }
}
