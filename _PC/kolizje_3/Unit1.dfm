object Form1: TForm1
  Left = 292
  Top = 132
  Caption = 'Kolizja dla obiekt'#243'w o jednakowych rozmiarach'
  ClientHeight = 201
  ClientWidth = 457
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
  object Image1: TImage
    Left = 0
    Top = 0
    Width = 256
    Height = 200
    OnClick = Image1Click
    OnMouseMove = Image1MouseMove
  end
  object Label1: TLabel
    Left = 328
    Top = 16
    Width = 50
    Height = 13
    Caption = 'Brak kolizji'
  end
  object Button1: TButton
    Left = 328
    Top = 80
    Width = 75
    Height = 25
    Caption = 'Button1'
    TabOrder = 0
    OnClick = Button1Click
  end
end
