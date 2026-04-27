unit Devspace.Classes.Operation.Factory;

interface

uses
  System.Generics.Collections,
  Devspace.Classes.Operacao;

type
  TOperations = TArray<string>;

  IOperationFactory = interface
  ['{16609C69-1A6D-4365-8203-EB15F8AAF682}']
    function GetOperation(const AName: string): IOperacao;
    function GetOperations: TOperations;
    function RegisterOperation(const AName: string; const AOperation: TOperacaoClass): IOperationFactory;
    property Operation[const AName: string]: IOperacao read GetOperation;
    property Operacoes: TOperations read GetOperations;
  end;

  TOperationFactory = class(TInterfacedObject, IOperationFactory)
  strict private
    FOperacoes: TObjectOrderedDictionary<string, TOperacaoClass>;
    function GetOperation(const AName: string): IOperacao;
    function GetOperations: TOperations;
  private
    class var FInstance: IOperationFactory;
    constructor Create;
  public
    destructor Destroy; override;
    class function Instance: IOperationFactory;
    function RegisterOperation(const AName: string; const AOperation: TOperacaoClass): IOperationFactory;
  end;

implementation

{ TOperationFactory }

constructor TOperationFactory.Create;
begin
  FOperacoes := TObjectOrderedDictionary<string, TOperacaoClass>.Create;
end;

destructor TOperationFactory.Destroy;
begin
  FOperacoes.Free;
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

function TOperationFactory.GetOperation(const AName: string): IOperacao;
begin
  Result := nil;

  if not FOperacoes.ContainsKey(AName) then
  begin
    Exit;
  end;

  Result := FOperacoes[AName].Create;
end;

function TOperationFactory.GetOperations: TOperations;
begin
  Result := FOperacoes.Keys.ToArray;
end;

function TOperationFactory.RegisterOperation(const AName: string; const AOperation: TOperacaoClass): IOperationFactory;
begin
  Result := Self;
  FOperacoes.AddOrSetValue(AName, AOperation);
end;

initialization
  TOperationFactory.FInstance := nil;

end.
