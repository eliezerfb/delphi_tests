object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Form1'
  ClientHeight = 205
  ClientWidth = 457
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Button1: TButton
    Left = 16
    Top = 150
    Width = 121
    Height = 25
    Caption = 'Obter Od'#244'metro'
    TabOrder = 0
    OnClick = Button1Click
  end
  object Memo1: TMemo
    Left = 152
    Top = 8
    Width = 289
    Height = 125
    TabOrder = 1
  end
  object LabeledEdit1: TLabeledEdit
    Left = 16
    Top = 24
    Width = 121
    Height = 21
    EditLabel.Width = 25
    EditLabel.Height = 13
    EditLabel.Caption = 'Placa'
    TabOrder = 2
    Text = 'IHF0716'
  end
  object LabeledEdit2: TLabeledEdit
    Left = 16
    Top = 68
    Width = 121
    Height = 21
    EditLabel.Width = 122
    EditLabel.Height = 13
    EditLabel.Caption = 'Data NF-e (YYYY-MM-DD)'
    TabOrder = 3
    Text = '2018-08-01'
  end
  object LabeledEdit3: TLabeledEdit
    Left = 16
    Top = 112
    Width = 121
    Height = 21
    EditLabel.Width = 110
    EditLabel.Height = 13
    EditLabel.Caption = 'Hora NF-e (HH:MM:SS)'
    TabOrder = 4
    Text = '17:11:00'
  end
  object LabeledEdit4: TLabeledEdit
    Left = 152
    Top = 154
    Width = 121
    Height = 21
    EditLabel.Width = 25
    EditLabel.Height = 13
    EditLabel.Caption = 'Placa'
    TabOrder = 5
  end
  object LabeledEdit5: TLabeledEdit
    Left = 279
    Top = 154
    Width = 121
    Height = 21
    EditLabel.Width = 48
    EditLabel.Height = 13
    EditLabel.Caption = 'Odometro'
    TabOrder = 6
  end
  object CheckBox1: TCheckBox
    Left = 16
    Top = 181
    Width = 97
    Height = 17
    Caption = 'Debug'
    TabOrder = 7
  end
  object IdSSLIOHandlerSocketOpenSSL1: TIdSSLIOHandlerSocketOpenSSL
    Intercept = IdLogDebug1
    MaxLineAction = maException
    Port = 0
    DefaultPort = 0
    SSLOptions.Mode = sslmUnassigned
    SSLOptions.VerifyMode = []
    SSLOptions.VerifyDepth = 0
    Left = 240
    Top = 12
  end
  object IdHTTP1: TIdHTTP
    Intercept = IdLogDebug1
    IOHandler = IdSSLIOHandlerSocketOpenSSL1
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.Accept = 'text, */*'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    HTTPOptions = [hoForceEncodeParams]
    Left = 216
    Top = 108
  end
  object IdLogDebug1: TIdLogDebug
    OnReceive = IdLogDebug1Receive
    OnSend = IdLogDebug1Send
    Active = True
    Left = 360
    Top = 112
  end
end
