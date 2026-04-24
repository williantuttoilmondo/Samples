unit Devspace.Classes.Operacao.Potencia;

interface

uses
  Devspace.Classes.Operacao;

type
  TPotencia = class(TOperacao)
  strict protected
    function DoEfetuar(out AResult: Double): IOperacao; override;
  end;

  TRaiz = class(TOperacao)
  strict protected
    function DoEfetuar(out AResult: Double): IOperacao; override;
  end;

implementation

uses
  System.Math,
  System.SysUtils,
  Devspace.Classes.Operacao.Factory,
  Devspace.Exceptions.Operacao;

{ TPotencia }

function TPotencia.DoEfetuar(out AResult: Double): IOperacao;
begin
  Result := Self;
  AResult := Power(FA, FB);
end;

{ TRaiz }

function TRaiz.DoEfetuar(out AResult: Double): IOperacao;
begin
  Result := Self;

  if FB = 0 then
  begin
    EDivByZero.RaiseCannotBeZeroException('B');
  end;

  AResult := Power(FA, 1/FB);
end;

initialization
  TOperacaoFactory.Instance
                  .RegistraOperacao('Potência', TPotencia)
                  .RegistraOperacao('Raiz', TRaiz);

end.
