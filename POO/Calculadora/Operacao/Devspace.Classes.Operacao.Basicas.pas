unit Devspace.Classes.Operacao.Basicas;

interface

uses
  Devspace.Classes.Operacao;

type
  TAdicao = class(TOperacao)
  strict protected
    function DoEfetuar(out AResult: Double): IOperacao; override;
  end;

  TSubtracao = class(TOperacao)
  strict protected
    function DoEfetuar(out AResult: Double): IOperacao; override;
  end;

  TMultiplicacao = class(TOperacao)
  strict protected
    function DoEfetuar(out AResult: Double): IOperacao; override;
  end;

  TDivisao = class(TOperacao)
  strict protected
    function DoEfetuar(out AResult: Double): IOperacao; override;
  end;

implementation

uses
  System.SysUtils,
  Devspace.Classes.Operacao.Factory,
  Devspace.Exceptions.Operacao;

{ TAdicao }

function TAdicao.DoEfetuar(out AResult: Double): IOperacao;
begin
  Result := Self;
  AResult := FA + FB;
end;

{ TSubtracao }

function TSubtracao.DoEfetuar(out AResult: Double): IOperacao;
begin
  Result := Self;
  AResult := FA - FB;
end;

{ TMultiplicacao }

function TMultiplicacao.DoEfetuar(out AResult: Double): IOperacao;
begin
  Result := Self;
  AResult := FA * FB;
end;

{ TDivisao }

function TDivisao.DoEfetuar(out AResult: Double): IOperacao;
begin
  Result := Self;

  if FB = 0 then
  begin
    EDivByZero.RaiseCannotBeZeroException('B');
  end;

  AResult := FA / FB;
end;

initialization
  TOperacaoFactory.Instance
                  .RegistraOperacao('Adição', TAdicao)
                  .RegistraOperacao('Subtração', TSubtracao)
                  .RegistraOperacao('Multiplicação', TMultiplicacao)
                  .RegistraOperacao('Divisão', TDivisao);

end.
