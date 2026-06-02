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
    procedure GetOperationAndDoMath;
    procedure FillEditsIfEmpty;
  public
    class procedure Open;
  end;

implementation

uses
  Devspace.Classes.Operation.Factory,
  Devspace.Classes.Operation.Facade,
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
  GetOperationAndDoMath;
end;

procedure TCalculator.ComboBoxLoadItems;
begin
  OperationComboBox.Items.FromArray(TOperationFactory.Instance.Operations);
end;

procedure TCalculator.FormCreate(Sender: TObject);
begin
  ComboBoxLoadItems;
  OperationComboBox.ItemIndex := 0;
end;

procedure TCalculator.GetOperationAndDoMath;
begin
  TOperationFacade.New(OperationComboBox.Text)
                  .SetA(StrToFloat(AEdit.Text))
                  .SetB(StrToFloat(BEdit.Text))
                  .OnError(procedure(const AError: string)
                           begin
                             Application.MessageBox(PWideChar(AError), PWideChar(Application.Title), MB_OK or MB_ICONWARNING);
                           end)
                  .OnSuccess(procedure(const AResult: Double)
                             begin
                               ResultLabel.Caption := FloatToStr(AResult);
                             end)
                  .Execute
                  .Calculate;
end;

class procedure TCalculator.Open;
var
  Instance: TCalculator;
begin
  Application.CreateForm(TCalculator, Instance);
end;

procedure TCalculator.FillEditsIfEmpty;
const
  DefaultValueA = '0';
  DefaultValueB = '1';
begin
  if AEdit.Text = EmptyStr then
  begin
    AEdit.Text := DefaultValueA;
  end;

  if BEdit.Text = EmptyStr then
  begin
    BEdit.Text := DefaultValueB;
  end;
end;

end.
