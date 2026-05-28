unit Devspace.Classes.Operation.Power;

interface

uses
  Devspace.Classes.Operation;

type
  TPower = class(TOperation)
  strict protected
    procedure DoCalculate(out AResult: Double); override;
  end;

  TRoot = class(TOperation)
  strict protected
    procedure DoCalculate(out AResult: Double); override;
  end;

implementation

uses
  System.Math,
  System.SysUtils,
  Devspace.Classes.Operation.Factory,
  Devspace.Exceptions.Operation;

{ TPower }

procedure TPower.DoCalculate(out AResult: Double);
begin
  AResult := Power(FA, FB);
end;

{ TRoot }

procedure TRoot.DoCalculate(out AResult: Double);
begin
  if FB = 0 then
  begin
    EDivByZero.RaiseCannotBeZeroException('B');
  end;

  AResult := Power(FA, 1/FB);
end;

initialization
  TOperationFactory.Instance
                   .RegisterOperation('Power', TPower)
                   .RegisterOperation('Root', TRoot);

end.
