unit Devspace.Application.EventBus.Subscription;

interface

type
  IEventSubscription = interface
    ['{2D30C1D7-AD3A-4E4B-BB10-991BFCDF5B1A}']
    function GetId: string;
    function GetEventName: string;
    property Id: string read GetId;
    property EventName: string read GetEventName;
  end;

implementation

end.

