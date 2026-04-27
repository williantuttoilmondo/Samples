unit Devspace.Forms.Calculator;

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
  TCalculator = class(TForm)
    AEdit: TLabeledEdit;
    BEdit: TLabeledEdit;
    CalculateButton: TButton;
    ResultDescLabel: TLabel;
    ResultLabel: TLabel;
    OperationComboBox: TComboBox;
    procedure FormCreate(Sender: TObject);
    procedure CalculateButtonClick(Sender: TObject);
    procedure AEditKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  strict private
    procedure ComboBoxLoadItems;
    procedure GetOperationsAndDoMath;
    procedure FillEditsIfEmpty;
  end;

var
  Calculator: TCalculator;

implementation

uses
  Devspace.Classes.Operacao.Factory,
  Devspace.Helpers.TStrings;

{$R *.dfm}

procedure TCalculator.AEditKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  case Key of
    VK_RETURN:
    begin
      Key := 0;
      Perform(WM_NEXTDLGCTL, 0, 0);
    end;
  end;
end;

procedure TCalculator.CalculateButtonClick(Sender: TObject);
begin
  FillEditsIfEmpty;
  GetOperationsAndDoMath;
end;

procedure TCalculator.ComboBoxLoadItems;
begin
  OperacaoComboBox.Items.FromArray(TOperacaoFactory.Instance.Operacoes);
end;

procedure TCalculator.FormCreate(Sender: TObject);
begin
  ComboBoxLoadItems;
  OperacaoComboBox.ItemIndex := 0;
end;

procedure TCalculator.GetOperationsAndDoMath;
begin
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
                               ResultLabel.Caption := FloatToStr(AResult);
                             end);
end;

procedure TCalculator.FillEditsIfEmpty;
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

end.

