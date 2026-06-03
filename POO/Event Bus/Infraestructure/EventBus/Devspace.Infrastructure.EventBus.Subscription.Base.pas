unit Devspace.Infrastructure.EventBus.Subscription.Base;

interface

uses
  System.SysUtils,
  Devspace.Application.EventBus.Subscription;

type
  TEventSubscriptionBase = class(TInterfacedObject, IEventSubscription)
  strict private
    FId: string;
    FEventName: string;
    function GetId: string;
    function GetEventName: string;
  public
    constructor Create(const AEventName: string);
  end;

implementation

constructor TEventSubscriptionBase.Create(const AEventName: string);
begin
  inherited Create;
  FId := TGUID.NewGuid.ToString;
  FEventName := AEventName;
end;

function TEventSubscriptionBase.GetEventName: string;
begin
  Result := FEventName;
end;

function TEventSubscriptionBase.GetId: string;
begin
  Result := FId;
end;

end.

