program CalculadoraComFluentInterface;

uses
  Vcl.Forms,
  Devspace.Classes.Operacao in 'Operacao\Devspace.Classes.Operacao.pas',
  Devspace.Classes.Operacao.Basicas in 'Operacao\Devspace.Classes.Operacao.Basicas.pas',
  Devspace.Classes.Operacao.Factory in 'Operacao\Devspace.Classes.Operacao.Factory.pas',
  Devspace.Classes.Operacao.Potencia in 'Operacao\Devspace.Classes.Operacao.Potencia.pas',
  Devspace.Consts.Operacao in 'Operacao\Devspace.Consts.Operacao.pas',
  Devspace.Exceptions.Operacao in 'Operacao\Devspace.Exceptions.Operacao.pas',
  Devspace.Forms.Calculadora in 'Calculadora\Devspace.Forms.Calculadora.pas' {Calculadora},
  Devspace.Helpers.TStrings in 'Helpers\Devspace.Helpers.TStrings.pas';

{$R *.res}

begin
  ReportMemoryLeaksOnShutdown := True;
  Application.Title := 'Calculadora com Fluent Interface';
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TCalculadora, Calculadora);
  Application.Run;
end.
