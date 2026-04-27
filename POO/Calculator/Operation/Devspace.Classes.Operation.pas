unit Devspace.Classes.Operation;

interface

type
  TErrorCallback = reference to procedure(const AError: string);
  TSuccessCallback = reference to procedure(const AResult: Double);

  IOnError = interface
  ['{CA28A782-FD8C-4D34-9E85-11F7AE0F17B1}']
    procedure OnSuccess(const ACallback: TSuccessCallback);
  end;

  TOnError = class(TInterfacedObject, IOnError)
  strict private
    FResult: Double;
    FSuccess: Boolean;
  private
    constructor Create(const ASuccess: Boolean; const AResult: Double);
  public
    procedure OnSuccess(const ACallback: TSuccessCallback);
  end;

  IOperation = interface
    ['{BD5131FE-BED6-4E8C-9407-FFE8348F8DC2}']
    function Calculate: IOperation;
    function GetA: Double;
    function GetB: Double;
    function OnError(const ACallback: TErrorCallback): IOnError;
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
    function DoEfetuar(out AResult: Double): IOperation; virtual; abstract;
  public
    constructor Create; virtual;
    function Calculate: IOperation;
    function OnError(const ACallback: TErrorCallback): IOnError;
    function SetA(const AValue: Double): IOperation; virtual;
    function SetB(const AValue: Double): IOperation; virtual;
  end;

  TOperacaoClass = class of TOperation;

implementation

uses
  System.SysUtils,
  Devspace.Consts.Operacao,
  Devspace.Exceptions.Operacao;

{ TOnError }

constructor TOnError.Create(const ASuccess: Boolean; const AResult: Double);
begin
  FResult := AResult;
  FSuccess := ASuccess;
end;

procedure TOnError.OnSuccess(const ACallback: TSuccessCallback);
begin
  if not (Assigned(ACallback) and FSuccess) then
  begin
    Exit;
  end;

  ACallback(FResult);
end;

{ TOperation }

constructor TOperation.Create;
begin
  FA := 0;
  FB := 0;
end;

function TOperation.Calculate: IOperation;
begin
  FResult := 0;
  Result := Self;

  try
    FSuccess := True;
    Result := DoEfetuar(FResult);
  except
    on E: Exception do
    begin
      FSuccess := False;
      FLastError := Format(DefaultExceptionMessage, [E.ClassName, E.Message]);
    end;
  end;
end;

function TOperation.GetA: Double;
begin
  Result := FA;
end;

function TOperation.GetB: Double;
begin
  Result := FB;
end;

function TOperation.OnError(const ACallback: TErrorCallback): IOnError;
begin
  Result := TOnError.Create(FSuccess, FResult);

  if not Assigned(ACallback) then
  begin
    EOnErrorException.RaiseOnErrorCallbackNotAssignedException;
  end;

  if not FSuccess then
  begin
    ACallback(FLastError);
  end;
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
