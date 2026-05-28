unit Devspace.Classes.Operation.Basics;

interface

uses
  Devspace.Classes.Operation;

type
  TAddition = class(TOperation)
  strict protected
    procedure DoCalculate(out AResult: Double); override;
  end;

  TSubtraction = class(TOperation)
  strict protected
    procedure DoCalculate(out AResult: Double); override;
  end;

  TMultiplication = class(TOperation)
  strict protected
    procedure DoCalculate(out AResult: Double); override;
  end;

  TDivision = class(TOperation)
  strict protected
    procedure DoCalculate(out AResult: Double); override;
  end;

implementation

uses
  System.SysUtils,
  Devspace.Classes.Operation.Factory,
  Devspace.Exceptions.Operation;

{ TAddition }

procedure TAddition.DoCalculate(out AResult: Double);
begin
  AResult := FA + FB;
end;

{ TSubtraction }

procedure TSubtraction.DoCalculate(out AResult: Double);
begin
  AResult := FA - FB;
end;

{ TMultiplication }

procedure TMultiplication.DoCalculate(out AResult: Double);
begin
  AResult := FA * FB;
end;

{ TDivision }

procedure TDivision.DoCalculate(out AResult: Double);
begin
  if FB = 0 then
  begin
    EDivByZero.RaiseCannotBeZeroException('B');
  end;

  AResult := FA / FB;
end;

initialization
  TOperationFactory.Instance
                   .RegisterOperation('Addition', TAddition)
                   .RegisterOperation('Subtraction', TSubtraction)
                   .RegisterOperation('Multiplication', TMultiplication)
                   .RegisterOperation('Division', TDivision);

end.
