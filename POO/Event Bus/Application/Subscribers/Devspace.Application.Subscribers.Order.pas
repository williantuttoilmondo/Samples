unit Devspace.Application.Subscribers.Order;

interface

uses
  Devspace.Application.EventBus.Intf;

type
  TOrderSubscribers = class
  public
    class procedure Register(const AEventBus: IEventBus);
  end;

implementation

uses
  System.SysUtils,
  Devspace.Application.EventBus.Facade,
  Devspace.Domain.Events.OrderCreated,
  Devspace.Domain.Events.PaymentApproved;

class procedure TOrderSubscribers.Register(const AEventBus: IEventBus);
resourcestring
  EmailMessage = '[EMAIL] Enviando confirmação do pedido %s';
  AuditMessage = '[AUDITORIA] Evento %s registrado em %s';
  DashboardMessage = '[DASHBOARD] Total vendido atualizado: %f';
  PaymentMessage = '[PAGAMENTO] Pagamento aprovado: %s';
  NotificationMessage = '[NOTIFICAÇÃO] Pedido %s teve pagamento aprovado.';
begin
  TEventBusFacade.Subscribe<IOrderCreated>(AEventBus,
    procedure(const AEvent: IOrderCreated)
    begin
      Writeln(Format(EmailMessage, [AEvent.OrderId]));
    end);
  TEventBusFacade.Subscribe<IOrderCreated>(AEventBus,
    procedure(const AEvent: IOrderCreated)
    begin
      Writeln(Format(AuditMessage, [AEvent.Name, DateTimeToStr(AEvent.CreatedAt)]));
    end);
  TEventBusFacade.Subscribe<IOrderCreated>(AEventBus,
    procedure(const AEvent: IOrderCreated)
    begin
      Writeln(Format(DashboardMessage, [AEvent.Total]));
    end);
  TEventBusFacade.Subscribe<IPaymentApproved>(AEventBus,
    procedure(const AEvent: IPaymentApproved)
    begin
      Writeln(Format(PaymentMessage, [AEvent.PaymentId]));
    end);
  TEventBusFacade.Subscribe<IPaymentApproved>(AEventBus,
    procedure(const AEvent: IPaymentApproved)
    begin
      Writeln(Format(NotificationMessage, [AEvent.OrderId]));
    end);
end;

end.

