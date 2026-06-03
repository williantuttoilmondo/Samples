unit Devspace.Application.UseCases.CreateOrder;

interface

uses
  Devspace.Application.EventBus.Intf;

type
  TCreateOrderUseCase = class
  strict private
    FEventBus: IEventBus;
  public
    constructor Create(const AEventBus: IEventBus);
    procedure Execute(const ACustomerId: string; const ATotal: Currency);
  end;

implementation

uses
  System.SysUtils,
  Devspace.Application.EventBus.Facade,
  Devspace.Domain.Events.OrderCreated,
  Devspace.Domain.Events.PaymentApproved,
  Devspace.Infrastructure.Events.OrderCreated,
  Devspace.Infrastructure.Events.PaymentApproved;

constructor TCreateOrderUseCase.Create(const AEventBus: IEventBus);
begin
  inherited Create;
  FEventBus := AEventBus;
end;

procedure TCreateOrderUseCase.Execute(const ACustomerId: string; const ATotal: Currency);
const
  CreatingOrder = 'Criando pedido...';
  OrderMessage = 'Pedido: %s';
var
  OrderId: string;
  PaymentId: string;
  OrderCreated: IOrderCreated;
  PaymentApproved: IPaymentApproved;
begin
  OrderId := TGUID.NewGuid.ToString;
  PaymentId := TGUID.NewGuid.ToString;
  Writeln(CreatingOrder);
  Writeln(Format(OrderMessage, [OrderId]));
  OrderCreated := TOrderCreated.Create(OrderId, ACustomerId, ATotal);
  PaymentApproved := TPaymentApproved.Create(PaymentId, OrderId, ATotal);
  TEventBusFacade.Publish<IOrderCreated>(FEventBus, OrderCreated);
  TEventBusFacade.PublishAsync<IPaymentApproved>(FEventBus, PaymentApproved);
end;

end.

