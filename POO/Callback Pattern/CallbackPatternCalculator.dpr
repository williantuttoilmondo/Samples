program CallbackPatternCalculator;

uses
  Vcl.Forms,
  Devspace.Classes.Operation in 'Contracts\Devspace.Classes.Operation.pas',
  Devspace.Classes.Operation.Basics in 'Domain\Devspace.Classes.Operation.Basics.pas',
  Devspace.Classes.Operation.Factory in 'Service\Devspace.Classes.Operation.Factory.pas',
  Devspace.Classes.Operation.Power in 'Domain\Devspace.Classes.Operation.Power.pas',
  Devspace.Exceptions.Operation in 'Operation\Devspace.Exceptions.Operation.pas',
  Devspace.Forms.Calculator in 'Presentation\Devspace.Forms.Calculator.pas' {Calculator},
  Devspace.Helpers.TStrings in 'Helpers\Devspace.Helpers.TStrings.pas',
  Devspace.Classes.Operation.Facade in 'Service\Devspace.Classes.Operation.Facade.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Title := 'Callback Pattern Calculator';
  Application.Initialize;
  TCalculator.Open;
  Application.MainFormOnTaskbar := True;
  Application.Run;
end.
