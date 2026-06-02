unit Devspace.Classes.Operation.Factory;

interface

uses
  System.Generics.Collections,
  Devspace.Classes.Operation;

type
  TOperations = TArray<string>;

  IOperationFactory = interface
  ['{16609C69-1A6D-4365-8203-EB15F8AAF682}']
    function GetOperation(const AName: string): IOperation;
    function GetOperations: TOperations;
    function RegisterOperation(const AName: string; const AOperation: TOperationClass): IOperationFactory;
    property Operation[const AName: string]: IOperation read GetOperation;
    property Operations: TOperations read GetOperations;
  end;

  TOperationFactory = class(TInterfacedObject, IOperationFactory)
  strict private
    FOperations: TOrderedDictionary<string, TOperationClass>;
    function GetOperation(const AName: string): IOperation;
    function GetOperations: TOperations;
  private
    class var FInstance: IOperationFactory;
    constructor Create;
  public
    destructor Destroy; override;
    class function Instance: IOperationFactory;
    function RegisterOperation(const AName: string; const AOperation: TOperationClass): IOperationFactory;
  end;

implementation

{ TOperationFactory }

constructor TOperationFactory.Create;
begin
  FOperations := TOrderedDictionary<string, TOperationClass>.Create;
end;

destructor TOperationFactory.Destroy;
begin
  FOperations.Free;
  inherited;
end;

class function TOperationFactory.Instance: IOperationFactory;
begin
  if not Assigned(FInstance) then
  begin
    FInstance := Create;
  end;

  Result := FInstance;
end;

function TOperationFactory.GetOperation(const AName: string): IOperation;
begin
  Result := nil;

  if not FOperations.ContainsKey(AName) then
  begin
    Exit;
  end;

  Result := FOperations[AName].Create;
end;

function TOperationFactory.GetOperations: TOperations;
begin
  Result := FOperations.Keys.ToArray;
end;

function TOperationFactory.RegisterOperation(const AName: string; const AOperation: TOperationClass): IOperationFactory;
begin
  Result := Self;
  FOperations.AddOrSetValue(AName, AOperation);
end;

initialization
  TOperationFactory.FInstance := nil;

finalization
  TOperationFactory.FInstance := nil;

end.
