
using Lancetilla.DataAccess;

using Microsoft.Extensions.DependencyInjection;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Lancetilla.BussinessLogic
{
    public static class ServiceConfiguration
    {
        public static void DataAccess(this IServiceCollection services, string connection)
        {
            //Lancetilla.BuildConnectionString(connection);

           /* //Acceso
            services.AddScoped<PantallasRepository>();
            services.AddScoped<RolesPorPantallaRepository>();
            services.AddScoped<RolesRepository>();
            services.AddScoped<UsuariosRepository>();

            //Evento
            services.AddScoped<EventosRepository>();
            services.AddScoped<FacturasRepository>();
            services.AddScoped<InventarioRepository>();
            services.AddScoped<ProveedoresRepository>();
            services.AddScoped<ServiciosRepository>();
            services.AddScoped<PaqueteDetallesRepository>();
            services.AddScoped<Paquetes_EncabezadoRepository>();
            services.AddScoped<PedidosRepository>();
            services.AddScoped<PedidosDetalllesRepository>();
            services.AddScoped<GraficaRepository>();
            services.AddScoped<RegistroRepository>();


            //General
            services.AddScoped<DepartamentosRepository>();
            services.AddScoped<EstadosCivilesRepository>();
            services.AddScoped<MunicipiosRepository>();
            services.AddScoped<EmpleadoRepository>();
            services.AddScoped<ClienteRepository>();
            services.AddScoped<TipoPagoRepository>();
            services.AddScoped<DireccionesRepository>();

            services.AddScoped<GraficaRepository>();*/

        }


        public static void BussinessLogic(this IServiceCollection services)
        {
           /* services.AddScoped<GeneralServices>();
            services.AddScoped<AccesoServices>();
            services.AddScoped<EventoServices>();*/
        }
    }
}
