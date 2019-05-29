object kloikm: Tkloikm
  Left = 242
  Top = 575
  Width = 506
  Height = 483
  Caption = 'Client'
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 24
    Width = 33
    Height = 13
    Caption = #50500#51060#46356
  end
  object Label2: TLabel
    Left = 24
    Top = 48
    Width = 22
    Height = 13
    Caption = #52292#54021
  end
  object Label3: TLabel
    Left = 8
    Top = 416
    Width = 44
    Height = 13
    Caption = #47784#46160#50640#44172
  end
  object ChatMsg: TEdit
    Left = 56
    Top = 408
    Width = 281
    Height = 21
    TabOrder = 0
    OnKeyPress = ChatMsgKeyPress
  end
  object EnterBtn: TButton
    Left = 128
    Top = 24
    Width = 41
    Height = 17
    Caption = #51217#49549
    TabOrder = 1
    OnClick = EnterBtnClick
  end
  object UserId: TEdit
    Left = 64
    Top = 24
    Width = 57
    Height = 21
    TabOrder = 2
    OnKeyPress = UserIdKeyPress
  end
  object ChatMemo: TMemo
    Left = 8
    Top = 64
    Width = 337
    Height = 337
    Align = alCustom
    Lines.Strings = (
      ' ')
    TabOrder = 3
    OnKeyPress = ChatMemoKeyPress
  end
  object ExitBtn: TButton
    Left = 176
    Top = 24
    Width = 49
    Height = 17
    Caption = #45208#44032#44592
    TabOrder = 4
    OnClick = ExitBtnClick
  end
  object Timer1: TTimer
    Interval = 300
    OnTimer = Timer1Timer
    Left = 432
  end
  object IdTCPClient1: TIdTCPClient
    MaxLineAction = maException
    ReadTimeout = 0
    OnDisconnected = IdTCPClient1Disconnected
    OnWorkEnd = IdTCPClient1WorkEnd
    Host = '127.0.0.1'
    OnConnected = IdTCPClient1Connected
    Port = 1234
    Left = 408
    Top = 8
  end
  object IdAntiFreeze1: TIdAntiFreeze
    Left = 456
  end
  object IdThreadMgrDefault1: TIdThreadMgrDefault
    Left = 384
  end
end
