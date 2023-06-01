using AutoMapper;
using Lancetilla.API.Models;
using Lancetilla.Entities.Entities;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;

namespace Lancetilla.API.Extentions
{
    public class MappingProfileExntensions : Profile
    {
        public MappingProfileExntensions()
        {

            //Seguridad
            CreateMap<UsuariosViewModel, tbUsuarios>().ReverseMap();
            CreateMap<RolesPorPantallaViewModel, tbRolesPantallas>().ReverseMap();
            CreateMap<RolViewModel, tbRoles>().ReverseMap();


            //Botanica
            CreateMap<AreasBotanicasViewModel, tbAreasBotanicas>().ReverseMap();
            CreateMap<CuidadosDePlantaViewModel, tbCuidados>().ReverseMap();
            CreateMap<PlantasViewModel, tbPlantas>().ReverseMap();
            CreateMap<TiposdePlantasViewModel, tbTiposPlantas>().ReverseMap();

            //Facturas
            CreateMap<FacturaDetalleViewModel, tbFacturasDetalles>().ReverseMap();
            CreateMap<FacturasViewModel, tbFacturas>().ReverseMap();
            CreateMap<MetodosDePagoViewModel, tbMetodosPago>().ReverseMap();
            CreateMap<TicketsViewModel, tbTickets>().ReverseMap();


            //Mantenimiento
            CreateMap<DepartamentosViewModel, tbDepartamentos>().ReverseMap();
            CreateMap<CargosViewModel, tbCargos>().ReverseMap();
            CreateMap<EmpleadosViewModel, tbEmpleados>().ReverseMap();
            CreateMap<EstadoCivilViewModel, tbEstadosCiviles>().ReverseMap();
            CreateMap<MantenimientosViewModel, tbMantenimientos>().ReverseMap();
            CreateMap<MunicipiosViewModel, tbMunicipios>().ReverseMap();
            CreateMap<TiposDeMantenimientoViewModel, tbTiposMantenimientos>().ReverseMap();
            CreateMap<VisitantesViewModel, tbVisitantes>().ReverseMap();
            CreateMap<MantenimientoAnimalViewModel, tbMantenimientoAnimal>().ReverseMap();


            //Zoologico
            CreateMap<AlimentacionViewModel, tbAlimentacion>().ReverseMap();
            CreateMap<AnimalesViewModel, tbAnimales>().ReverseMap();
            CreateMap<AreasDeZoologicoViewModel, tbAreasZoologico>().ReverseMap();
            CreateMap<EspeciesViewModel, tbEspecies>().ReverseMap();
            CreateMap<ReinosViewModel, tbReinos>().ReverseMap();
            CreateMap<HabitatViewModel, tbHabitat>().ReverseMap();
            CreateMap<RazasViewModel, tbRazas>().ReverseMap();
          
            // CreateMap<, tbHabitat>().ReverseMap();



        }
    }
}
