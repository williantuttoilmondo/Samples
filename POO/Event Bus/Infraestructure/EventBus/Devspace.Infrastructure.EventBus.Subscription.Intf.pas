unit Devspace.Infrastructure.EventBus.Subscription.Intf;

interface

uses
  Devspace.Application.EventBus.Event,
  Devspace.Application.EventBus.Subscription;

type
  IEventSubscriptionInternal = interface(IEventSubscription)
    ['{9F25D71D-016C-4B63-9A38-A5B1C9E5F59E}']
    function SupportsEvent(const AEvent: IEvent): Boolean;
    procedure Dispatch(const AEvent: IEvent);
  end;

implementation

end.
