unit Devspace.Classes.Operation.Basics;

interface

uses
  Devspace.Classes.Operation;

type
  TAddiction = class(TOperation)
  strict protected
    function DoCalculate(out AResult: Double): IOperation; override;
  end;

  TSubtraction = class(TOperation)
  strict protected
    function DoCalculate(out AResult: Double): IOperation; override;
  end;

  TMultiplication = class(TOperation)
  strict protected
    function DoCalculate(out AResult: Double): IOperation; override;
  end;

  TDivision = class(TOperation)
  strict protected
    function DoCalculate(out AResult: Double): IOperation; override;
  end;

implementation

uses
  System.SysUtils,
  Devspace.Classes.Operation.Factory,
  Devspace.Exceptions.Operation;

{ TAddiction }

function TAddiction.DoCalculate(out AResult: Double): IOperation;
begin
  Result := Self;
  AResult := FA + FB;
end;

{ TSubtraction }

function TSubtraction.DoCalculate(out AResult: Double): IOperation;
begin
  Result := Self;
  AResult := FA - FB;
end;

{ TMultiplication }

function TMultiplication.DoCalculate(out AResult: Double): IOperation;
begin
  Result := Self;
  AResult := FA * FB;
end;

{ TDivision }

function TDivision.DoCalculate(out AResult: Double): IOperation;
begin
  Result := Self;

  if FB = 0 then
  begin
    EDivByZero.RaiseCannotBeZeroException('B');
  end;

  AResult := FA / FB;
end;

initialization
  TOperationFactory.Instance
                   .RegisterOperation('Addiction', TAddiction)
                   .RegisterOperation('Subtraction', TSubtraction)
                   .RegisterOperation('Multiplication', TMultiplication)
                   .RegisterOperation('Division', TDivision);

end.
