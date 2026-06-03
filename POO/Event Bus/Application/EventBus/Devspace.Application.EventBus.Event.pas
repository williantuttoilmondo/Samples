unit Devspace.Application.EventBus.Event;

interface

type
  IEvent = interface
    ['{3A14C86D-4C1B-4C3E-9AA3-8F62E8E8B101}']
    function GetId: string;
    function GetCreatedAt: TDateTime;
    function GetName: string;
    property Id: string read GetId;
    property CreatedAt: TDateTime read GetCreatedAt;
    property Name: string read GetName;
  end;

implementation

end.

