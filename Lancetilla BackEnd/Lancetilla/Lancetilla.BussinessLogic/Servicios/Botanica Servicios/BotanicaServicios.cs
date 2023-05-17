using Lancetilla.DataAccess.Repositories.Bota;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace Lancetilla.BussinessLogic.Servicios.Botanica_Servicios
{
    public class BotanicaServicios
    {

        private readonly AreasBotanicasRepository _areasBotanicasRepository;
        private readonly CuidadosRepository _cuidadosRepository;
        private readonly PlantasRepository _plantasRepository;
      

        public BotanicaServicios(AreasBotanicasRepository areasBotanicasRepository, 
                                 CuidadosRepository cuidadosRepository, 
                                 PlantasRepository plantasRepository)
        {
            _areasBotanicasRepository = areasBotanicasRepository;
            _cuidadosRepository = cuidadosRepository;
            _plantasRepository = plantasRepository;
           
        }

        #region AreasBotanicas
        #endregion

        #region Cuidados de plantas

        #endregion

        #region Plantas

        #endregion

     
    }
}
