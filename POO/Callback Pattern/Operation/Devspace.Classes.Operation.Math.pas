unit Devspace.Classes.Operation.Math;

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

  IMathOperation = interface
  ['{D135285E-3755-4094-B416-7BCD228E06D0}']
    function Calculate: IMathOperation;
    function OnError(const ACallback: TErrorCallback): IOnError;
    function SetA(const AValue: Double): IMathOperation;
    function SetB(const AValue: Double): IMathOperation;
  end;

  TMathOperation = class(TInterfacedObject, IMathOperation)
  strict private
    FA: Double;
    FB: Double;
    FLastError: string;
    FOperation: string;
    FResult: Double;
    FSuccess: Boolean;
  private
    constructor Create(const AOperation: string);
  public
    class function New(const AOperation: string): IMathOperation;
    function Calculate: IMathOperation;
    function OnError(const ACallback: TErrorCallback): IOnError;
    function SetA(const AValue: Double): IMathOperation;
    function SetB(const AValue: Double): IMathOperation;
  end;

implementation

uses
  System.SysUtils,
  Devspace.Classes.Operation.Factory,
  Devspace.Consts.Operation,
  Devspace.Exceptions.Operation;

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

{ TMathOperation }

constructor TMathOperation.Create(const AOperation: string);
begin
  FOperation := AOperation;
end;

class function TMathOperation.New(const AOperation: string): IMathOperation;
begin
  Result := TMathOperation.Create(AOperation);
end;

function TMathOperation.Calculate: IMathOperation;
begin
  Result := Self;
  FSuccess := False;

  try
    TOperationFactory.Instance
                     .Operation[FOperation]
                     .SetA(FA)
                     .SetB(FB)
                     .Calculate(FResult);
    FSuccess := True;
  except
    on E: Exception do
    begin
      FLastError := Format(DefaultExceptionMessage, [E.ClassName, E.Message]);
    end;
  end;
end;

function TMathOperation.OnError(const ACallback: TErrorCallback): IOnError;
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

function TMathOperation.SetA(const AValue: Double): IMathOperation;
begin
  Result := Self;
  FA := AValue;
end;

function TMathOperation.SetB(const AValue: Double): IMathOperation;
begin
  Result := Self;
  FB := AValue;
end;

end.
