object Form1: TForm1
  Left = 199
  Top = 126
  BorderStyle = bsToolWindow
  Caption = 'Form1'
  ClientHeight = 214
  ClientWidth = 715
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel5: TBevel
    Left = 576
    Top = 0
    Width = 137
    Height = 212
  end
  object Bevel4: TBevel
    Left = 432
    Top = 0
    Width = 137
    Height = 212
  end
  object Bevel3: TBevel
    Left = 288
    Top = 0
    Width = 137
    Height = 212
  end
  object Bevel2: TBevel
    Left = 144
    Top = 0
    Width = 137
    Height = 212
  end
  object Bevel1: TBevel
    Left = 0
    Top = 0
    Width = 137
    Height = 212
  end
  object Image1: TImage
    Left = 4
    Top = 4
    Width = 128
    Height = 128
    Stretch = True
  end
  object Image2: TImage
    Left = 148
    Top = 4
    Width = 128
    Height = 128
    Stretch = True
  end
  object Image3: TImage
    Left = 292
    Top = 4
    Width = 128
    Height = 128
    Stretch = True
  end
  object Image4: TImage
    Left = 436
    Top = 4
    Width = 128
    Height = 128
    Stretch = True
  end
  object Image5: TImage
    Left = 580
    Top = 4
    Width = 128
    Height = 128
    Stretch = True
  end
  object Edit5: TEdit
    Tag = 4
    Left = 632
    Top = 184
    Width = 33
    Height = 21
    TabOrder = 33
    Text = '1'
    OnChange = Edit1Change
  end
  object Edit4: TEdit
    Tag = 3
    Left = 488
    Top = 184
    Width = 33
    Height = 21
    TabOrder = 26
    Text = '1'
    OnChange = Edit1Change
  end
  object Edit3: TEdit
    Tag = 2
    Left = 344
    Top = 184
    Width = 33
    Height = 21
    TabOrder = 19
    Text = '1'
    OnChange = Edit1Change
  end
  object Edit2: TEdit
    Tag = 1
    Left = 200
    Top = 184
    Width = 33
    Height = 21
    TabOrder = 12
    Text = '1'
    OnChange = Edit1Change
  end
  object Edit1: TEdit
    Left = 56
    Top = 184
    Width = 33
    Height = 21
    TabOrder = 5
    Text = '1'
    OnChange = Edit1Change
  end
  object LabeledEdit1: TLabeledEdit
    Left = 56
    Top = 136
    Width = 33
    Height = 21
    EditLabel.Width = 31
    EditLabel.Height = 13
    EditLabel.Caption = 'Height'
    LabelPosition = lpLeft
    TabOrder = 0
    Text = '128'
    OnChange = LabeledEdit1Change
  end
  object LabeledEdit2: TLabeledEdit
    Left = 56
    Top = 160
    Width = 33
    Height = 21
    EditLabel.Width = 28
    EditLabel.Height = 13
    EditLabel.Caption = 'Width'
    LabelPosition = lpLeft
    TabOrder = 1
    Text = '9'
    OnChange = LabeledEdit1Change
  end
  object UpDown1: TUpDown
    Left = 89
    Top = 136
    Width = 15
    Height = 21
    Associate = LabeledEdit1
    Min = 1
    Max = 128
    Position = 128
    TabOrder = 2
  end
  object UpDown2: TUpDown
    Left = 89
    Top = 160
    Width = 15
    Height = 21
    Associate = LabeledEdit2
    Min = 1
    Max = 255
    Position = 9
    TabOrder = 3
  end
  object LabeledEdit3: TLabeledEdit
    Left = 56
    Top = 184
    Width = 33
    Height = 21
    EditLabel.Width = 32
    EditLabel.Height = 13
    EditLabel.Caption = 'DeltaT'
    LabelPosition = lpLeft
    TabOrder = 4
    Text = '0,02'
    OnChange = LabeledEdit1Change
  end
  object UpDown3: TUpDown
    Left = 89
    Top = 184
    Width = 15
    Height = 21
    Associate = Edit1
    Min = 1
    Max = 255
    Position = 1
    TabOrder = 6
  end
  object LabeledEdit4: TLabeledEdit
    Tag = 1
    Left = 200
    Top = 136
    Width = 33
    Height = 21
    EditLabel.Width = 31
    EditLabel.Height = 13
    EditLabel.Caption = 'Height'
    LabelPosition = lpLeft
    TabOrder = 7
    Text = '128'
    OnChange = LabeledEdit1Change
  end
  object LabeledEdit5: TLabeledEdit
    Tag = 1
    Left = 200
    Top = 160
    Width = 33
    Height = 21
    EditLabel.Width = 28
    EditLabel.Height = 13
    EditLabel.Caption = 'Width'
    LabelPosition = lpLeft
    TabOrder = 8
    Text = '9'
    OnChange = LabeledEdit1Change
  end
  object UpDown4: TUpDown
    Left = 233
    Top = 136
    Width = 15
    Height = 21
    Associate = LabeledEdit4
    Min = 1
    Max = 128
    Position = 128
    TabOrder = 9
  end
  object UpDown5: TUpDown
    Left = 233
    Top = 160
    Width = 15
    Height = 21
    Associate = LabeledEdit5
    Min = 1
    Max = 255
    Position = 9
    TabOrder = 10
  end
  object LabeledEdit6: TLabeledEdit
    Tag = 1
    Left = 200
    Top = 184
    Width = 33
    Height = 21
    EditLabel.Width = 32
    EditLabel.Height = 13
    EditLabel.Caption = 'DeltaT'
    LabelPosition = lpLeft
    TabOrder = 11
    Text = '0,02'
    OnChange = LabeledEdit1Change
  end
  object UpDown6: TUpDown
    Left = 233
    Top = 184
    Width = 15
    Height = 21
    Associate = Edit2
    Min = 1
    Max = 255
    Position = 1
    TabOrder = 13
  end
  object LabeledEdit7: TLabeledEdit
    Tag = 2
    Left = 344
    Top = 136
    Width = 33
    Height = 21
    EditLabel.Width = 31
    EditLabel.Height = 13
    EditLabel.Caption = 'Height'
    LabelPosition = lpLeft
    TabOrder = 14
    Text = '128'
    OnChange = LabeledEdit1Change
  end
  object LabeledEdit8: TLabeledEdit
    Tag = 2
    Left = 344
    Top = 160
    Width = 33
    Height = 21
    EditLabel.Width = 28
    EditLabel.Height = 13
    EditLabel.Caption = 'Width'
    LabelPosition = lpLeft
    TabOrder = 15
    Text = '9'
    OnChange = LabeledEdit1Change
  end
  object UpDown7: TUpDown
    Left = 377
    Top = 136
    Width = 15
    Height = 21
    Associate = LabeledEdit7
    Min = 1
    Max = 128
    Position = 128
    TabOrder = 16
  end
  object UpDown8: TUpDown
    Left = 377
    Top = 160
    Width = 15
    Height = 21
    Associate = LabeledEdit8
    Min = 1
    Max = 255
    Position = 9
    TabOrder = 17
  end
  object LabeledEdit9: TLabeledEdit
    Tag = 2
    Left = 344
    Top = 184
    Width = 33
    Height = 21
    EditLabel.Width = 32
    EditLabel.Height = 13
    EditLabel.Caption = 'DeltaT'
    LabelPosition = lpLeft
    TabOrder = 18
    Text = '0,02'
    OnChange = LabeledEdit1Change
  end
  object UpDown9: TUpDown
    Left = 377
    Top = 184
    Width = 15
    Height = 21
    Associate = Edit3
    Min = 1
    Max = 255
    Position = 1
    TabOrder = 20
  end
  object LabeledEdit10: TLabeledEdit
    Tag = 3
    Left = 488
    Top = 136
    Width = 33
    Height = 21
    EditLabel.Width = 31
    EditLabel.Height = 13
    EditLabel.Caption = 'Height'
    LabelPosition = lpLeft
    TabOrder = 21
    Text = '128'
    OnChange = LabeledEdit1Change
  end
  object LabeledEdit11: TLabeledEdit
    Tag = 3
    Left = 488
    Top = 160
    Width = 33
    Height = 21
    EditLabel.Width = 28
    EditLabel.Height = 13
    EditLabel.Caption = 'Width'
    LabelPosition = lpLeft
    TabOrder = 22
    Text = '9'
    OnChange = LabeledEdit1Change
  end
  object UpDown10: TUpDown
    Left = 521
    Top = 136
    Width = 15
    Height = 21
    Associate = LabeledEdit10
    Min = 1
    Max = 128
    Position = 128
    TabOrder = 23
  end
  object UpDown11: TUpDown
    Left = 521
    Top = 160
    Width = 15
    Height = 21
    Associate = LabeledEdit11
    Min = 1
    Max = 255
    Position = 9
    TabOrder = 24
  end
  object LabeledEdit12: TLabeledEdit
    Tag = 3
    Left = 488
    Top = 184
    Width = 33
    Height = 21
    EditLabel.Width = 32
    EditLabel.Height = 13
    EditLabel.Caption = 'DeltaT'
    LabelPosition = lpLeft
    TabOrder = 25
    Text = '0,02'
    OnChange = LabeledEdit1Change
  end
  object UpDown12: TUpDown
    Left = 521
    Top = 184
    Width = 15
    Height = 21
    Associate = Edit4
    Min = 1
    Max = 255
    Position = 1
    TabOrder = 27
  end
  object LabeledEdit13: TLabeledEdit
    Tag = 4
    Left = 632
    Top = 136
    Width = 33
    Height = 21
    EditLabel.Width = 31
    EditLabel.Height = 13
    EditLabel.Caption = 'Height'
    LabelPosition = lpLeft
    TabOrder = 28
    Text = '128'
    OnChange = LabeledEdit1Change
  end
  object LabeledEdit14: TLabeledEdit
    Tag = 4
    Left = 632
    Top = 160
    Width = 33
    Height = 21
    EditLabel.Width = 28
    EditLabel.Height = 13
    EditLabel.Caption = 'Width'
    LabelPosition = lpLeft
    TabOrder = 29
    Text = '9'
    OnChange = LabeledEdit1Change
  end
  object UpDown13: TUpDown
    Left = 665
    Top = 136
    Width = 15
    Height = 21
    Associate = LabeledEdit13
    Min = 1
    Max = 128
    Position = 128
    TabOrder = 30
  end
  object UpDown14: TUpDown
    Left = 665
    Top = 160
    Width = 15
    Height = 21
    Associate = LabeledEdit14
    Min = 1
    Max = 255
    Position = 9
    TabOrder = 31
  end
  object LabeledEdit15: TLabeledEdit
    Tag = 4
    Left = 632
    Top = 184
    Width = 33
    Height = 21
    EditLabel.Width = 32
    EditLabel.Height = 13
    EditLabel.Caption = 'DeltaT'
    LabelPosition = lpLeft
    TabOrder = 32
    Text = '0,02'
    OnChange = LabeledEdit1Change
  end
  object UpDown15: TUpDown
    Left = 665
    Top = 184
    Width = 15
    Height = 21
    Associate = Edit5
    Min = 1
    Max = 255
    Position = 1
    TabOrder = 34
  end
  object MainMenu1: TMainMenu
    Left = 16
    Top = 16
    object File1: TMenuItem
      Caption = 'File'
      object Load1: TMenuItem
        Caption = 'Load'
        ShortCut = 16460
        OnClick = Load1Click
      end
      object Save1: TMenuItem
        Caption = 'Save'
        ShortCut = 16467
        OnClick = Save1Click
      end
      object N1: TMenuItem
        Caption = '-'
      end
      object Exit1: TMenuItem
        Caption = 'Exit'
        ShortCut = 16472
      end
    end
    object Generate1: TMenuItem
      Caption = 'Generate'
      OnClick = Generate1Click
    end
  end
  object OpenDialog1: TOpenDialog
    Left = 56
    Top = 16
  end
  object SaveDialog1: TSaveDialog
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 96
    Top = 16
  end
end
