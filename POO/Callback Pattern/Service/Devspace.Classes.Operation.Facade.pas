unit Devspace.Classes.Operation.Facade;

interface

type
  TErrorCallback = reference to procedure(const AError: string);
  TSuccessCallback = reference to procedure(const AResult: Double);

  IOnSuccess = interface
  ['{CA28A782-FD8C-4D34-9E85-11F7AE0F17B1}']
    procedure OnSuccess(const ACallback: TSuccessCallback);
  end;

  TOnSuccess = class(TInterfacedObject, IOnSuccess)
  strict private
    FResult: Double;
    FSuccess: Boolean;
  private
    constructor Create(const ASuccess: Boolean; const AResult: Double);
  public
    procedure OnSuccess(const ACallback: TSuccessCallback);
  end;

  IOperationFacade = interface
  ['{D135285E-3755-4094-B416-7BCD228E06D0}']
    function Calculate: IOperationFacade;
    function OnError(const ACallback: TErrorCallback): IOnSuccess;
    function SetA(const AValue: Double): IOperationFacade;
    function SetB(const AValue: Double): IOperationFacade;
  end;

  TOperationFacade = class(TInterfacedObject, IOperationFacade)
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
    class function New(const AOperation: string): IOperationFacade;
    function Calculate: IOperationFacade;
    function OnError(const ACallback: TErrorCallback): IOnSuccess;
    function SetA(const AValue: Double): IOperationFacade;
    function SetB(const AValue: Double): IOperationFacade;
  end;

implementation

uses
  System.SysUtils,
  Devspace.Classes.Operation.Factory,
  Devspace.Consts.Operation,
  Devspace.Exceptions.Operation;

{ TOnSuccess }

constructor TOnSuccess.Create(const ASuccess: Boolean; const AResult: Double);
begin
  FResult := AResult;
  FSuccess := ASuccess;
end;

procedure TOnSuccess.OnSuccess(const ACallback: TSuccessCallback);
begin
  if not (Assigned(ACallback) and FSuccess) then
  begin
    Exit;
  end;

  ACallback(FResult);
end;

{ TOperationFacade }

constructor TOperationFacade.Create(const AOperation: string);
begin
  FOperation := AOperation;
end;

class function TOperationFacade.New(const AOperation: string): IOperationFacade;
begin
  Result := TOperationFacade.Create(AOperation);
end;

function TOperationFacade.Calculate: IOperationFacade;
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

function TOperationFacade.OnError(const ACallback: TErrorCallback): IOnSuccess;
begin
  if not Assigned(ACallback) then
  begin
    EOnErrorException.RaiseOnErrorCallbackNotAssignedException;
  end;

  Result := TOnSuccess.Create(FSuccess, FResult);

  if not FSuccess then
  begin
    ACallback(FLastError);
  end;
end;

function TOperationFacade.SetA(const AValue: Double): IOperationFacade;
begin
  Result := Self;
  FA := AValue;
end;

function TOperationFacade.SetB(const AValue: Double): IOperationFacade;
begin
  Result := Self;
  FB := AValue;
end;

end.
