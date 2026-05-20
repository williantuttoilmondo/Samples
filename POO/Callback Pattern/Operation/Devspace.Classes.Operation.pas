unit Devspace.Classes.Operation;

interface

type
  IOperation = interface
    ['{BD5131FE-BED6-4E8C-9407-FFE8348F8DC2}']
    procedure Calculate(out AResult: Double);
    function GetA: Double;
    function GetB: Double;
    function SetA(const AValue: Double): IOperation;
    function SetB(const AValue: Double): IOperation;
    property A: Double read GetA;
    property B: Double read GetB;
  end;

  TOperation = class abstract(TInterfacedObject, IOperation)
  strict private
    function GetA: Double;
    function GetB: Double;
  strict protected
    FA: Double;
    FB: Double;
    FLastError: string;
    FResult: Double;
    FSuccess: Boolean;
    procedure DoCalculate(out AResult: Double); virtual; abstract;
  public
    constructor Create; virtual;
    procedure Calculate(out AResult: Double);
    function SetA(const AValue: Double): IOperation; virtual;
    function SetB(const AValue: Double): IOperation; virtual;
  end;

  TOperationClass = class of TOperation;

implementation

uses
  System.SysUtils,
  Devspace.Consts.Operation,
  Devspace.Exceptions.Operation;

{ TOperation }

constructor TOperation.Create;
begin
  FA := 0;
  FB := 0;
end;

procedure TOperation.Calculate(out AResult: Double);
begin
  DoCalculate(AResult);
end;

function TOperation.GetA: Double;
begin
  Result := FA;
end;

function TOperation.GetB: Double;
begin
  Result := FB;
end;

function TOperation.SetA(const AValue: Double): IOperation;
begin
  Result := Self;

  if FA = AValue then
  begin
    Exit;
  end;

  FA := AValue;
end;

function TOperation.SetB(const AValue: Double): IOperation;
begin
  Result := Self;

  if FB = AValue then
  begin
    Exit;
  end;

  FB := AValue;
end;

end.
