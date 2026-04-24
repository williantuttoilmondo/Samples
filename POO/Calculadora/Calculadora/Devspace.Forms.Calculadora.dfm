object Calculadora: TCalculadora
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'Calculadora com Fluent Interface'
  ClientHeight = 120
  ClientWidth = 347
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  KeyPreview = True
  Position = poScreenCenter
  OnCreate = FormCreate
  DesignSize = (
    347
    120)
  TextHeight = 15
  object ResultadoDescLabel: TLabel
    Left = 8
    Top = 95
    Width = 65
    Height = 17
    Anchors = [akRight, akBottom]
    Caption = 'Resultado:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = [fsBold]
    ParentFont = False
    ExplicitTop = 182
  end
  object ResultadoLabel: TLabel
    Left = 79
    Top = 95
    Width = 4
    Height = 17
    Anchors = [akRight, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Segoe UI'
    Font.Style = []
    ParentFont = False
    ExplicitTop = 182
  end
  object AEdit: TLabeledEdit
    Left = 25
    Top = 8
    Width = 188
    Height = 23
    Alignment = taRightJustify
    Anchors = [akLeft, akTop, akRight]
    EditLabel.Width = 11
    EditLabel.Height = 23
    EditLabel.Caption = 'A:'
    LabelPosition = lpLeft
    NumbersOnly = True
    TabOrder = 0
    Text = ''
    OnKeyUp = AEditKeyUp
  end
  object BEdit: TLabeledEdit
    Left = 25
    Top = 37
    Width = 188
    Height = 23
    Alignment = taRightJustify
    Anchors = [akLeft, akTop, akRight]
    EditLabel.Width = 10
    EditLabel.Height = 23
    EditLabel.Caption = 'B:'
    LabelPosition = lpLeft
    NumbersOnly = True
    TabOrder = 1
    Text = ''
    OnKeyUp = AEditKeyUp
  end
  object CalcularButton: TButton
    Left = 219
    Top = 8
    Width = 119
    Height = 81
    Anchors = [akTop, akRight, akBottom]
    Caption = '&Calcular'
    TabOrder = 3
    OnClick = CalcularButtonClick
    ExplicitHeight = 168
  end
  object OperacaoComboBox: TComboBox
    Left = 25
    Top = 66
    Width = 188
    Height = 23
    Style = csDropDownList
    TabOrder = 2
    TextHint = 'Selecione uma opera'#231#227'o'
    OnKeyUp = AEditKeyUp
  end
end
