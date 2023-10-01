object Form1: TForm1
  Left = 115
  Top = 166
  BorderStyle = bsToolWindow
  ClientHeight = 493
  ClientWidth = 911
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'MS Sans Serif'
  Font.Style = []
  KeyPreview = True
  Menu = MainMenu1
  OldCreateOrder = False
  OnCreate = FormCreate
  OnKeyUp = FormKeyUp
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Bevel1: TBevel
    Left = 304
    Top = 5
    Width = 289
    Height = 27
  end
  object Image1: TImage
    Left = 84
    Top = 34
    Width = 640
    Height = 304
    Enabled = False
    Stretch = True
    OnClick = Image1Click
    OnMouseDown = Image1MouseDown
    OnMouseMove = Image1MouseMove
    OnMouseUp = Image1MouseUp
  end
  object Image2: TImage
    Left = 2
    Top = 34
    Width = 80
    Height = 304
    Hint = 'Bitmap Colors'
    ParentShowHint = False
    ShowHint = True
  end
  object Image4: TImage
    Left = 136
    Top = 112
    Width = 105
    Height = 105
    Stretch = True
    Visible = False
    OnDblClick = Image4DblClick
    OnMouseDown = Image4MouseDown
    OnMouseMove = Image4MouseMove
  end
  object Label1: TLabel
    Left = 312
    Top = 10
    Width = 273
    Height = 15
    Alignment = taCenter
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Fixedsys'
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 608
    Top = 10
    Width = 113
    Height = 15
    Alignment = taCenter
    AutoSize = False
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Fixedsys'
    Font.Style = []
    ParentFont = False
  end
  object Image5: TImage
    Left = 727
    Top = 34
    Width = 48
    Height = 304
    Cursor = crHandPoint
    Hint = 'PMG Colors'
    ParentShowHint = False
    ShowHint = True
    OnClick = Image5Click
    OnMouseMove = Image2MouseMove
  end
  object Image6: TImage
    Left = 376
    Top = 80
    Width = 105
    Height = 105
    Visible = False
  end
  object Bevel2: TBevel
    Left = 777
    Top = 5
    Width = 129
    Height = 467
  end
  object Shape1: TShape
    Left = 104
    Top = 216
    Width = 65
    Height = 65
    Brush.Color = clRed
    Enabled = False
    Pen.Mode = pmMask
  end
  object Shape2: TShape
    Left = 112
    Top = 224
    Width = 65
    Height = 65
    Brush.Color = clRed
    Enabled = False
    Pen.Mode = pmMask
  end
  object Shape3: TShape
    Left = 120
    Top = 232
    Width = 65
    Height = 65
    Brush.Color = clRed
    Enabled = False
    Pen.Mode = pmMask
  end
  object Shape4: TShape
    Left = 128
    Top = 240
    Width = 65
    Height = 65
    Brush.Color = clRed
    Enabled = False
    Pen.Mode = pmMask
  end
  object Shape5: TShape
    Left = 136
    Top = 248
    Width = 65
    Height = 65
    Brush.Color = clRed
    Enabled = False
    Pen.Mode = pmMask
  end
  object Shape6: TShape
    Left = 144
    Top = 256
    Width = 65
    Height = 65
    Brush.Color = clRed
    Enabled = False
    Pen.Mode = pmMask
  end
  object Image7: TImage
    Left = 788
    Top = 14
    Width = 16
    Height = 16
    Hint = 'Time Limit'
    ParentShowHint = False
    Picture.Data = {
      07544269746D617036030000424D360300000000000036000000280000001000
      0000100000000100180000000000000300000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000173652255E922A71B1276F
      B0256DAF246DAF256DAF256DAF256DAF276FB02A71B1255E9217365200000000
      00000000002E74B444A0D873BFEAA4E0FBBDE9FCBDE9FCBEEAFDBEEBFEBFEBFE
      A5E1FB73BFE944A0D72E74B40000000000000000002873B6B4AEA5FFD4A5FFF0
      CEFFF9E4FFFAEFF3DBC1EED5BAFFE7BFFFECC9FFE0C6B4ADA32873B500000000
      0000000000010204D4AB8CFCD19EDBE9F2D2E4EFD6E6EE92BCD27EB1CC7CB2D1
      93BDD4FFF1D9D4AA89010204000000000000000000000000B09379F2C495BBCF
      CEC9E2EDCEE2EBA9CDDC8BBED488C0DAB6CFD8F4D4BAB0927800000000000000
      00000000000000001C1814DCBA9DFFCE9CD5D7C8C5E3ECB1DAE894CADBCED8D3
      FFE0C2DDBB9E1C18140000000000000000000000000000000000000A08078E79
      67F1C9A2FFD9B0FFEBCFFFDBB6F4CEAEA1897409070600000000000000000000
      00000000000000000000000000000000005E5044ECC7A6F0DFCCEECAAC5E4F42
      0000000000000000000000000000000000000000000000000000002A241FDDB9
      98F3D0A9ABCEDEBEDBEC82B8D3F1D9C1DEBEA42A241F00000000000000000000
      00000000000000002C251FE2BD9AFFD7A1F2EDE2DCF1F89FD0E089C8DED9DAD0
      FFECD0E2C3A82C241F000000000000000000000000000000DAB18FFFD695FFEF
      C8FFFFF2FFFFF4FFE3AFFFE8BAFFECC4FFF0CEFFEED1DAB08C00000000000000
      000000000012314D5381AA286FB01364AF1262AB1262AB1263AD1263AD1263AD
      1364AE2871B35380A912314D0000000000000000002E74B3469FD67AC1E7AFE4
      F9CAEFFCC9EEFCC9EEFCC9EEFCCAEFFCAFE4F97AC1E7469FD52E73B300000000
      00000000002E74B29DCAE887BEE272B8E261AFDF61AFDF61AFDF61AFDF61AFDF
      72B8E287BEE29DCAE82E74B200000000000000000003070B1A4469235B8E2C72
      B02D72B02D72B02D72B02D72B02D72B02C72B0235B8E1A446903070B00000000
      0000}
    ShowHint = True
  end
  object GroupBox3: TGroupBox
    Left = 781
    Top = 240
    Width = 121
    Height = 229
    Caption = 'PMG Overlay'
    TabOrder = 8
    object LabeledEdit6: TLabeledEdit
      Left = 43
      Top = 26
      Width = 29
      Height = 21
      EditLabel.Width = 26
      EditLabel.Height = 13
      EditLabel.Caption = 'P0_X'
      LabelPosition = lpLeft
      TabOrder = 0
      Text = '20'
      OnChange = LabeledEdit6Change
      OnEnter = LabeledEdit6Change
    end
    object LabeledEdit8: TLabeledEdit
      Left = 43
      Top = 72
      Width = 29
      Height = 21
      EditLabel.Width = 26
      EditLabel.Height = 13
      EditLabel.Caption = 'P1_X'
      LabelPosition = lpLeft
      TabOrder = 1
      Text = '60'
      OnChange = LabeledEdit6Change
      OnEnter = LabeledEdit6Change
    end
    object LabeledEdit9: TLabeledEdit
      Left = 43
      Top = 120
      Width = 29
      Height = 21
      EditLabel.Width = 26
      EditLabel.Height = 13
      EditLabel.Caption = 'P2_X'
      LabelPosition = lpLeft
      TabOrder = 2
      Text = '100'
      OnChange = LabeledEdit6Change
      OnEnter = LabeledEdit6Change
    end
    object UpDown4: TUpDown
      Left = 72
      Top = 26
      Width = 25
      Height = 21
      Associate = LabeledEdit6
      Max = 128
      Orientation = udHorizontal
      Position = 20
      TabOrder = 3
    end
    object UpDown5: TUpDown
      Left = 72
      Top = 72
      Width = 25
      Height = 21
      Associate = LabeledEdit8
      Max = 128
      Orientation = udHorizontal
      Position = 60
      TabOrder = 4
    end
    object UpDown6: TUpDown
      Left = 72
      Top = 120
      Width = 25
      Height = 21
      Associate = LabeledEdit9
      Max = 128
      Orientation = udHorizontal
      Position = 100
      TabOrder = 5
    end
    object LabeledEdit7: TLabeledEdit
      Left = 43
      Top = 46
      Width = 29
      Height = 21
      EditLabel.Width = 28
      EditLabel.Height = 13
      EditLabel.Caption = 'M0_X'
      LabelPosition = lpLeft
      TabOrder = 6
      Text = '52'
      OnChange = LabeledEdit6Change
      OnEnter = LabeledEdit6Change
    end
    object LabeledEdit10: TLabeledEdit
      Left = 43
      Top = 92
      Width = 29
      Height = 21
      EditLabel.Width = 28
      EditLabel.Height = 13
      EditLabel.Caption = 'M1_X'
      LabelPosition = lpLeft
      TabOrder = 7
      Text = '92'
      OnChange = LabeledEdit6Change
      OnEnter = LabeledEdit6Change
    end
    object LabeledEdit11: TLabeledEdit
      Left = 43
      Top = 140
      Width = 29
      Height = 21
      EditLabel.Width = 28
      EditLabel.Height = 13
      EditLabel.Caption = 'M2_X'
      LabelPosition = lpLeft
      TabOrder = 8
      Text = '132'
      OnChange = LabeledEdit6Change
      OnEnter = LabeledEdit6Change
    end
    object UpDown7: TUpDown
      Left = 72
      Top = 46
      Width = 25
      Height = 21
      Associate = LabeledEdit7
      Max = 152
      Orientation = udHorizontal
      Position = 52
      TabOrder = 9
    end
    object UpDown8: TUpDown
      Left = 72
      Top = 92
      Width = 25
      Height = 21
      Associate = LabeledEdit10
      Max = 152
      Orientation = udHorizontal
      Position = 92
      TabOrder = 10
    end
    object UpDown9: TUpDown
      Left = 72
      Top = 140
      Width = 25
      Height = 21
      Associate = LabeledEdit11
      Max = 152
      Orientation = udHorizontal
      Position = 132
      TabOrder = 11
    end
    object PMGEnabled: TCheckBox
      Left = 21
      Top = 209
      Width = 84
      Height = 17
      Caption = 'Enabled'
      Checked = True
      State = cbChecked
      TabOrder = 12
      OnClick = PMGEnabledClick
    end
    object OverlayHeight: TLabeledEdit
      Left = 45
      Top = 164
      Width = 34
      Height = 21
      EditLabel.Width = 31
      EditLabel.Height = 13
      EditLabel.Caption = 'Height'
      LabelPosition = lpLeft
      TabOrder = 13
      Text = '14'
      OnChange = LabeledEdit6Change
    end
    object UpDown10: TUpDown
      Left = 79
      Top = 164
      Width = 16
      Height = 21
      Associate = OverlayHeight
      Min = 1
      Max = 14
      Increment = -1
      Position = 14
      TabOrder = 14
    end
    object OverlayOrder: TCheckListBox
      Left = 2
      Top = 191
      Width = 116
      Height = 18
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      Color = clBtnFace
      Columns = 4
      ItemHeight = 13
      Items.Strings = (
        '3'
        '2'
        '1'
        '0')
      TabOrder = 15
      OnClick = OverlayOrderClick
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 474
    Width = 911
    Height = 19
    Panels = <
      item
        Alignment = taCenter
        Width = 200
      end
      item
        Width = 200
      end>
  end
  object ScrollBox1: TScrollBox
    Left = 2
    Top = 344
    Width = 773
    Height = 128
    Enabled = False
    TabOrder = 0
    object Image3: TImage
      Left = 0
      Top = 0
      Width = 119
      Height = 88
      Stretch = True
      OnClick = Image3Click
      OnMouseLeave = Image3MouseLeave
      OnMouseMove = Image3MouseMove
    end
  end
  object SelectMode: TRadioGroup
    Left = 84
    Top = 0
    Width = 213
    Height = 33
    Caption = 'MODE'
    Columns = 3
    ItemIndex = 1
    Items.Strings = (
      'INSERT'
      'EDIT'
      'PMG')
    TabOrder = 1
    OnClick = SelectModeClick
  end
  object LabeledEdit1: TLabeledEdit
    Left = 360
    Top = 232
    Width = 49
    Height = 21
    Color = clYellow
    EditLabel.Width = 48
    EditLabel.Height = 13
    EditLabel.Caption = 'Parameter'
    TabOrder = 2
    Text = '0'
    Visible = False
    OnKeyPress = LabeledEdit1KeyPress
  end
  object LabeledEdit2: TLabeledEdit
    Left = 416
    Top = 232
    Width = 42
    Height = 21
    Color = clYellow
    EditLabel.Width = 43
    EditLabel.Height = 13
    EditLabel.Caption = 'Group ID'
    TabOrder = 3
    Text = '0'
    Visible = False
    OnKeyPress = LabeledEdit2KeyPress
  end
  object GroupBox1: TGroupBox
    Left = 781
    Top = 37
    Width = 120
    Height = 132
    Caption = ' Bonus '
    TabOrder = 4
    object CheckBox7: TCheckBox
      Left = 8
      Top = 18
      Width = 97
      Height = 17
      Caption = 'Heart'
      TabOrder = 0
    end
    object CheckBox8: TCheckBox
      Left = 8
      Top = 36
      Width = 97
      Height = 17
      Caption = 'Shield'
      TabOrder = 1
    end
    object CheckBox9: TCheckBox
      Left = 8
      Top = 54
      Width = 97
      Height = 17
      Caption = 'Clock'
      TabOrder = 2
    end
    object CheckBox10: TCheckBox
      Left = 8
      Top = 72
      Width = 105
      Height = 17
      Caption = 'Harpoon + hook'
      TabOrder = 3
    end
    object CheckBox11: TCheckBox
      Left = 8
      Top = 90
      Width = 97
      Height = 17
      Caption = 'Harpoon'
      TabOrder = 4
    end
    object CheckBox12: TCheckBox
      Left = 8
      Top = 108
      Width = 97
      Height = 17
      Caption = 'Dynamit'
      TabOrder = 5
    end
  end
  object GroupBox2: TGroupBox
    Left = 781
    Top = 171
    Width = 120
    Height = 70
    Caption = ' Hero '
    TabOrder = 5
    object UpDown1: TUpDown
      Left = 89
      Top = 16
      Width = 21
      Height = 21
      Associate = LabeledEdit4
      Max = 37
      Orientation = udHorizontal
      TabOrder = 0
    end
    object UpDown2: TUpDown
      Left = 89
      Top = 42
      Width = 21
      Height = 21
      Associate = LabeledEdit5
      Min = 15
      Max = 0
      TabOrder = 1
    end
    object LabeledEdit4: TLabeledEdit
      Left = 48
      Top = 16
      Width = 41
      Height = 21
      EditLabel.Width = 35
      EditLabel.Height = 13
      EditLabel.Caption = 'POS X '
      LabelPosition = lpLeft
      TabOrder = 2
      Text = '0'
      OnChange = LabeledEdit4Change
      OnEnter = LabeledEdit4Change
    end
    object LabeledEdit5: TLabeledEdit
      Left = 48
      Top = 42
      Width = 41
      Height = 21
      EditLabel.Width = 35
      EditLabel.Height = 13
      EditLabel.Caption = 'POS Y '
      LabelPosition = lpLeft
      TabOrder = 3
      Text = '0'
      OnChange = LabeledEdit4Change
      OnEnter = LabeledEdit4Change
    end
  end
  object Minutes: TUpDown
    Left = 832
    Top = 12
    Width = 16
    Height = 21
    Associate = TimeLimit
    Max = 3
    Position = 2
    TabOrder = 6
  end
  object TimeLimitSeconds: TEdit
    Left = 854
    Top = 12
    Width = 24
    Height = 21
    Hint = 'Seconds'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 9
    Text = '0'
  end
  object Seconds: TUpDown
    Left = 878
    Top = 12
    Width = 16
    Height = 21
    Associate = TimeLimitSeconds
    Max = 60
    TabOrder = 10
  end
  object TimeLimit: TEdit
    Left = 808
    Top = 12
    Width = 24
    Height = 21
    Hint = 'Minutes'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 11
    Text = '2'
  end
  object OpenDialog1: TOpenDialog
    Filter = '*.*|*.*|*.tex|*.tex|*.obj|*.obj|*.lev|*.lev'
    Left = 88
    Top = 40
  end
  object SaveDialog1: TSaveDialog
    DefaultExt = '*.lev'
    Filter = '*.*|*.*|*.lev|*.lev|*.tex|*.tex'
    Options = [ofOverwritePrompt, ofHideReadOnly, ofEnableSizing]
    Left = 120
    Top = 40
  end
  object MainMenu1: TMainMenu
    Left = 56
    Top = 40
    object File1: TMenuItem
      Caption = 'File'
      object NewLEVEL1: TMenuItem
        Caption = 'New LEVEL'
        ShortCut = 16462
        OnClick = NewLEVEL1Click
      end
      object N3: TMenuItem
        Caption = '-'
      end
      object LoadTEX1: TMenuItem
        Caption = 'Load *.TEX'
        ShortCut = 16468
        OnClick = LoadTEX1Click
      end
      object lOADlev1: TMenuItem
        Caption = 'Load *.LEV'
        ShortCut = 16460
        OnClick = lOADlev1Click
      end
      object N2: TMenuItem
        Caption = '-'
      end
      object SaveTEX1: TMenuItem
        Caption = 'Save *.TEX'
        Visible = False
        OnClick = SaveTEX1Click
      end
      object N1: TMenuItem
        Caption = 'Save *.LEV'
        ShortCut = 16467
        OnClick = N1Click
      end
    end
    object Edit1: TMenuItem
      Caption = 'Edit'
      object Undo1: TMenuItem
        Caption = 'Undo'
        Enabled = False
        ShortCut = 16474
        OnClick = Undo1Click
      end
      object Redo1: TMenuItem
        Caption = 'Redo'
        Enabled = False
        ShortCut = 24666
        OnClick = Redo1Click
      end
    end
    object View1: TMenuItem
      Caption = 'View'
      object Grid1: TMenuItem
        Caption = 'Grid'
        OnClick = Grid1Click
      end
    end
    object PMGOverlay1: TMenuItem
      Caption = 'PMG Overlay'
      object Priority11: TMenuItem
        Caption = 'Priority=1'
        OnClick = Priority11Click
      end
      object Priority81: TMenuItem
        Caption = 'Priority=8'
        Checked = True
        OnClick = Priority81Click
      end
      object N6: TMenuItem
        Caption = '-'
      end
      object Clear1: TMenuItem
        Caption = 'Clear All'
        OnClick = Clear1Click
      end
    end
  end
  object PopupMenu1: TPopupMenu
    OwnerDraw = True
    Left = 216
    Top = 80
    object Insert1: TMenuItem
      Caption = 'Paste'
      OnClick = Insert1Click
    end
  end
  object PopupMenu2: TPopupMenu
    Left = 256
    Top = 80
    object Er1: TMenuItem
      Caption = 'Bring to Front'
      OnClick = Er1Click
    end
    object SendtoBack1: TMenuItem
      Caption = 'Send to Back'
      OnClick = SendtoBack1Click
    end
    object N4: TMenuItem
      Caption = '-'
    end
    object SetPMGOverlay1: TMenuItem
      Caption = 'Add PMG Overlay'
      OnClick = SetPMGOverlay1Click
    end
    object ClrPMGOverlay1: TMenuItem
      Caption = 'Clr PMG Overlay'
      OnClick = ClrPMGOverlay1Click
    end
    object Parameter1: TMenuItem
      Caption = 'Parameter'
      OnClick = Parameter1Click
    end
    object Group1: TMenuItem
      Caption = 'Group ID'
      OnClick = Group1Click
    end
    object Delete2: TMenuItem
      Caption = '-'
    end
    object Copy1: TMenuItem
      Caption = 'Copy'
      OnClick = Copy1Click
    end
    object N5: TMenuItem
      Caption = '-'
    end
    object Delete1: TMenuItem
      Caption = 'Delete'
      OnClick = Delete1Click
    end
  end
end
