unit Devspace.Classes.Operation.Power;

interface

uses
  Devspace.Classes.Operation;

type
  TPower = class(TOperation)
  strict protected
    function DoCalculate(out AResult: Double): IOperation; override;
  end;

  TRoot = class(TOperation)
  strict protected
    function DoCalculate(out AResult: Double): IOperation; override;
  end;

implementation

uses
  System.Math,
  System.SysUtils,
  Devspace.Classes.Operation.Factory,
  Devspace.Exceptions.Operacao;

{ TPower }

function TPower.DoCalculate(out AResult: Double): IOperation;
begin
  Result := Self;
  AResult := Power(FA, FB);
end;

{ TRoot }

function TRoot.DoCalculate(out AResult: Double): IOperation;
begin
  Result := Self;

  if FB = 0 then
  begin
    EDivByZero.RaiseCannotBeZeroException('B');
  end;

  AResult := Power(FA, 1/FB);
end;

initialization
  TOperactionFactory.Instance
                    .RegisterOperation('Power', TPower)
                    .RegisterOperation('Root', TRoot);

end.
