unit Devspace.Domain.Events.PaymentApproved;

interface

uses
  Devspace.Application.EventBus.Event;

type
  IPaymentApproved = interface(IEvent)
    ['{B0A936A7-4F63-4F39-AF66-2B3EC2D364A7}']
    function GetPaymentId: string;
    function GetOrderId: string;
    function GetAmount: Currency;
    property PaymentId: string read GetPaymentId;
    property OrderId: string read GetOrderId;
    property Amount: Currency read GetAmount;
  end;

implementation

end.
