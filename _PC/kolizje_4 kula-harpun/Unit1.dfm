object Form1: TForm1
  Left = 292
  Top = 132
  Caption = 'Kolizja kula - harpun'
  ClientHeight = 201
  ClientWidth = 332
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
    Left = 272
    Top = 8
    Width = 50
    Height = 13
    Caption = 'Brak kolizji'
  end
end
