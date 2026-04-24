unit Devspace.Forms.Calculadora;

interface

uses
  Winapi.Windows,
  Winapi.Messages,
  System.SysUtils,
  System.Variants,
  System.Classes,
  Vcl.Graphics,
  Vcl.Controls,
  Vcl.Forms,
  Vcl.Dialogs,
  Vcl.StdCtrls,
  Vcl.ExtCtrls,
  Vcl.Mask;

type
  TCalculadora = class(TForm)
    AEdit: TLabeledEdit;
    BEdit: TLabeledEdit;
    CalcularButton: TButton;
    ResultadoDescLabel: TLabel;
    ResultadoLabel: TLabel;
    OperacaoComboBox: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure CalcularButtonClick(Sender: TObject);
    procedure AEditKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  end;

var
  Calculadora: TCalculadora;

implementation

uses
  Devspace.Classes.Operacao.Factory,
  Devspace.Helpers.TStrings;

{$R *.dfm}

procedure TCalculadora.AEditKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_RETURN:
    begin
      Key := 0;
      Perform(WM_NEXTDLGCTL, 0, 0);
    end;
  end;
end;

procedure TCalculadora.CalcularButtonClick(Sender: TObject);
  procedure PreencheCamposSeVazios;
  begin
    if AEdit.Text = EmptyStr then
    begin
      AEdit.Text := '0';
    end;

    if BEdit.Text = EmptyStr then
    begin
      BEdit.Text := '1';
    end;
  end;
begin
  PreencheCamposSeVazios;
  TOperacaoFactory.Instance
                  .Operacao[OperacaoComboBox.Items[OperacaoComboBox.ItemIndex]]
                  .SetA(StrToFloat(AEdit.Text))
                  .SetB(StrToFloat(BEdit.Text))
                  .Efetuar
                  .OnError(procedure(const AError: string)
                           begin
                             Application.MessageBox(PWideChar(AError), PWideChar(Application.Title), MB_OK or MB_ICONWARNING);
                           end)
                  .OnSuccess(procedure(const AResult: Double)
                             begin
                               ResultadoLabel.Caption := FloatToStr(AResult);
                             end);
end;

procedure TCalculadora.FormCreate(Sender: TObject);
begin
  OperacaoComboBox.Items.FromArray(TOperacaoFactory.Instance.Operacoes);
  OperacaoComboBox.ItemIndex := 0;
end;

end.

