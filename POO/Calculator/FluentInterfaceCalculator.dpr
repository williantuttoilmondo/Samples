program FluentInterfaceCalculator;

uses
  Vcl.Forms,
  Devspace.Classes.Operation in 'Operation\Devspace.Classes.Operation.pas',
  Devspace.Classes.Operation.Basics in 'Operation\Devspace.Classes.Operation.Basics.pas',
  Devspace.Classes.Operation.Factory in 'Operation\Devspace.Classes.Operation.Factory.pas',
  Devspace.Classes.Operation.Power in 'Operation\Devspace.Classes.Operation.Power.pas',
  Devspace.Consts.Operation in 'Operation\Devspace.Consts.Operation.pas',
  Devspace.Exceptions.Operation in 'Operation\Devspace.Exceptions.Operation.pas',
  Devspace.Forms.Calculator in 'Calculator\Devspace.Forms.Calculator.pas' {Calculator},
  Devspace.Helpers.TStrings in 'Helpers\Devspace.Helpers.TStrings.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Title := 'Fluent Interface Calculator';
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TCalculator, Calculator);
  Application.Run;
end.
