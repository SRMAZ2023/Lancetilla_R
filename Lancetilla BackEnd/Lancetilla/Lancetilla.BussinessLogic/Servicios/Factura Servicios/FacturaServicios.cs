using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Lancetilla.DataAccess.Repositories.Fact;

namespace Lancetilla.BussinessLogic.Servicios.Factura_Servicios
{
    public class FacturaServicios
    {

        private readonly FacturaRepository _facturaRepository;
        private readonly FacturaDetalleRepository _facturaDetalleRepository;
        private readonly MetodoDePagoRepository _metodoDePagoRepository;
        private readonly TicketsRepository _ticketsRepository;


        public FacturaServicios(FacturaRepository facturaRepository,
                                 FacturaDetalleRepository  facturaDetalleRepository,
                                 MetodoDePagoRepository  metodoDePagoRepository,
                                 TicketsRepository ticketsRepository)
        {
            _facturaRepository = facturaRepository;
            _facturaDetalleRepository = facturaDetalleRepository;
            _metodoDePagoRepository = metodoDePagoRepository;
            _ticketsRepository = ticketsRepository;

        }

        #region Factura
        #endregion

        #region Factura Detalle

        #endregion

        #region Metodo de Pago

        #endregion

        #region Tickets

        #endregion



    }
}
