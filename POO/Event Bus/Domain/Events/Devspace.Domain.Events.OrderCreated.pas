unit Devspace.Domain.Events.OrderCreated;

interface

uses
  Devspace.Application.EventBus.Event;

type
  IOrderCreated = interface(IEvent)
    ['{ABBB7D32-178C-40C4-A824-430F4B6C8D61}']
    function GetOrderId: string;
    function GetCustomerId: string;
    function GetTotal: Currency;
    property OrderId: string read GetOrderId;
    property CustomerId: string read GetCustomerId;
    property Total: Currency read GetTotal;
  end;

implementation

end.
