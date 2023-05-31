using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Lancetilla.DataAccess.Repositories.Fact;
using Lancetilla.Entities.Entities;

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

        public IEnumerable<VW_tbFacturas> ListarFacturas()
        {
            try
            {
                var list = _facturaRepository.ListarFacturas();
                return list;
            }
            catch (Exception ex)
            {

                return Enumerable.Empty<VW_tbFacturas>();

            }
        }


        public IEnumerable<tbFacturas> EncabezadoFactura(tbFacturas item)
        {
            try
            {
                var list = _facturaRepository.EncabezadoFactura(item);
                return list;
            }
            catch (Exception ex)
            {

                return Enumerable.Empty<tbFacturas>();
            }
        }

        public IEnumerable<tbFacturas> TablaFactura(tbFacturas item)
        {
            try
            {
                var list = _facturaRepository.TablaFactura(item);
                return list;
            }
            catch (Exception ex)
            {

                return Enumerable.Empty<tbFacturas>();
            }
        }
        #endregion

        #region Factura Detalle
        public IEnumerable<VW_FacturasDetalle> ListarFacturaDetalles()
        {
            try
            {
                var list = _facturaDetalleRepository.ListarFacturasDetalles();
                return list;
            }
            catch (Exception ex)
            {

                return Enumerable.Empty<VW_FacturasDetalle>();

            }
        }
        #endregion

        #region Metodo de Pago
        public IEnumerable<VW_tbMetodosPago> ListarMetodosDePago()
        {
            try
            {
                var list = _metodoDePagoRepository.ListarMetodosDePago();
                return list;
            }
            catch (Exception ex)
            {

                return Enumerable.Empty<VW_tbMetodosPago>();

            }
        }

        public ServiceResult InsertarMetodoDePago(tbMetodosPago item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _metodoDePagoRepository.Insert(item);
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

        public ServiceResult ActualizarMetodoDePago(tbMetodosPago item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _metodoDePagoRepository.Update(item);
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

        public ServiceResult EliminarMetodoDePago(tbMetodosPago item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _metodoDePagoRepository.Delete(item);
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

        #region Tickets
        public IEnumerable<VW_tbTickets> ListarTickets()
        {
            try
            {
                var list = _ticketsRepository.ListarTickets();
                return list;
            }
            catch (Exception ex)
            {

                return Enumerable.Empty<VW_tbTickets>();

            }
        }

        public ServiceResult InsertarTicket(tbTickets item)
        {
            var result = new ServiceResult();
            try
            {
                var map = _ticketsRepository.Insert(item);
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



    }
}
