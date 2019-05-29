object Form1: TForm1
  Left = 502
  Top = 317
  Width = 1170
  Height = 711
  Caption = #45348#51060#48260' '#45216#50472' '#54168#51060#51648' '#44032#51256#50724#44592
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 480
    Top = 64
    Width = 58
    Height = 13
    Caption = #54168#51060#51648' '#49548#49828
  end
  object Label2: TLabel
    Left = 8
    Top = 64
    Width = 58
    Height = 13
    Caption = #50937' '#48652#46972#50864#51200
  end
  object Memo1: TMemo
    Left = 480
    Top = 80
    Width = 441
    Height = 569
    Lines.Strings = (
      ' ')
    TabOrder = 0
    OnKeyPress = Memo1KeyPress
  end
  object RadioButton1: TRadioButton
    Left = 8
    Top = 8
    Width = 113
    Height = 17
    Caption = 'Wininet '#48169#49885
    TabOrder = 1
  end
  object RadioButton2: TRadioButton
    Left = 8
    Top = 32
    Width = 161
    Height = 17
    Caption = 'WebBrower Component '#48169#49885
    TabOrder = 2
  end
  object WebBrowser1: TWebBrowser
    Left = 16
    Top = 88
    Width = 441
    Height = 569
    TabOrder = 3
    ControlData = {
      4C000000942D0000CF3A00000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object Button1: TButton
    Left = 192
    Top = 8
    Width = 73
    Height = 49
    Caption = #47532#49548#49828' '#48372#44592
    TabOrder = 4
    OnClick = Button1Click
  end
  object ClearBtn: TButton
    Left = 480
    Top = 24
    Width = 75
    Height = 25
    Caption = #51648#50864#44592
    TabOrder = 5
    OnClick = ClearBtnClick
  end
  object ComboBox1: TComboBox
    Left = 272
    Top = 8
    Width = 145
    Height = 21
    ItemHeight = 13
    TabOrder = 6
    Text = #51648#50669' '#49440#53469
    Items.Strings = (
      #49436#50872
      #45824#51204
      #45824#44396)
  end
end
