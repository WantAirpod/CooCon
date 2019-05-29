object Form1: TForm1
  Left = 356
  Top = 367
  Width = 850
  Height = 701
  Cursor = crArrow
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
    Left = 296
    Top = 88
    Width = 22
    Height = 13
    Caption = #45236#51068
  end
  object Label2: TLabel
    Left = 24
    Top = 88
    Width = 22
    Height = 13
    Caption = #54788#51116
  end
  object Label3: TLabel
    Left = 24
    Top = 120
    Width = 44
    Height = 13
    Caption = #50612#51228#48372#45796
  end
  object lbl1: TLabel
    Left = 24
    Top = 152
    Width = 22
    Height = 13
    Caption = #44592#50728
  end
  object lbl2: TLabel
    Left = 24
    Top = 184
    Width = 44
    Height = 13
    Caption = #44053#49688#54869#47456
  end
  object Label4: TLabel
    Left = 296
    Top = 152
    Width = 22
    Height = 13
    Caption = #44592#50728
  end
  object lbl3: TLabel
    Left = 296
    Top = 184
    Width = 44
    Height = 13
    Caption = #44053#49688#54869#47456
  end
  object lbl5: TLabel
    Left = 112
    Top = 184
    Width = 8
    Height = 13
    Caption = '%'
  end
  object lbl6: TLabel
    Left = 384
    Top = 184
    Width = 8
    Height = 13
    Caption = '%'
  end
  object lbl7: TLabel
    Left = 360
    Top = 48
    Width = 61
    Height = 13
    Caption = #51032' '#45216#50472' '#51221#48372
  end
  object lbl8: TLabel
    Left = 112
    Top = 152
    Width = 11
    Height = 13
    Caption = #46020
  end
  object lbl9: TLabel
    Left = 387
    Top = 152
    Width = 11
    Height = 13
    Caption = #46020
  end
  object RadioButton1: TRadioButton
    Left = 8
    Top = 8
    Width = 113
    Height = 17
    Caption = 'Wininet '#48169#49885
    TabOrder = 0
  end
  object RadioButton2: TRadioButton
    Left = 8
    Top = 32
    Width = 161
    Height = 17
    Caption = 'WebBrower Component '#48169#49885
    TabOrder = 1
  end
  object WebBrowser1: TWebBrowser
    Left = 24
    Top = 272
    Width = 753
    Height = 1
    TabOrder = 2
    ControlData = {
      4C000000D34D00001A0000000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object Button1: TButton
    Left = 712
    Top = 8
    Width = 65
    Height = 25
    Caption = #51312#54924
    TabOrder = 3
    OnClick = Button1Click
  end
  object ComboBox1: TComboBox
    Left = 272
    Top = 8
    Width = 145
    Height = 21
    ItemHeight = 13
    TabOrder = 4
    Text = #49436#50872#53945#48324#49884
    OnKeyPress = ComboBox1KeyPress
    Items.Strings = (
      #49436#50872#53945#48324#49884)
  end
  object ComboBox2: TComboBox
    Left = 416
    Top = 8
    Width = 145
    Height = 21
    ItemHeight = 13
    TabOrder = 5
    Text = #44053#48513#44396
    OnKeyPress = ComboBox2KeyPress
    Items.Strings = (
      #44053#48513#44396)
  end
  object ComboBox3: TComboBox
    Left = 560
    Top = 8
    Width = 145
    Height = 21
    ItemHeight = 13
    TabOrder = 6
    Text = #39#46041#39#51012' '#49440#53469#54616#49464#50836'.'
    OnChange = ComboBox3Change
    OnKeyPress = ComboBox3KeyPress
    Items.Strings = (
      #48120#50500#46041
      #49340#50577#46041
      #49688#50976#46041)
  end
  object edt8: TEdit
    Left = 200
    Top = 40
    Width = 161
    Height = 21
    TabOrder = 7
    OnKeyPress = edt8KeyPress
  end
  object edt1: TEdit
    Left = 80
    Top = 88
    Width = 57
    Height = 19
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = #49352#44404#47548
    Font.Style = []
    ParentFont = False
    TabOrder = 8
    OnKeyPress = edt1KeyPress
  end
  object edt2: TEdit
    Left = 80
    Top = 120
    Width = 41
    Height = 19
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = #49352#44404#47548
    Font.Style = []
    ParentFont = False
    TabOrder = 9
    OnKeyPress = edt2KeyPress
  end
  object edt3: TEdit
    Left = 80
    Top = 152
    Width = 33
    Height = 19
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = #49352#44404#47548
    Font.Style = []
    ParentFont = False
    TabOrder = 10
    OnKeyPress = edt3KeyPress
  end
  object edt4: TEdit
    Left = 80
    Top = 184
    Width = 33
    Height = 19
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = #49352#44404#47548
    Font.Style = []
    ParentFont = False
    TabOrder = 11
    OnKeyPress = edt4KeyPress
  end
  object edt5: TEdit
    Left = 352
    Top = 184
    Width = 33
    Height = 19
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = #49352#44404#47548
    Font.Style = []
    ParentFont = False
    TabOrder = 12
    OnKeyPress = edt5KeyPress
  end
  object edt6: TEdit
    Left = 352
    Top = 152
    Width = 33
    Height = 19
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = #49352#44404#47548
    Font.Style = []
    ParentFont = False
    TabOrder = 13
    OnKeyPress = edt6KeyPress
  end
  object edt7: TEdit
    Left = 352
    Top = 88
    Width = 57
    Height = 19
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = #49352#44404#47548
    Font.Style = []
    ParentFont = False
    TabOrder = 14
    OnKeyPress = edt7KeyPress
  end
  object Memo1: TMemo
    Left = 40
    Top = 296
    Width = 729
    Height = 273
    TabOrder = 15
    OnKeyPress = Memo1KeyPress
  end
  object WebBrowser2: TWebBrowser
    Left = 24
    Top = 280
    Width = 753
    Height = 1
    TabOrder = 16
    ControlData = {
      4C000000D34D00001A0000000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E126208000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object IdHTTP1: TIdHTTP
    MaxLineAction = maException
    ReadTimeout = 0
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = 0
    Request.ContentRangeStart = 0
    Request.ContentType = 'text/html'
    Request.Accept = 'text/html, */*'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    HTTPOptions = [hoForceEncodeParams]
    Left = 792
    Top = 8
  end
end
