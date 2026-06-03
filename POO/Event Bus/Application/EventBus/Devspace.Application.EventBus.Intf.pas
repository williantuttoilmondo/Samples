unit Devspace.Application.EventBus.Intf;

interface

uses
  Devspace.Application.EventBus.Event,
  Devspace.Application.EventBus.Callback,
  Devspace.Application.EventBus.Subscription;

type
  IEventBus = interface
    ['{DC7587B8-5DAB-4E27-BC76-7464FCE70953}']
    function Subscribe(const AEventGuid: TGUID; const ACallback: TEventCallback): IEventSubscription;
    function Publish(const AEvent: IEvent): IEventBus;
    function PublishAsync(const AEvent: IEvent): IEventBus;
    function Unsubscribe(const ASubscription: IEventSubscription): IEventBus;
  end;

implementation

end.

