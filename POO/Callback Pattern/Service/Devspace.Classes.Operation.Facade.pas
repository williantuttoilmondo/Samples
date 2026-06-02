unit Devspace.Classes.Operation.Facade;

interface

type
  TErrorCallback = reference to procedure(const AError: string);
  TSuccessCallback = reference to procedure(const AResult: Double);

  IOperationExecutor = interface
  ['{082073C3-3F8E-4C74-A9F8-E66A4207BED6}']
    procedure Calculate;
  end;

  IOperationFacade = interface
  ['{D135285E-3755-4094-B416-7BCD228E06D0}']
    function Command: IOperationExecutor;
    function OnError(const ACallback: TErrorCallback): IOperationFacade;
    function OnSuccess(const ACallback: TSuccessCallback): IOperationFacade;
    function SetA(const AValue: Double): IOperationFacade;
    function SetB(const AValue: Double): IOperationFacade;
  end;

  TOperationFacade = class(TInterfacedObject, IOperationFacade, IOperationExecutor)
  strict private
    FA: Double;
    FB: Double;
    FOnError: TErrorCallback;
    FOnSuccess: TSuccessCallback;
    FOperation: string;
    FResult: Double;
  private
    constructor Create(const AOperation: string);
  public
    class function New(const AOperation: string): IOperationFacade;
    procedure Calculate;
    function Command: IOperationExecutor;
    function OnError(const ACallback: TErrorCallback): IOperationFacade;
    function OnSuccess(const ACallback: TSuccessCallback): IOperationFacade;
    function SetA(const AValue: Double): IOperationFacade;
    function SetB(const AValue: Double): IOperationFacade;
  end;

implementation

uses
  System.SysUtils,
  Devspace.Classes.Operation.Factory,
  Devspace.Consts.Operation,
  Devspace.Exceptions.Operation;

{ TOperationFacade }

constructor TOperationFacade.Create(const AOperation: string);
begin
  FOnError := nil;
  FOnSuccess := nil;
  FOperation := AOperation;
end;

function TOperationFacade.Command: IOperationExecutor;
begin
  Result := Self;
end;

class function TOperationFacade.New(const AOperation: string): IOperationFacade;
begin
  Result := TOperationFacade.Create(AOperation);
end;

procedure TOperationFacade.Calculate;
begin
  try
    TOperationFactory.Instance
                     .Operation[FOperation]
                     .SetA(FA)
                     .SetB(FB)
                     .Calculate(FResult);

    case Assigned(FOnSuccess) of
      True : FOnSuccess(FResult);
      False: EOnSuccessException.RaiseOnSuccessCallbackNotAssignedException;
    end;
  except
    on E: Exception do
    begin
      case Assigned(FOnError) of
        True : FOnError(Format(DefaultExceptionMessage, [E.ClassName, E.Message]));
        False: raise;
      end;
    end;
  end;
end;

function TOperationFacade.OnError(const ACallback: TErrorCallback): IOperationFacade;
begin
  Result := Self;

  if not Assigned(ACallback) then
  begin
    EOnErrorException.RaiseOnErrorCallbackNotAssignedException;
  end;

  FOnError := ACallback;
end;

function TOperationFacade.OnSuccess(const ACallback: TSuccessCallback): IOperationFacade;
begin
  Result := Self;

  if not Assigned(ACallback) then
  begin
    EOnSuccessException.RaiseOnSuccessCallbackNotAssignedException;
  end;

  FOnSuccess := ACallback;
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
