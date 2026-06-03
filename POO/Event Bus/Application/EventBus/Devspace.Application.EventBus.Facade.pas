unit Devspace.Application.EventBus.Facade;

interface

uses
  System.TypInfo,
  Devspace.Application.EventBus.Event,
  Devspace.Application.EventBus.Intf,
  Devspace.Application.EventBus.Callback,
  Devspace.Application.EventBus.Subscription;

type
  TEventBusFacade = class
  public
    class function Subscribe<T: IEvent>(const AEventBus: IEventBus; const ACallback: TTypedEventCallback<T>): IEventSubscription; static;
    class function Publish<T: IEvent>(const AEventBus: IEventBus; const AEvent: T): IEventBus; static;
    class function PublishAsync<T: IEvent>(const AEventBus: IEventBus; const AEvent: T): IEventBus; static;
  end;

implementation

uses
  System.SysUtils;

class function TEventBusFacade.Subscribe<T>(const AEventBus: IEventBus; const ACallback: TTypedEventCallback<T>): IEventSubscription;
var
  EventGuid: TGUID;
begin
  EventGuid := GetTypeData(TypeInfo(T)).Guid;
  Result := AEventBus.Subscribe(EventGuid,
    procedure(const AEvent: IEvent)
    var
      TypedEvent: T;
    begin
      if Supports(AEvent, EventGuid, TypedEvent) then
      begin
        ACallback(TypedEvent);
      end;
    end);
end;

class function TEventBusFacade.Publish<T>(const AEventBus: IEventBus; const AEvent: T): IEventBus;
var
  EventRef: IEvent;
begin
  EventRef := AEvent;
  Result := AEventBus.Publish(EventRef);
end;

class function TEventBusFacade.PublishAsync<T>(const AEventBus: IEventBus; const AEvent: T): IEventBus;
var
  EventRef: IEvent;
begin
  EventRef := AEvent;
  Result := AEventBus.PublishAsync(EventRef);
end;

end.

