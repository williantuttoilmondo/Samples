unit Devspace.Infrastructure.Events.OrderCreated;

interface

uses
  Devspace.Domain.Events.OrderCreated,
  Devspace.Infrastructure.EventBus.Event.Base;

type
  TOrderCreated = class(TEvent, IOrderCreated)
  strict private
    FOrderId: string;
    FCustomerId: string;
    FTotal: Currency;
    function GetOrderId: string;
    function GetCustomerId: string;
    function GetTotal: Currency;
  public
    constructor Create(const AOrderId, ACustomerId: string; const ATotal: Currency); reintroduce;
  end;

implementation

constructor TOrderCreated.Create(const AOrderId, ACustomerId: string; const ATotal: Currency);
const
  OrderCreated = 'OrderCreated';
begin
  inherited Create(OrderCreated);
  FOrderId := AOrderId;
  FCustomerId := ACustomerId;
  FTotal := ATotal;
end;

function TOrderCreated.GetCustomerId: string;
begin
  Result := FCustomerId;
end;

function TOrderCreated.GetOrderId: string;
begin
  Result := FOrderId;
end;

function TOrderCreated.GetTotal: Currency;
begin
  Result := FTotal;
end;

end.

