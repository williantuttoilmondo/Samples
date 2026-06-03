unit Devspace.Infrastructure.Events.PaymentApproved;

interface

uses
  Devspace.Domain.Events.PaymentApproved,
  Devspace.Infrastructure.EventBus.Event.Base;

type
  TPaymentApproved = class(TEvent, IPaymentApproved)
  strict private
    FPaymentId: string;
    FOrderId: string;
    FAmount: Currency;
    function GetPaymentId: string;
    function GetOrderId: string;
    function GetAmount: Currency;
  public
    constructor Create(const APaymentId, AOrderId: string; const AAmount: Currency); reintroduce;
  end;

implementation

constructor TPaymentApproved.Create(const APaymentId, AOrderId: string; const AAmount: Currency);
const
  PaymentApproved = 'PaymentApproved';
begin
  inherited Create(PaymentApproved);
  FPaymentId := APaymentId;
  FOrderId := AOrderId;
  FAmount := AAmount;
end;

function TPaymentApproved.GetAmount: Currency;
begin
  Result := FAmount;
end;

function TPaymentApproved.GetOrderId: string;
begin
  Result := FOrderId;
end;

function TPaymentApproved.GetPaymentId: string;
begin
  Result := FPaymentId;
end;

end.

