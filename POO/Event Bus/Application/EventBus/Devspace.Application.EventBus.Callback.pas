unit Devspace.Application.EventBus.Callback;

interface

uses
  Devspace.Application.EventBus.Event;

type
  TEventCallback = reference to procedure(const AEvent: IEvent);
  TTypedEventCallback<T: IEvent> = reference to procedure(const AEvent: T);

implementation

end.

