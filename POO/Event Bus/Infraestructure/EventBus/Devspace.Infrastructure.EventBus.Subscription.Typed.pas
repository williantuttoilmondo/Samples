unit Devspace.Infrastructure.EventBus.Subscription.Typed;

interface

uses
  System.SysUtils,
  Devspace.Application.EventBus.Event,
  Devspace.Application.EventBus.Callback,
  Devspace.Infrastructure.EventBus.Subscription.Base,
  Devspace.Infrastructure.EventBus.Subscription.Intf;

type
  TEventSubscription = class(TEventSubscriptionBase, IEventSubscriptionInternal)
  strict private
    FEventGuid: TGUID;
    FCallback: TEventCallback;
  private
    function SupportsEvent(const AEvent: IEvent): Boolean;
    procedure Dispatch(const AEvent: IEvent); reintroduce;
  public
    constructor Create(const AEventGuid: TGUID; const ACallback: TEventCallback);
  end;

implementation

constructor TEventSubscription.Create(const AEventGuid: TGUID; const ACallback: TEventCallback);
resourcestring
  EventCallbackWasNotAssignedMessage = 'The event callback was not assigned.';
begin
  inherited Create(AEventGuid.ToString);

  if not Assigned(ACallback) then
  begin
    raise EArgumentException.Create(EventCallbackWasNotAssignedMessage);
  end;

  FEventGuid := AEventGuid;
  FCallback := ACallback;
end;

function TEventSubscription.SupportsEvent(const AEvent: IEvent): Boolean;
var
  Unknown: IInterface;
begin
  Result := Assigned(AEvent) and Supports(AEvent, FEventGuid, Unknown);
end;

procedure TEventSubscription.Dispatch(const AEvent: IEvent);
begin
  if SupportsEvent(AEvent) then
  begin
    FCallback(AEvent);
  end;
end;

end.
