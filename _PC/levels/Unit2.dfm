object Form2: TForm2
  Left = 192
  Top = 129
  BorderStyle = bsToolWindow
  BorderWidth = 2
  Caption = 'Form2'
  ClientHeight = 258
  ClientWidth = 184
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  FormStyle = fsStayOnTop
  KeyPreview = True
  OldCreateOrder = False
  OnKeyPress = FormKeyPress
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Image1: TImage
    Left = 1
    Top = 1
    Width = 128
    Height = 256
    OnClick = Image1Click
    OnMouseMove = Image1MouseMove
  end
  object Image2: TImage
    Left = 135
    Top = 1
    Width = 49
    Height = 49
  end
  object Shape1: TShape
    Left = 39
    Top = 104
    Width = 18
    Height = 17
    Brush.Style = bsClear
    Enabled = False
  end
  object Label1: TLabel
    Left = 144
    Top = 72
    Width = 24
    Height = 15
    Caption = '$00'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Fixedsys'
    Font.Style = []
    ParentFont = False
  end
end
