unit Devspace.Classes.Operacao.Factory;

interface

uses
  System.Generics.Collections,
  Devspace.Classes.Operacao;

type
  TOperacoes = TArray<string>;

  IOperacaoFactory = interface
  ['{16609C69-1A6D-4365-8203-EB15F8AAF682}']
    function GetOperacao(const ANome: string): IOperacao;
    function GetOperacoes: TOperacoes;
    function RegistraOperacao(const ANome: string; const AOperacao: TOperacaoClass): IOperacaoFactory;
    property Operacao[const ANome: string]: IOperacao read GetOperacao;
    property Operacoes: TOperacoes read GetOperacoes;
  end;

  TOperacaoFactory = class(TInterfacedObject, IOperacaoFactory)
  strict private
    FOperacoes: TObjectOrderedDictionary<string, TOperacaoClass>;
    function GetOperacao(const ANome: string): IOperacao;
    function GetOperacoes: TOperacoes;
  private
    class var FInstance: IOperacaoFactory;
    constructor Create;
  public
    destructor Destroy; override;
    class function Instance: IOperacaoFactory;
    function RegistraOperacao(const ANome: string; const AOperacao: TOperacaoClass): IOperacaoFactory;
  end;

implementation

{ TOperacaoFactory }

constructor TOperacaoFactory.Create;
begin
  FOperacoes := TObjectOrderedDictionary<string, TOperacaoClass>.Create;
end;

destructor TOperacaoFactory.Destroy;
begin
  FOperacoes.Free;
  inherited;
end;

class function TOperacaoFactory.Instance: IOperacaoFactory;
begin
  if not Assigned(FInstance) then
  begin
    FInstance := Create;
  end;

  Result := FInstance;
end;

function TOperacaoFactory.GetOperacao(const ANome: string): IOperacao;
begin
  Result := nil;

  if not FOperacoes.ContainsKey(ANome) then
  begin
    Exit;
  end;

  Result := FOperacoes[ANome].Create;
end;

function TOperacaoFactory.GetOperacoes: TOperacoes;
begin
  Result := FOperacoes.Keys.ToArray;
end;

function TOperacaoFactory.RegistraOperacao(const ANome: string; const AOperacao: TOperacaoClass): IOperacaoFactory;
begin
  Result := Self;
  FOperacoes.AddOrSetValue(ANome, AOperacao);
end;

initialization
  TOperacaoFactory.FInstance := nil;

end.
