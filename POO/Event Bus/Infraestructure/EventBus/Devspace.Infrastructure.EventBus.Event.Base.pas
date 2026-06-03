unit Devspace.Infrastructure.EventBus.Event.Base;

interface

uses
  System.SysUtils,
  Devspace.Application.EventBus.Event;

type
  TEvent = class abstract(TInterfacedObject, IEvent)
  strict private
    FId: string;
    FCreatedAt: TDateTime;
    FName: string;
    function GetId: string;
    function GetCreatedAt: TDateTime;
    function GetName: string;
  protected
    constructor Create(const AName: string); virtual;
  public
    property Id: string read GetId;
    property CreatedAt: TDateTime read GetCreatedAt;
    property Name: string read GetName;
  end;

implementation

constructor TEvent.Create(const AName: string);
begin
  inherited Create;
  FId := TGUID.NewGuid.ToString;
  FCreatedAt := Now;
  FName := AName;
end;

function TEvent.GetCreatedAt: TDateTime;
begin
  Result := FCreatedAt;
end;

function TEvent.GetId: string;
begin
  Result := FId;
end;

function TEvent.GetName: string;
begin
  Result := FName;
end;

end.
