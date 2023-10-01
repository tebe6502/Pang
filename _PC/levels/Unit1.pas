// PANG level editor (17.09.2008 - 04.02.2012) by Tomasz Biela

// maksymalny rozmiar obiektu 16x16 znaków
// maksymalna wysokosc edytowanego pola gry 19 wierszy, szerokosc max. 48 znakow

// maksymalna liczba u¿ywanych obiektów 256


unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, IniFiles, Menus, ComCtrls, CheckLst, ShlObj;

type
  TForm1 = class(TForm)
    Image1: TImage;
    OpenDialog1: TOpenDialog;
    SaveDialog1: TSaveDialog;
    Image2: TImage;
    StatusBar1: TStatusBar;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    LoadTEX1: TMenuItem;
    ScrollBox1: TScrollBox;
    Image3: TImage;
    Image4: TImage;
    View1: TMenuItem;
    Grid1: TMenuItem;
    PopupMenu1: TPopupMenu;
    Insert1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    lOADlev1: TMenuItem;
    NewLEVEL1: TMenuItem;
    N3: TMenuItem;
    SelectMode: TRadioGroup;
    PopupMenu2: TPopupMenu;
    Er1: TMenuItem;
    SendtoBack1: TMenuItem;
    Parameter1: TMenuItem;
    Delete2: TMenuItem;
    N4: TMenuItem;
    Bevel1: TBevel;
    Label1: TLabel;
    LabeledEdit1: TLabeledEdit;
    Group1: TMenuItem;
    LabeledEdit2: TLabeledEdit;
    Edit1: TMenuItem;
    Undo1: TMenuItem;
    Redo1: TMenuItem;
    Copy1: TMenuItem;
    N5: TMenuItem;
    Delete1: TMenuItem;
    SaveTEX1: TMenuItem;
    Label2: TLabel;
    Image5: TImage;
    GroupBox1: TGroupBox;
    CheckBox7: TCheckBox;
    CheckBox8: TCheckBox;
    CheckBox9: TCheckBox;
    CheckBox10: TCheckBox;
    CheckBox11: TCheckBox;
    CheckBox12: TCheckBox;
    GroupBox2: TGroupBox;
    UpDown1: TUpDown;
    UpDown2: TUpDown;
    Image6: TImage;
    Minutes: TUpDown;
    Bevel2: TBevel;
    LabeledEdit4: TLabeledEdit;
    LabeledEdit5: TLabeledEdit;
    GroupBox3: TGroupBox;
    SetPMGOverlay1: TMenuItem;
    LabeledEdit6: TLabeledEdit;
    LabeledEdit8: TLabeledEdit;
    LabeledEdit9: TLabeledEdit;
    UpDown4: TUpDown;
    UpDown5: TUpDown;
    UpDown6: TUpDown;
    LabeledEdit7: TLabeledEdit;
    LabeledEdit10: TLabeledEdit;
    LabeledEdit11: TLabeledEdit;
    UpDown7: TUpDown;
    UpDown8: TUpDown;
    UpDown9: TUpDown;
    PMGOverlay1: TMenuItem;
    Clear1: TMenuItem;
    N6: TMenuItem;
    Priority11: TMenuItem;
    Priority81: TMenuItem;
    Shape1: TShape;
    Shape2: TShape;
    Shape3: TShape;
    Shape4: TShape;
    Shape5: TShape;
    Shape6: TShape;
    ClrPMGOverlay1: TMenuItem;
    PMGEnabled: TCheckBox;
    OverlayHeight: TLabeledEdit;
    UpDown10: TUpDown;
    OverlayOrder: TCheckListBox;
    TimeLimitSeconds: TEdit;
    Seconds: TUpDown;
    TimeLimit: TEdit;
    Image7: TImage;
    procedure FormCreate(Sender: TObject);
    procedure LoadTEX1Click(Sender: TObject);
    procedure Image3MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image3Click(Sender: TObject);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image1Click(Sender: TObject);
    procedure Grid1Click(Sender: TObject);
    procedure Image4MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Insert1Click(Sender: TObject);
    procedure lOADlev1Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure NewLEVEL1Click(Sender: TObject);
    procedure SelectModeClick(Sender: TObject);
    procedure Image1MouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Er1Click(Sender: TObject);
    procedure SendtoBack1Click(Sender: TObject);
    procedure Image4DblClick(Sender: TObject);
    procedure Image4MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Parameter1Click(Sender: TObject);
    procedure LabeledEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure Group1Click(Sender: TObject);
    procedure LabeledEdit2KeyPress(Sender: TObject; var Key: Char);
    procedure Image1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure Undo1Click(Sender: TObject);
    procedure Redo1Click(Sender: TObject);
    procedure Delete1Click(Sender: TObject);
    procedure Copy1Click(Sender: TObject);
    procedure SaveTEX1Click(Sender: TObject);
    procedure Image2MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure LabeledEdit4Change(Sender: TObject);
    procedure SetPMGOverlay1Click(Sender: TObject);
    procedure LabeledEdit6Change(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Clear1Click(Sender: TObject);
    procedure Priority11Click(Sender: TObject);
    procedure Priority81Click(Sender: TObject);
    procedure ClrPMGOverlay1Click(Sender: TObject);
    procedure PMGEnabledClick(Sender: TObject);
    procedure Image5Click(Sender: TObject);
    procedure Image3MouseLeave(Sender: TObject);
    procedure FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure OverlayOrderClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

type
    __objlist = record
                 x, y, o, p, g: byte;
                 d: Boolean;
                end;

    __overlay = array [0..159, 0..19] of record
                                         pmg: byte;
                                         use: Boolean;
                                         end;

var
  Form1: TForm1;

  path, texture, objf, temp: string;

  mrugaj: byte;

  objw, objh, objc, border, max_balls, undo_index, undo_index_max: integer;

  objActive: integer = -1;

  scrWidth: integer = 40;
  scrHeight: integer = 19;

  editObj, copyObj: Boolean;

  ObjSelPos, pmov, img1Mov: TPoint;

  bMarquee : Boolean;
  ptOrigin, ptMove, palMov, ovrxy : TPoint;

  objList, objTemp, objCOPY: array of __objlist;

  tmpObj: array [0..48*19] of integer;

  OverlayColors: array [0..2, 0..18] of byte;

  ovr, ovrUNDO, ovrREDO: __overlay;

  tex: array [0..40*160] of byte;
  map: array [0..1023] of byte;
  col: array [0..5*19] of byte;

  set_pm: integer = -1;

  sel_obj_width: array [0..1023] of integer;

  obj: array [0..255] of record
                        t: string;
                        i, w, h, v, g: byte;
                        f: string;
                        c: array [0..1] of byte;
                        buf: array [0..19*128] of byte;
                        tc: integer;
                        ovr: Boolean;
                       end;

const

aPal: array [0..255] of TColor=
 ($00000000, $003B3B3B, $00494949, $00575757,
 $00656565, $00737373, $00818181, $008F8F8F,
 $009D9D9D, $00ABABAB, $00B9B9B9, $00C7C7C7,
 $00D5D5D5, $00E3E3E3, $00F1F1F1, $00FFFFFF,
 $0000235C, $0000316A, $00003F78, $000A4D86,
 $00185B94, $002669A2, $003477B0, $004285BE,
 $005093CC, $005EA1DA, $006CAFE8, $007ABDF6,
 $0088CBFF, $0096D9FF, $00A4E7FF, $00B2F5FF,
 $00091469, $00172277, $00253085, $00333E93,
 $00414CA1, $004F5AAF, $005D68BD, $006B76CB,
 $007984D9, $008792E7, $0095A0F5, $00A3AEFF,
 $00B1BCFF, $00BFCAFF, $00CDD8FF, $00DBE6FF,
 $00380A6C, $0046187A, $00542688, $00623496,
 $007042A4, $007E50B2, $008C5EC0, $009A6CCE,
 $00A87ADC, $00B688EA, $00C496F8, $00D2A4FF,
 $00E0B2FF, $00EEC0FF, $00FCCEFF, $00FFDCFF,
 $00650564, $00731372, $00812180, $008F2F8E,
 $009D3D9C, $00AB4BAA, $00B959B8, $00C767C6,
 $00D575D4, $00E383E2, $00F191F0, $00FF9FFE,
 $00FFADFF, $00FFBBFF, $00FFC9FF, $00FFD7FF,
 $00890752, $00971560, $00A5236E, $00B3317C,
 $00C13F8A, $00CF4D98, $00DD5BA6, $00EB69B4,
 $00F977C2, $00FF85D0, $00FF93DE, $00FFA1EC,
 $00FFAFFA, $00FFBDFF, $00FFCBFF, $00FFD9FF,
 $009C103A, $00AA1E48, $00B82C56, $00C63A64,
 $00D44872, $00E25680, $00F0648E, $00FE729C,
 $00FF80AA, $00FF8EB8, $00FF9CC6, $00FFAAD4,
 $00FFB8E2, $00FFC6F0, $00FFD4FE, $00FFE2FF,
 $009C1E1F, $00AA2C2D, $00B83A3B, $00C64849,
 $00D45657, $00E26465, $00F07273, $00FE8081,
 $00FF8E8F, $00FF9C9D, $00FFAAAB, $00FFB8B9,
 $00FFC6C7, $00FFD4D5, $00FFE2E3, $00FFF0F1,
 $00892E07, $00973C15, $00A54A23, $00B35831,
 $00C1663F, $00CF744D, $00DD825B, $00EB9069,
 $00F99E77, $00FFAC85, $00FFBA93, $00FFC8A1,
 $00FFD6AF, $00FFE4BD, $00FFF2CB, $00FFFFD9,
 $00653E00, $00734C03, $00815A11, $008F681F,
 $009D762D, $00AB843B, $00B99249, $00C7A057,
 $00D5AE65, $00E3BC73, $00F1CA81, $00FFD88F,
 $00FFE69D, $00FFF4AB, $00FFFFB9, $00FFFFC7,
 $00384B00, $00465900, $00546709, $00627517,
 $00708325, $007E9133, $008C9F41, $009AAD4F,
 $00A8BB5D, $00B6C96B, $00C4D779, $00D2E587,
 $00E0F395, $00EEFFA3, $00FCFFB1, $00FFFFBF,
 $00095200, $00176000, $00256E0C, $00337C1A,
 $00418A28, $004F9836, $005DA644, $006BB452,
 $0079C260, $0087D06E, $0095DE7C, $00A3EC8A,
 $00B1FA98, $00BFFFA6, $00CDFFB4, $00DBFFC2,
 $00005300, $0000610B, $00006F19, $000A7D27,
 $00188B35, $00269943, $0034A751, $0042B55F,
 $0050C36D, $005ED17B, $006CDF89, $007AED97,
 $0088FBA5, $0096FFB3, $00A4FFC1, $00B2FFCF,
 $00004E13, $00005C21, $00006A2F, $0000783D,
 $0000864B, $000B9459, $0019A267, $0027B075,
 $0035BE83, $0043CC91, $0051DA9F, $005FE8AD,
 $006DF6BB, $007BFFC9, $0089FFD7, $0097FFE5,
 $0000432D, $0000513B, $00005F49, $00006D57,
 $00007B65, $00018973, $000F9781, $001DA58F,
 $002BB39D, $0039C1AB, $0047CFB9, $0055DDC7,
 $0063EBD5, $0071F9E3, $007FFFF1, $008DFFFF,
 $00003346, $00004154, $00004F62, $00005D70,
 $00006B7E, $000B798C, $0019879A, $002795A8,
 $0035A3B6, $0043B1C4, $0051BFD2, $005FCDE0,
 $006DDBEE, $007BE9FC, $0089F7FF, $0097FFFF);

 title = 'Pang XE/XL Level Editor v4.1 (04.02.2012) Tebe/Madteam';

implementation

uses Unit2;

{$R *.dfm}


procedure SaveRES(a,b:string);
var Res: TResourceStream;
begin
 Res := TResourceStream.Create(hInstance,a,RT_RCDATA); // wyciagnij plik
 Res.SaveToFile(b);                                    // zapisz na dysku
 Res.Free;                                             // zwolnij zmienna
end;


function GetTempFile: string;
begin
 Result:=temp+'panglvlundo'+IntToStr(undo_index)+'.tmp';
end;


procedure WriteUndoStream(var lStream: TMemoryStream);
var k,i: integer;
begin

 k:=High(objList);

 lStream.Write(k, sizeof(k));

 for i:=0 to  k-1 do
  lStream.Write(objList[i], sizeof(__objList));

 lStream.Write(ovr, sizeof(__overlay));

end;


procedure ReadUndoStream(var lStream: TMemoryStream);
var k,i: integer;
begin

 lStream.Read(k, sizeof(k));

 SetLength(objList, k+1);

 for i:=0 to  k-1 do
  lStream.Read(objList[i], sizeof(__objList));

 lStream.Read(ovr, sizeof(__overlay));

end;


procedure ZapiszUndo;
var lStream: TmemoryStream;
begin

 lStream := TMemoryStream.Create;

 WriteUndoStream(lStream);

 lStream.SaveToFile(GetTempFile);

 lStream.Free;


 inc(undo_index);
 undo_index_max:=undo_index;

 form1.Undo1.Enabled:=true;

 form1.Redo1.Enabled:=undo_index<undo_index_max;

end;


procedure CzytajUndo;
var lStream: TmemoryStream;
begin

 if undo_index=0 then exit;

 dec(undo_index);

// form1.Caption:=inttostr(undo_index)+'/'+inttostr(undo_index_max);

 if not(FileExists(GetTempFile)) then exit;


 lStream := TMemoryStream.Create;

 lStream.LoadFromFile(GetTempFile);

 ReadUndoStream(lStream);

 lStream.Free;

 if undo_index=0 then form1.Undo1.Enabled:=false;

 form1.Redo1.Enabled:=undo_index<undo_index_max;

 if undo_index=undo_index_max then form1.Redo1.Enabled:=false;

end;



{procedure ZapiszUNDO;
begin

 objUNDO := objList;
 ovrUNDO := ovr;

 SeTLength(objUNDO, length(objList));

 form1.Undo1.Enabled:=true;
end;    }


procedure shw_pal;
var x, y: byte;
begin

 with form1.Image2.Canvas do begin
  Pen.Color:=clBtnFace; Brush.Color:=clBtnFace;
  rectangle(0,0,80,304);
 end;

 for x:=0 to 4 do
  for y:=0 to scrHeight-1 do
   with form1.Image2.Canvas do begin
    Pen.Color:=aPal[col[y*5+x]];
    Brush.Color:=Pen.Color;
    Rectangle(x shl 4, y shl 4, x shl 4+15, y shl 4+15);

    Pen.Color:=0;
    Brush.Style:=bsClear;
    Rectangle(x shl 4,y shl 4,x shl 4+15,y shl 4+15);
   end;

end;


procedure shw_grid;
var x: integer;
begin

 with form1.Image1.Canvas do begin
  Pen.Color:=clGray;
  Pen.Style:=psSolid; Pen.Mode:=pmMergeNotPen; Pen.Width:=1;
  Brush.Style:=bsClear;

  for x:=1 to scrWidth-1 do begin
   moveto(x shl 3,0); lineto(x shl 3, form1.Image1.Height);
  end;

  for x:=1 to scrHeight-1 do begin
   moveto(0, x shl 3); lineto(form1.Image1.Width, x shl 3);
  end;

 end;

end;


procedure ShowOverlayColors;
var x, y: integer;
begin

 with form1.Image5.Canvas do begin
  Pen.Color:=clBtnFace; Brush.Color:=clBtnFace;
  rectangle(0,0,48,304);
 end;

 for x:=0 to 2 do
  for y:=0 to StrToInt(form1.OverlayHeight.Text)-1 do
   with form1.Image5.Canvas do begin

    Pen.Color:=aPal[OverlayColors[x,y]];
    Brush.Color:=Pen.Color;
    Rectangle(x shl 4, y shl 4, x shl 4+15, y shl 4+15);

    Pen.Color:=0;
    Brush.Style:=bsClear;
    Rectangle(x shl 4,y shl 4,x shl 4+15,y shl 4+15);
   end;

end;


procedure shw_tex;
var bmp: TBitmap;
    x, y, j, v, l, c: byte;
    k: PByteArray;
    ix, i: integer;
    cl: TColor;
    tc: Boolean;
    kul: array [0..4] of byte;
begin

 bmp:=TBitmap.Create;
 bmp.PixelFormat:=pf24bit;
 bmp.Width:=scrWidth shl 3;
 bmp.Height:=scrHeight shl 3;

 form1.image1.Width:=bmp.Width shl 1;
 form1.Image1.Height:=bmp.Height shl 1;


 fillchar(kul, sizeof(kul), 0);

 for y:=0 to (scrHeight shl 3)-1 do begin

  k:=bmp.ScanLine[y];
  ix:=0;

  for x:=0 to scrWidth-1 do begin
   v:=tex[x+y*scrWidth];

   for l:=0 to 3 do begin

    c:=(v and $c0) shr 6;

    if v and $c0=$c0 then
     if map[x+(y shr 3)*48+4]=$80 then inc(c);

    cl:=aPal[col[c + (y shr 3)*5]];

    k[ix*3]   := GetBValue(cl);
    k[ix*3+1] := GetGValue(cl);
    k[ix*3+2] := GetRValue(cl);

    inc(ix);

    k[ix*3]   := GetBValue(cl);
    k[ix*3+1] := GetGValue(cl);
    k[ix*3+2] := GetRValue(cl);

    inc(ix);

    v:=v shl 2;
   end;

  end;

 end;

 
// ---------------------------------------------------
//  wstawienie obiektów
// ---------------------------------------------------

 for i:=0 to High(objList)-1 do
  if (objList[i].o<=objc) and not(objList[i].d) then begin

   if objList[i].o in [0..4] then inc(kul[objList[i].o]);

   for y:=0 to (obj[objList[i].o].h shl 3)-1 do begin

    k:=bmp.ScanLine[y+objList[i].y shl 3];
    ix:=objList[i].x shl 3;

    for x:=0 to obj[objList[i].o].w-1 do begin

     v:=obj[objList[i].o].buf[x+y*16];

     for l:=0 to 3 do begin

      c:=(v and $c0) shr 6;

      if v and $c0=$c0 then
       if obj[objList[i].o].i<>0 then inc(c);

      cl:=aPal[col[c+(objList[i].y+y shr 3)*5]];

      if ovr[objList[i].x*4+l,objList[i].y].use then begin

       if form1.PMGEnabled.Checked then begin

       if form1.Priority11.Checked then
        case ovr[objList[i].x*4+l,objList[i].y].pmg and $7f of
         1: cl:=aPal[OverlayColors[0, y shr 3+objList[i].y]];
         2: cl:=aPal[OverlayColors[1, y shr 3+objList[i].y]];
         3: cl:=aPal[OverlayColors[2, y shr 3+objList[i].y]];
        end;

       if form1.Priority81.Checked and (v and $c0 in [$00,$c0]) then
        case ovr[objList[i].x*4+l,objList[i].y].pmg and $7f of
         1: cl:=aPal[OverlayColors[0, y shr 3+objList[i].y]];
         2: cl:=aPal[OverlayColors[1, y shr 3+objList[i].y]];
         3: cl:=aPal[OverlayColors[2, y shr 3+objList[i].y]];
        end;

       end;

      end;

      tc:=true;
      if obj[objList[i].o].tc>=0 then
       tc:= (v and $c0) <> (obj[objList[i].o].tc and $c0);


      if tc then begin
       k[ix*3]   := GetBValue(cl);
       k[ix*3+1] := GetGValue(cl);
       k[ix*3+2] := GetRValue(cl);
      end;

      inc(ix);

      if tc then begin
       k[ix*3]   := GetBValue(cl);
       k[ix*3+1] := GetGValue(cl);
       k[ix*3+2] := GetRValue(cl);
      end;

      inc(ix);

      v:=v shl 2;
     end;

    end;

   end;
  end;

 form1.Image1.Picture.Bitmap:=bmp;


// ---------------------------------------------------
//  murek z prawej strony
// ---------------------------------------------------
{
   bmp.Width:=8; bmp.Height:=form1.image1.height shr 1;

   i:=border;

   if i<5 then i:=5;

   for j:=0 to 18 do
   for y:=0 to 7 do begin

    k:=bmp.ScanLine[y+j*8];
    ix:=0;

    for x:=0 to 0 do begin

     v:=obj[i].buf[x+y*16];

     for l:=0 to 3 do begin

      c:=(v and $c0) shr 6;

      if v and $c0=$c0 then
       if obj[i].i<>0 then inc(c);

      cl:=aPal[col[c+((y+j*8) shr 3)*5]];

      k[ix*3]   := GetBValue(cl);
      k[ix*3+1] := GetGValue(cl);
      k[ix*3+2] := GetRValue(cl);

      inc(ix);

      k[ix*3]   := GetBValue(cl);
      k[ix*3+1] := GetGValue(cl);
      k[ix*3+2] := GetRValue(cl);

      inc(ix);

      v:=v shl 2;
     end;

    end;

   end;

 form1.Image5.Picture.Bitmap:=bmp;
}

 ShowOverlayColors;

 if form1.Grid1.Checked then shw_grid;

 bmp.Free;

 shw_pal;

 max_balls:=kul[0]*16+kul[1]*8+kul[2]*4+kul[3]*2+kul[4];

 form1.label2.Caption:='BALLS: '+IntToStr(kul[0]+kul[1]+kul[2]+kul[3]+kul[4])+'/'+IntToStr(max_balls);

end;


procedure shw_obj;
var bmp: TBitmap;
    v, l, c: byte;
    x, y, ix, i, ad, ni, h: integer;
    k: PByteArray;
    cl: TColor;
begin

 bmp:=TBitmap.Create;
 bmp.PixelFormat:=pf24bit;

 ni:=0;
 for i:=0 to objc-1 do inc(ni, obj[i].w);

 bmp.Width:=ni*8; form1.image3.Width:=ni*16;
 bmp.Height:=objh shl 3;

 with bmp.Canvas do begin
  Pen.Color:=0;
  Brush.Color:=Pen.Color;
  Rectangle(0,0,bmp.Width, bmp.Height);
 end;

 ad:=0;

 fillchar(sel_obj_width, sizeof(sel_obj_width), 0);

 ni:=0;
 
for i:=0 to objc-1 do
if (obj[i].w<>0) and (obj[i].h<>0) and (obj[i].f<>'') then begin

 for y:=0 to (obj[i].h shl 3)-1 do begin

  k:=bmp.ScanLine[y];
  ix:=0;

  for x:=0 to obj[i].w-1 do begin
   v:=obj[i].buf[x+y*16];

   for l:=0 to 3 do begin

    c:=(v and $c0) shr 6;

    if v and $c0=$c0 then
     if obj[i].i<>0 then inc(c);

    cl:=aPal[col[c+(y shr 3)*5]];

    k[ad+ix*3]   := GetBValue(cl);
    k[ad+ix*3+1] := GetGValue(cl);
    k[ad+ix*3+2] := GetRValue(cl);

    inc(ix);

    k[ad+ix*3]   := GetBValue(cl);
    k[ad+ix*3+1] := GetGValue(cl);
    k[ad+ix*3+2] := GetRValue(cl);

    inc(ix);

    v:=v shl 2;
   end;

  end;

 end;

 inc(ad, (obj[i].w shl 3)*3);

 for h:=0 to obj[i].w-1 do sel_obj_width[ni+h]:=i;
 inc(ni, obj[i].w);
end;

 form1.Image3.Picture.Bitmap:=bmp;

 bmp.Free;

 with form1.Image3.Canvas do begin
  Pen.Color:=clBtnFace;
  Pen.Style:=psDot; Pen.Mode:=pmMerge; Pen.Width:=1;
  Brush.Style:=bsClear;
  ad:=0;
  for i:=0 to objc-1 do begin
   moveto(ad+obj[i].w shl 3, obj[i].h*8); lineto(ad+obj[i].w shl 3,form1.Image3.Height);
   inc(ad, obj[i].w shl 3);
  end;
 end;

end;


procedure omin_spacje(var i: integer; var a: string);
begin
 if a<>'' then
  while a[i] in [#9,' ',',',':'] do inc(i)
end;


function wartosc(var i: integer; var a: string): integer;
var tmp: string;
begin
 omin_spacje(i,a);

 tmp:='';

 if a<>'' then
  while a[i] in ['0'..'9'] do begin tmp:=tmp+a[i]; inc(i) end;

 omin_spacje(i,a);

 Result:=StrToInt(tmp);
end;


procedure ObjectStatus;
begin
 form1.StatusBar1.Panels[1].Text:='OBJECT: '+IntToStr(ObjSelPos.X);

 if obj[ObjSelPos.X].t<>'' then form1.StatusBar1.Panels[1].Text:=form1.StatusBar1.Panels[1].Text+' ('+AnsiUpperCase(obj[ObjSelPos.X].t)+')';     //+'/'+IntToStr(objc);
end;


procedure LoadINI;
var INI: TINIFile;
    i, k, err, ln: integer;
    cut: string;
    f: file;
    buf: array [0..11520] of byte;
begin

  INI := TINIFile.Create(path+'pang.ini');

  objw   := INI.ReadInteger('objects','w' ,5);
  objh   := INI.ReadInteger('objects','h' ,5);
  border := INI.ReadInteger('objects','b' ,5);

  if objw>16 then objw:=16;
  if objh>16 then objh:=16;

  for i:=0 to 255 do begin
   obj[i].c[0]:=0;
   obj[i].c[1]:=0;

   obj[i].ovr := INI.ReadBool('object'+IntTostr(i),'o' ,false);  // overlay

   obj[i].i := INI.ReadInteger('object'+IntTostr(i),'i' ,0);  // invers znaków
   obj[i].w := INI.ReadInteger('object'+IntTostr(i),'w' ,0);  // width
   obj[i].h := INI.ReadInteger('object'+IntTostr(i),'h' ,0);  // height
   obj[i].v := INI.ReadInteger('object'+IntTostr(i),'v' ,0);  // value
   obj[i].g := INI.ReadInteger('object'+IntTostr(i),'g' ,0);  // group

   obj[i].f := INI.ReadString ('object'+IntTostr(i),'f' ,''); // file

   obj[i].tc:= INI.ReadInteger('object'+IntTostr(i),'tc', -1);

   obj[i].t:=INI.ReadString('object'+IntTostr(i),'t', '');

   cut      := INI.ReadString ('object'+IntTostr(i),'cut' ,'');

   if cut<>'' then begin
    k:=1;
    obj[i].c[0]:=wartosc(k, cut);
    obj[i].c[1]:=wartosc(k, cut);
   end;

  end;

  INI.Free;


 objc:=0;
 for i:=0 to 255 do
  if (obj[i].w>0) and (obj[i].h>0) and (obj[i].f<>'') then begin
   inc(objc);

   assignfile(f, path+obj[i].f); reset(f,1);

   case FileSize(f) of
     7680: ln:=32;
     9600: ln:=40;
    11520: ln:=48;
   else
    ln:=32;
   end;

  // wczytujemy do bufora obiektów ich ksztalt

   fillchar(buf, sizeof(buf), 0);
   blockread(f, buf, sizeof(buf), err);
   closefile(f);

   for k:=0 to 127 do move(buf[k*ln+obj[i].c[0]+(obj[i].c[1] shl 3)*ln], obj[i].buf[k*16], 16);

  end;

// form1.StatusBar1.Panels[0].Text:='OBJECT MAX SIZE: '+IntToStr(objw)+'x'+IntToStr(objh);

 ObjectStatus;

 form1.image3.Width:=((objw shl 3) shl 1)*objc;
 form1.image3.Height:=(objh shl 3) shl 1;

 shw_obj;

 if objc>0 then begin
  form1.ScrollBox1.Enabled:=true;
  form1.lOADlev1.Enabled:=true;
  form1.N1.Enabled:=true;
 end;

end;


procedure LoadTexture(a: string);
var f: file;
begin

  assignfile(f, a); reset(f,1);

  texture:=a;

  blockread(f, tex, (scrHeight shl 3)*scrWidth);
  blockread(f, map, 1024);
  blockread(f, col, scrHeight*5);
  closefile(f);

  shw_tex;

  form1.image1.Enabled:=true;

  form1.SaveTEX1.Enabled:=true;

end;


procedure SetDefaultOverlay;
begin
 form1.OverlayHeight.Text:='14';

 form1.OverlayOrder.Checked[0]:=false;
 form1.OverlayOrder.Checked[1]:=true;
 form1.OverlayOrder.Checked[2]:=true;
 form1.OverlayOrder.Checked[3]:=true;

 form1.OverlayOrder.ItemEnabled[0]:=false;
end;


function GetSpecialFolderPath(const Folder: Integer): string;
var
  Path: array[0..MAX_PATH] of Char;
begin
  SHGetSpecialFolderPath(0, Path, Folder , False);
  Result := Path;
end;


procedure TForm1.FormCreate(Sender: TObject);
var i: integer;
    Buffer: array[0..MAX_PATH-1] of Char;
begin
 doublebuffered:=true;
 path:=ExtractFilePath(Application.ExeName);

 SetString(temp, Buffer, GetTempPath(SizeOf(Buffer), Buffer));

 SetLength(objList, 1);

// lOADlev1.Enabled:=false;
// N1.Enabled:=false;
 SaveTEX1.Enabled:=false;

 for i:=0 to 14-1 do OverlayColors[0, i]:=28;
 for i:=0 to 14-1 do OverlayColors[1, i]:=188;
 for i:=0 to 14-1 do OverlayColors[2, i]:=248;

{
 for i:=0 to scrHeight-1 do begin
  col[i*5]:=$38;
  col[i*5+1]:=$0a;
  col[i*5+2]:=$00;
  col[i*5+3]:=$9a;
  col[i*5+4]:=$44;
 end; }

 form1.Caption:=title;

 OpenDialog1.InitialDir:=path;


 LoadTexture(path+'default.tex');

 shw_pal;

 LoadINI;

 shw_tex;

 SetDefaultOverlay;
end;


procedure TForm1.FormKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin

 if SelectMode.ItemIndex=1 then begin              // EDIT

  if key=vk_delete then Delete1Click(self);
  if key=vk_insert then begin pmov:=img1Mov; Insert1Click(self); end;
  
 end;
 
end;


procedure TForm1.LoadTEX1Click(Sender: TObject);
begin
 OpenDialog1.FilterIndex:=2;

 if OpenDialog1.Execute then LoadTexture(OpenDialog1.FileName);

end;


procedure TForm1.Image3MouseLeave(Sender: TObject);
begin
 ObjSelPos.X:=objActive;
 ObjectStatus;
end;


procedure TForm1.Image3MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 ObjSelPos:=Point(sel_obj_width[x div 16], y);

 ObjectStatus;
end;


procedure object_rewrite(i: integer);
var y, ix, x: integer;
    bmp: TBitmap;
    k: PByteArray;
    v, l, c: byte;
    cl: TColor;
begin

 form1.image4.Visible:=true;
 form1.image4.Width:=obj[i].w shl 4;
 form1.image4.Height:=obj[i].h shl 4;

 bmp:=Tbitmap.Create;
 bmp.Width:=obj[i].w shl 3;
 bmp.Height:=obj[i].h shl 3;
 bmp.PixelFormat:=pf24bit;


 for y:=0 to (obj[i].h shl 3)-1 do begin

  k:=bmp.ScanLine[y];
  ix:=0;

  for x:=0 to obj[i].w-1 do begin
   v:=obj[i].buf[x+y*16];

   for l:=0 to 3 do begin

    c:=(v and $c0) shr 6;

    if v and $c0=$c0 then
     if obj[i].i<>0 then inc(c);

    cl:=aPal[col[c+(y shr 3+pmov.y)*5]];

    k[ix*3]   := GetBValue(cl);
    k[ix*3+1] := GetGValue(cl);
    k[ix*3+2] := GetRValue(cl);

    inc(ix);

    k[ix*3]   := GetBValue(cl);
    k[ix*3+1] := GetGValue(cl);
    k[ix*3+2] := GetRValue(cl);

    inc(ix);

    v:=v shl 2;
   end;

  end;

 end;

 form1.Image4.Picture.Bitmap:=bmp;

 with form1.image4.Canvas do begin
  Pen.Color:=clRed;
  Pen.Style:=psDot; Pen.Mode:=pmMerge; Pen.Width:=1;
  Brush.Style:=bsClear;

  Rectangle(0,0,obj[i].w shl 3,obj[i].h shl 3);
 end;

 bmp.Free;

end;


procedure zaznacz_obiekt(i: integer);
var j: integer;
begin

 if i>=0 then
  for j:=0 to objc*objw-1 do
   if sel_obj_width[j]=i then

  with form1.image3.canvas do begin
   Pen.Color:=clRed;
   Brush.Color:=Pen.Color;
   Pen.Mode := pmNotXor;
   Brush.Style:=bsSolid;
   Rectangle( (j shl 3), 0, (j shl 3)+obj[i].w shl 3, objh shl 3 );
   exit;
  end;

end;


procedure TForm1.Image3Click(Sender: TObject);
var i: integer;
begin

 SelectMode.ItemIndex:=0;
 image1.Enabled:=true;

 zaznacz_obiekt(objActive);

 i:=ObjSelPos.X;

 objActive:=i;

 label1.caption:='OBJECT: '+IntToStr(i)+', SIZE: '+IntToStr(obj[i].w)+'x'+IntToStr(obj[i].h);

 pmov:=Point(0,0);

 object_rewrite(i);

 image4.Left:=image1.Left;
 image4.Top:=image1.Top;

 zaznacz_obiekt(i);

end;


procedure pozycja_myszki;
begin

 if form1.SelectMode.ItemIndex=0 then
  form1.StatusBar1.Panels[0].Text:=IntToStr(img1Mov.x)+':'+IntToStr(img1Mov.y)+' / '+IntToStr(pmov.x)+':'+IntToStr(pmov.y)
 else
  form1.StatusBar1.Panels[0].Text:=IntToStr(img1Mov.x)+':'+IntToStr(img1Mov.y);

end;


procedure DrawMarquee( mStart, mStop : TPoint; AMode : TPenMode);
begin
 form1.Image1.Canvas.Pen.Mode := AMode;
 form1.Image1.Canvas.Rectangle( mStart.X, mStart.Y, mStop.X, mStop.Y );
end;


procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 img1Mov:=Point(x shr 4, y shr 4);

 pozycja_myszki;

// if RadioGroup1.ItemIndex=2 then
 	if bMarquee = True then  begin
	   DrawMarquee(ptOrigin, ptMove, pmNotXor );
	   DrawMarquee(ptOrigin, Point( X shr 1, Y shr 1 ), pmNotXor );
	   ptMove := Point( X shr 1, Y shr 1 );
	   Canvas.Pen.Mode := pmCopy;
	end;

end;



procedure searchOBJinit;
var i, x, y: integer;
begin

 for i:=0 to length(tmpObj)-1 do tmpObj[i]:=-1;

 for i:=0 to High(objList)-1 do       // wypelniamy TMP obiektami
  if not(objList[i].d) then
   for y:=0 to obj[objList[i].o].h-1 do
    for x:=0 to obj[objList[i].o].w-1 do
     tmpObj[x+objList[i].x + (objList[i].y+y)*48]:=objList[i].o + i shl 8;

end;



function searchOBJ(p: TPoint): integer;
var i: integer;
begin

 Result:=tmpObj[p.X+p.Y*48];

 if Result<>-1 then
  for i:=0 to (ScrWidth*ScrHeight)-1 do
   if tmpObj[i]=Result then tmpObj[i]:=$FF;

end;


procedure TForm1.Image1Click(Sender: TObject);
var x, y: integer;
begin

 LabeledEdit1.Visible:=false;
 LabeledEdit2.Visible:=false;

 if SelectMode.ItemIndex=0 then begin  // INSERT mode

      pmov:=img1Mov;

      x := pmov.x;
      y := pmov.y;

      if (x+obj[objActive].w)>scrWidth then x:=scrWidth-obj[objActive].w;
      if (y+obj[objActive].h)>19 then y:=19-obj[objActive].h;

      pmov:=Point(x,y);

      image4.Left:=x shl 4+image1.Left;
      image4.Top:=y shl 4+image1.Top;

      object_rewrite(objActive);
      
 end;

end;


procedure TForm1.Grid1Click(Sender: TObject);
begin
 Grid1.Checked:=not(Grid1.Checked);

 shw_tex;
end;


procedure TForm1.Image4MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var lowerLeft: TPoint;
begin
 lowerLeft := Point(image4.left, image4.Top);
 lowerLeft := ClientToScreen(lowerLeft);
// PopupMenu1.Popup(lowerLeft.X, lowerLeft.Y);

 if Button=mbRight then PopupMenu1.Popup(lowerLeft.X, lowerLeft.Y);

//  PopupMenu1.Popup(form1.Left+image4.left, form1.Top+image4.Top+obj[objActive].h shl 4);
end;


function freeOBJ(x,y: integer): Boolean;
var i: integer;
begin
 Result:=true;

 for i:=High(objlist)-1 downto 0 do
  if (objlist[i].x=x) and (objlist[i].y=y) then begin Result:=false; Break end;

end;


procedure TForm1.Insert1Click(Sender: TObject);
var i, j: integer;
begin
// wstawienie obiektu  - PASTE -

 ZapiszUNDO;

 if (SelectMode.ItemIndex=1) and (copyObj) then begin

  for j:=0 to High(objCOPY)-1 do
   if (objCOPY[j].x+pmov.x<scrWidth) and (objCOPY[j].y+pmov.y<scrHeight) then begin

    i:=High(objList);

    if i<256 then
    if freeOBJ(objCOPY[j].x+pmov.x, objCOPY[j].y+pmov.y) then begin
     objList[i]:=objCOPY[j];

     objList[i].x := objList[i].x+pmov.x;
     objList[i].y := objList[i].y+pmov.y;

     SetLength(objList, i+2);
    end;

   end;

 end else begin

  i:=High(objList);

  if i<256 then
  if freeOBJ(pmov.x, pmov.y) or obj[objActive].ovr then begin
   objList[i].x := pmov.x;
   objList[i].y := pmov.y;
   objList[i].o := objActive;
   objList[i].p := 0;

   objList[i].g := obj[objActive].g;

   objList[i].d:=false;

   SetLength(objList, i+2);
  end;

 end;

 shw_tex;

end;


procedure czytaj_ply(var f: file; ply:byte);
var x,y, i: integer;
    v: byte;
begin

 x:=0;

 case ply of
  1: x:=StrToInt(form1.LabeledEdit6.Text);
  2: x:=StrToInt(form1.LabeledEdit8.Text);
  3: x:=StrToInt(form1.LabeledEdit9.Text);
 else
  halt;
 end;

 
 for y:=0 to StrToInt(form1.OverlayHeight.Text)-1 do begin
  blockread(f, v, 1);

  for i:=0 to 7 do begin
   if v and $80<>0 then begin

    ovr[x+i*4,y].pmg:=ply;
    ovr[x+i*4+1,y].pmg:=ply;
    ovr[x+i*4+2,y].pmg:=ply;
    ovr[x+i*4+3,y].pmg:=ply;

    ovr[x+i*4,y].use:=true;
    ovr[x+i*4+1,y].use:=true;
    ovr[x+i*4+2,y].use:=true;
    ovr[x+i*4+3,y].use:=true;
   end;

   v:=v shl 1;
  end;

 end;

end;


procedure czytaj_mis(var f: file);
var x0,x1,x2, i, j: integer;
    _ora0, _ora1, _ora2, v: byte;
    _ora: array [0..2] of byte;
const
    _o: array [0..3] of byte = ($80,$20,$8,$2);
begin

 x0:=StrToInt(form1.LabeledEdit7.Text);
 x1:=StrToInt(form1.LabeledEdit10.Text);
 x2:=StrToInt(form1.LabeledEdit11.Text);

 i:=0;
 for j:=3 downto 0 do
  if form1.OverlayOrder.Checked[j] then begin
   _ora[i]:=_o[j];
   inc(i);
  end;    


 for j:=0 to StrToInt(form1.OverlayHeight.Text)-1 do begin
  blockread(f, v, 1);

  _ora0:=_ora[0];
  _ora1:=_ora[1];
  _ora2:=_ora[2];

  for i:=0 to 1 do begin
   if v and _ora0<>0 then begin
    ovr[x0+i*4+0,j].use:=true;
    ovr[x0+i*4+1,j].use:=true;
    ovr[x0+i*4+2,j].use:=true;
    ovr[x0+i*4+3,j].use:=true;
   end;

   if v and _ora1<>0 then begin
    ovr[x1+i*4+0,j].use:=true;
    ovr[x1+i*4+1,j].use:=true;
    ovr[x1+i*4+2,j].use:=true;
    ovr[x1+i*4+3,j].use:=true;
   end;

   if v and _ora2<>0 then begin
    ovr[x2+i*4+0,j].use:=true;
    ovr[x2+i*4+1,j].use:=true;
    ovr[x2+i*4+2,j].use:=true;
    ovr[x2+i*4+3,j].use:=true;
   end;

   _ora0:=_ora0 shr 1;
   _ora1:=_ora1 shr 1;
   _ora2:=_ora2 shr 1;
  end;

 end;

end;


procedure TForm1.lOADlev1Click(Sender: TObject);
// LOAD *.LEV
var f: file;
    i,j: integer;
    grp, obj: byte;
    t: array [0..7] of byte;
begin


 for j:=0 to 19 do
  for i:=0 to 159 do ovr[i,j].use:=false;


 OpenDialog1.FilterIndex:=4;

 if OpenDialog1.Execute then begin
  SetLength(objList, 1);

  assignfile(f, Opendialog1.FileName); reset(f,1);

  while true do begin

   blockread(f, t, 1);
   grp:=t[0];

   if grp=$ff then break;

   if grp=0 then begin

      while true do begin
       blockread(f, t, 1);
       if t[0]=$80 then Break;

       blockread(f, t[1], 3);

       i:=High(objList);

       objList[i].o:=t[0];

       objList[i].x:=t[1];
       objList[i].y:=t[2];
       objList[i].p:=t[3];

       objList[i].g:=grp;
       objList[i].d:=false;

       SetLength(objList, i+2);
      end;

   end else begin

     blockread(f, t, 1);

     obj:=t[0];
     while true do begin

       blockread(f, t, 1);
       if t[0]=$80 then Break;

       blockread(f, t[1], 1);

       i:=High(objList);

       objList[i].o:=obj;

       objList[i].x:=t[0];
       objList[i].y:=t[1];
       objList[i].p:=0;

       objList[i].g:=grp;
       objList[i].d:=false;

       SetLength(objList, i+2);
     end;

   end;

  end;


  fillchar(t, sizeof(t), 0);

  if FilePos(f)<FileSize(f) then blockread(f, t, 3);

  CheckBox7.Checked:=t[0] and $80=0;
  CheckBox8.Checked:=t[0] and $40=0;
  CheckBox9.Checked:=t[0] and $20=0;
  CheckBox10.Checked:=t[0] and $10=0;
  CheckBox11.Checked:=t[0] and $8=0;
  CheckBox12.Checked:=t[0] and $4=0;

  if t[1]=0 then
   LabeledEdit4.Text:='18'
  else
   LabeledEdit4.Text:=IntToStr(t[1]);

  if t[2]=0 then
   LabeledEdit5.Text:='15'
  else
   LabeledEdit5.Text:=IntToStr(t[2]);


  if FilePos(f)<FileSize(f) then blockread(f, t[3], 1);

  if t[3]=0 then begin
   Minutes.Position:=2;
   Seconds.Position:=0;
  end else begin
   Minutes.Position:=t[3] and 3;
   Seconds.Position:=t[3] shr 2;
  end;

// odczyt danych PMG OVERLAY
  if FilePos(f)<FileSize(f) then begin

   blockread(f, t, 1);

   SetDefaultOverlay;

   PMGEnabled.Checked:=t[0]<>0;

   if t[0]<>0 then begin

    OverlayHeight.Text:=IntToStr(t[0] and $f);

    OverlayOrder.Checked[0]:=(t[0] and $80 <>0);
    OverlayOrder.Checked[1]:=(t[0] and $40 <>0);
    OverlayOrder.Checked[2]:=(t[0] and $20 <>0);
    OverlayOrder.Checked[3]:=(t[0] and $10 <>0);

    blockread(f, t, 3);
    for i:=0 to 14-1 do OverlayColors[0, i]:=t[0];

    for i:=0 to 14-1 do OverlayColors[1, i]:=t[1];

    for i:=0 to 14-1 do OverlayColors[2, i]:=t[2];


    blockread(f, t, 3);
    LabeledEdit6.Text:=IntToStr(t[0]-48);
    LabeledEdit8.Text:=IntToStr(t[1]-48);
    LabeledEdit9.Text:=IntToStr(t[2]-48);

    blockread(f, t, 3);
    LabeledEdit7.Text:=IntToStr(t[0]-48);
    LabeledEdit10.Text:=IntToStr(t[1]-48);
    LabeledEdit11.Text:=IntToStr(t[2]-48);

    czytaj_ply(f, 1);
    czytaj_ply(f, 2);
    czytaj_ply(f, 3);

    czytaj_mis(f);

    t[0]:=0;
    blockread(f, t, 1);

    if t[0]=$ff then begin

     for i:=0 to StrToInt(form1.OverlayHeight.Text)-1 do
      blockread(f, OverlayColors[0, i], 1);

     for i:=0 to StrToInt(form1.OverlayHeight.Text)-1 do
      blockread(f, OverlayColors[1, i], 1);

     for i:=0 to StrToInt(form1.OverlayHeight.Text)-1 do
      blockread(f, OverlayColors[2, i], 1);

    end;

   end;

  end;

  closefile(f);

  form1.Caption:=title+' ('+Opendialog1.FileName+')';

  shw_tex;

  SaveDialog1.InitialDir:=ExtractFilePath(OpenDialog1.FileName);
  SaveDialog1.FileName:=ExtractFileName(OpenDialog1.FileName);

  OpenDialog1.InitialDir:=SaveDialog1.InitialDir;
 end;

 image1.Enabled:=true;
end;


procedure TForm1.NewLEVEL1Click(Sender: TObject);
begin
 ZapiszUNDO;

 SetLength(objList, 1);

 Image1.Enabled:=true;

 shw_tex;
end;


procedure TForm1.OverlayOrderClick(Sender: TObject);
begin
 LabeledEdit6.Enabled:=OverlayOrder.Checked[3];
 LabeledEdit7.Enabled:=OverlayOrder.Checked[3];

 LabeledEdit8.Enabled:=OverlayOrder.Checked[2];
 LabeledEdit10.Enabled:=OverlayOrder.Checked[2];

 LabeledEdit9.Enabled:=OverlayOrder.Checked[1];
 LabeledEdit11.Enabled:=OverlayOrder.Checked[1];

 SelectModeClick(self);
end;


procedure pm(s,x: integer; c: integer; i:TShape; pmg: byte);
var j, k, h: integer;
begin

 h:=StrToInt(form1.OverlayHeight.Text);


 if form1.SelectMode.ItemIndex=2 then

 for k:=0 to 18 do                            // usuwamy PMG
  for j:=0 to 159 do
   if ovr[j,k].pmg=pmg then ovr[j,k].pmg:=0;

 for k:=0 to 18 do                            // ustawiamy PMG
  for j:=0 to s-1 do ovr[x+j,k].pmg:=pmg;


 with form1 do begin

 i.Visible:=true;

 i.Width:=s*4; i.Height:=h*16;

 i.Brush.Color:=aPal[c];
// i.Pen.Color:=aPal[c];

 i.Left:=x*4+image1.Left;
 i.Top:=image1.Top;

 end;

end;


procedure TForm1.SelectModeClick(Sender: TObject);
begin

 editObj:=false;
 copyObj:=false;

 shw_tex;

 Shape1.Visible:=false;
 Shape2.Visible:=false;
 Shape3.Visible:=false;
 Shape4.Visible:=false;
 Shape5.Visible:=false;
 Shape6.Visible:=false;

 case SelectMode.ItemIndex of
  0: begin image4.Visible:=true; Image3Click(form1) end;
  1: image4.Visible:=false;
  2: begin

      if OverlayOrder.Checked[3] then pm(32,StrToInt(LabeledEdit6.Text), OverlayColors[0,0], Shape1, 1);
      if OverlayOrder.Checked[2] then pm(32,StrToInt(LabeledEdit8.Text), OverlayColors[1,0], Shape2, 2);
      if OverlayOrder.Checked[1] then pm(32,StrToInt(LabeledEdit9.Text), OverlayColors[2,0], Shape3, 3);

      if OverlayOrder.Checked[3] then pm(8,StrToInt(LabeledEdit7.Text), OverlayColors[0,0], Shape4, $81);
      if OverlayOrder.Checked[2] then pm(8,StrToInt(LabeledEdit10.Text), OverlayColors[1,0], Shape5, $82);
      if OverlayOrder.Checked[1] then pm(8,StrToInt(LabeledEdit11.Text), OverlayColors[2,0], Shape6, $83);

      shw_tex;
     end;
 end;

 image6.Visible:=false;

end;


procedure TForm1.Image1MouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var lowerLeft: TPoint;
begin
 lowerLeft := Point(x+image1.left, y+image1.Top);
 lowerLeft := ClientToScreen(lowerLeft);

 LabeledEdit1.Visible:=false;
 LabeledEdit2.Visible:=false;

 if SelectMode.ItemIndex=1 then begin

    if Button=mbRight then
     if editObj then begin
      //PopupMenu2.Popup(x+form1.Left+image1.Left-20, y+form1.Top+image1.Top+48);
      PopupMenu2.Popup(lowerLeft.X, lowerLeft.Y);
      exit;
     end else
      if copyObj then begin

       pmov:=img1Mov;
       //PopupMenu1.Popup(x+form1.Left+image1.Left-20, y+form1.Top+image1.Top+48);
       PopupMenu1.Popup(lowerLeft.X, lowerLeft.Y);
       exit;
      end;

    shw_tex;

   	bMarquee :=  True;
   	{ punkt startowy }
    ptOrigin := Point( X shr 1, Y shr 1 );
    { punkt koñcowy na pocz¹tku równy startowemu }
   	ptMove  := Point( X shr 1, Y shr 1);

   	Canvas.Pen.Color := clBlack;
   	Canvas.Pen.Width := 1;
   	Canvas.Pen.Style := psDash;
   	Canvas.Brush.Style := bsClear;
   	{Rysowanie prostok¹ta}
   	DrawMarquee(ptOrigin, ptMove, pmNotXor );
 end;

end;


procedure objListRewrite;
var i, k: integer;
begin

 objTemp:=objList;
 SetLength(objTemp, length(objList));

 SetLength(objList,1);

 for i:=0 to High(objTemp)-1 do
  if not(objTemp[i].d) then begin
   k:=High(objList);
   objList[k]:=objTemp[i];

   SetLength(objList, k+2);
  end;

 SetLength(objTemp, 0);

end;


procedure TForm1.Er1Click(Sender: TObject);
var i, k, w: integer;
    a: byte;
begin
// BRING TO FRONT

 ZapiszUNDO;

 searchOBJinit;

     for w:=ptOrigin.y to ptMove.y do
      for k:=ptOrigin.x to ptMove.x do begin

       i:=searchOBJ(Point(k,w));

       if i and $FF<>$FF then begin        // znaleziono obiekt
         a:=byte(i shr 8);

         i:=High(objList);
         objList[i]:=objList[a];
         objList[a].d:=true;
         SetLength(objList, i+2);
         objListRewrite;
       end;

      end;

 shw_tex;

 editObj:=false;
end;


procedure TForm1.SendtoBack1Click(Sender: TObject);
var i, j, k, w: integer;
    a: byte;
begin
// SEND TO BACK

 ZapiszUNDO;

 searchOBJinit;

     for w:=ptOrigin.y to ptMove.y do
      for k:=ptOrigin.x to ptMove.x do begin

       i:=searchOBJ(Point(k,w));

       if i and $FF<>$FF then begin        // znaleziono obiekt
         a:=byte(i shr 8);

         objTemp:=objList;
         SetLength(objTemp, length(objList));

         SetLength(objList,2);

         objList[0]:=objTemp[a];

         objTemp[a].d:=true;

         for i:=0 to High(objTemp)-1 do
          if not(objTemp[i].d) then begin
           j:=High(objList);

           objList[j]:=objTemp[i];

           SetLength(objList, j+2);
          end;

       end;

      end;

 shw_tex;

 editObj:=false;
end;


procedure TForm1.Image4DblClick(Sender: TObject);
begin
 Insert1Click(form1);
end;


procedure TForm1.Image4MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 pozycja_myszki;
end;


procedure TForm1.Image5Click(Sender: TObject);
begin

 if palMov.Y<StrToInt(OverlayHeight.Text) then begin

  set_pm:=$10;
  select.x:=(OverlayColors[palMov.x,palMov.y] and $0f) div 2;
  select.y:=OverlayColors[palMov.x,palMov.y] shr 4;

  ovrxy:=palMov;

  form2.visible:=true;
  form2.Caption:='Select Overlay Color '+IntToStr(palMov.x);
  form2.FormShow(form1);

  ShowOverlayColors;

  with Image5.Canvas do begin
   Pen.Color:=0;
   MoveTo(palMov.x*16, palMov.y*16);
   LineTo(palMov.x*16+15, palMov.y*16+15);

   MoveTo(palMov.x*16+15, palMov.y*16);
   LineTo(palMov.x*16, palMov.y*16+15);
  end;

 end;
 
end;


procedure TForm1.Parameter1Click(Sender: TObject);
var w, k, i: integer;
    a, par: byte;
begin
 LabeledEdit1.Visible:=false;
 LabeledEdit1.Visible:=true;

 ZapiszUNDO;

 searchOBJinit;

     par:=0;

     for w:=ptOrigin.y to ptMove.y do
      for k:=ptOrigin.x to ptMove.x do begin

       i:=searchOBJ(Point(k,w));

       if i and $FF<>$FF then begin         // znaleziono obiekt
         a:=byte(i shr 8);

         par:=objlist[a].p;
         Break;
       end;

      end;

 LabeledEdit1.Text:=IntToStr(par);

 LabeledEdit1.SetFocus;

 LabeledEdit1.Left:=img1Mov.x shl 4+image1.Left-20;
 LabeledEdit1.Top:=img1Mov.y shl 4+image1.Top+12;
end;


procedure TForm1.LabeledEdit1KeyPress(Sender: TObject; var Key: Char);
var w, k, i: integer;
    a, par: byte;
begin

 if Key=#27 then LabeledEdit1.Visible:=false;

 if Key=#13 then begin

     par:=StrToInt(LabeledEdit1.Text);

     searchOBJinit;

     for w:=ptOrigin.y to ptMove.y do
      for k:=ptOrigin.x to ptMove.x do begin

       i:=searchOBJ(Point(k,w));

       if i and $FF<>$FF then begin        // znaleziono obiekt
         a:=byte(i shr 8);
         objList[a].p:=par;
        end;

      end;

  LabeledEdit1.Visible:=false;
 end;

end;


procedure TForm1.Group1Click(Sender: TObject);
var k, w, i: integer;
    a, id: byte;
begin
 LabeledEdit2.Visible:=false;
 LabeledEdit2.Visible:=true;

 ZapiszUNDO;

 searchOBJinit;

     id:=0;

     for w:=ptOrigin.y to ptMove.y do
      for k:=ptOrigin.x to ptMove.x do begin

       i:=searchOBJ(Point(k,w));

       if i and $FF<>$FF then begin       // znaleziono obiekt
         a:=byte(i shr 8);
         id:=objlist[a].g;
         Break;
        end;

      end;

 LabeledEdit2.Text:=IntToStr(id);

 LabeledEdit2.SetFocus;

 LabeledEdit2.Left:=img1Mov.x shl 4+image1.Left-20;
 LabeledEdit2.Top:=img1Mov.y shl 4+image1.Top+12;
end;


procedure TForm1.LabeledEdit2KeyPress(Sender: TObject; var Key: Char);
var w, k, i: integer;
    a, id: byte;
begin

 if Key=#27 then LabeledEdit2.Visible:=false;

 if Key=#13 then begin

     searchOBJinit;

     id:=StrToInt(LabeledEdit2.Text);

     for w:=ptOrigin.y to ptMove.y do
      for k:=ptOrigin.x to ptMove.x do begin

       i:=searchOBJ(Point(k,w));

       if i and $FF<>$FF then begin         // znaleziono obiekt
         a:=byte(i shr 8);
         objList[a].g:=id;
       end;

      end;

  LabeledEdit2.Visible:=false;
 end;

end;


procedure TForm1.Image1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var i, k, w: integer;
    a: byte;
    first: Boolean;
begin

  if bMarquee = True then  begin
	   bMarquee := False;
	   DrawMarquee(ptOrigin, Point( X shr 1, Y shr 1 ), pmNotXor );
	   ptMove := Point( X shr 1, Y shr 1 );

     editObj:=false;

     if ptMove.x<ptOrigin.x then begin
      i:=ptOrigin.x;
      ptOrigin.x:=ptMove.x;
      ptMove.x:=i;
     end;

     if ptMove.y<ptOrigin.Y then begin
      i:=ptOrigin.y;
      ptOrigin.y:=ptMove.y;
      ptMove.y:=i;
     end;

     ptOrigin.x:=ptOrigin.x shr 3;
     ptOrigin.y:=ptOrigin.y shr 3;
     ptMove.x:=ptMove.x shr 3;
     ptMove.y:=ptMove.y shr 3;

     if ptOrigin.x>47 then ptOrigin.x:=47;
     if ptOrigin.y>18 then ptOrigin.y:=18;

     if ptMove.x>47 then ptMove.x:=47;
     if ptMove.y>18 then ptMove.y:=18;

     first:=false;

     searchOBJinit;

     for w:=ptOrigin.y to ptMove.y do
      for k:=ptOrigin.x to ptMove.x do begin

       i:=searchOBJ(Point(k,w));

       if i and $FF<>$FF then         // znaleziono obiekt
        with image1.Canvas do begin
         Pen.Color:=clYellow;
         Pen.Style:=psDot; Pen.Mode:=pmMerge; Pen.Width:=1;
         Brush.Style:=bsClear;

         a:=byte(i shr 8);
         x:=objList[a].x shl 3;
         y:=objList[a].y shl 3;

         i:=i and $ff;

         Rectangle(x,y,x+obj[i].w shl 3, y+obj[i].h shl 3);

         editObj:=true;

         if not(first) then begin
          label1.Caption:='OBJECT: '+IntToStr(i)+', GROUP: '+IntToStr(objList[a].g)+', PARAM: '+IntToStr(objList[a].p);
          first:=true;
         end;
         
        end;

      end;

	end;

end;


procedure TForm1.Undo1Click(Sender: TObject);
// UNDO
begin

 if undo_index=undo_index_max then begin
  ZapiszUndo;
  dec(undo_index); dec(undo_index_max);
 end;

 CzytajUndo;

{ objREDO:=objList;
 SetLength(objREDO, length(objList));

 ovrREDO:=ovr;

 objList:=objUNDO;
 SetLength(objList, length(objUNDO));

 ovr:=ovrUNDO;

 Undo1.Enabled:=false;
 Redo1.Enabled:=true; }

 shw_tex;   
end;


procedure TForm1.Redo1Click(Sender: TObject);
// REDO
begin

 inc(undo_index, 2);

 CzytajUndo;

 Undo1.Enabled:=true;

{
 objUNDO:=objList;
 SetLength(objUNDO, length(objList));

 ovrUNDO:=ovr;

 objList:=objREDO;
 SetLength(objList, length(objREDO));

 ovr:=ovrREDO;

 Undo1.Enabled:=true;
 Redo1.Enabled:=false;  }

 shw_tex;
end;


procedure TForm1.Delete1Click(Sender: TObject);
var k, w, i: integer;
    a: byte;
begin

 ClrPMGOverlay1Click(self);

 ZapiszUNDO;

 searchOBJinit;

     for w:=ptOrigin.y to ptMove.y do
      for k:=ptOrigin.x to ptMove.x do begin

       i:=searchOBJ(Point(k,w));

       if i and $FF<>$FF then begin         // znaleziono obiekt
        a:=byte(i shr 8);
        objList[a].d:=true;
       end;

      end;

 shw_tex;

 objListRewrite;

 editObj:=false;
end;


procedure TForm1.Copy1Click(Sender: TObject);
// COPY
var k, w, i, j: integer;
    a, mx, my: byte;
begin

 SetLength(objCOPY, 1);

 mx:=255;
 my:=255;

 searchOBJinit;

     for w:=ptOrigin.y to ptMove.y do
      for k:=ptOrigin.x to ptMove.x do begin

       i:=searchOBJ(Point(k,w));

       if i and $FF<>$FF then begin         // znaleziono obiekt
        a:=byte(i shr 8);

        j:=High(objCOPY);

        objCOPY[j]:=objList[a];

        if objList[a].x<mx then mx:=objList[a].x;
        if objList[a].y<my then my:=objList[a].y;

        SetLength(objCOPY, j+2);

        copyObj:=true;
       end;

      end;

 for i:=0 to High(objCOPY)-1 do begin   // poprawiamy pozycje X:Y
  objCOPY[i].x:=objCOPY[i].x-mx;
  objCOPY[i].y:=objCOPY[i].y-my;
 end;

end;


procedure TForm1.SaveTEX1Click(Sender: TObject);
var f: file;
    v: byte;
begin
 SaveDialog1.FilterIndex:=3;

 if SaveDialog1.Execute then begin

  assignfile(f, SaveDialog1.FileName); rewrite(f,1);

  v:=scrWidth;
  blockwrite(f, v, 1);

  v:=scrHeight;
  blockwrite(f, v, 1);

  blockwrite(f, tex, (scrHeight shl 3)*scrWidth);
  blockwrite(f, map, 1024);
  blockwrite(f, col, scrHeight*5);
  closefile(f);
 end;

end;


procedure zapisz_ply(var f: file; ply:byte);
var x, i, j: integer;
    v, _ora: byte;
begin

 x:=0;

 case ply of
  1: x:=StrToInt(form1.LabeledEdit6.Text);
  2: x:=StrToInt(form1.LabeledEdit8.Text);
  3: x:=StrToInt(form1.LabeledEdit9.Text);
 else
  halt;
 end;

 for j:=0 to StrToInt(form1.OverlayHeight.Text)-1 do begin

  v:=0;

  _ora:=$80;

  for i:=0 to 7 do begin
   if ovr[x+i*4,j].use then v:=v or _ora;

   _ora:=_ora shr 1;
  end;

  blockwrite(f, v, 1);
 end;

end;



procedure zapisz_mis(var f: file);
var x0,x1,x2, i, j: integer;
    _ora0, _ora1, _ora2, v: byte;
    _ora: array [0..2] of byte;
const
    _o: array [0..3] of byte = ($80,$20,$8,$2);
begin

 x0:=StrToInt(form1.LabeledEdit7.Text);
 x1:=StrToInt(form1.LabeledEdit10.Text);
 x2:=StrToInt(form1.LabeledEdit11.Text);

 i:=0;
 for j:=3 downto 0 do
  if form1.OverlayOrder.Checked[j] then begin
   _ora[i]:=_o[j];
   inc(i);
  end;    


 for j:=0 to StrToInt(form1.OverlayHeight.Text)-1 do begin
  v:=0;

  _ora0:=_ora[0];
  _ora1:=_ora[1];
  _ora2:=_ora[2];

  for i:=0 to 1 do begin
   if ovr[x0+i*4,j].use then v:=v or _ora0;
   if ovr[x1+i*4,j].use then v:=v or _ora1;
   if ovr[x2+i*4,j].use then v:=v or _ora2;

   _ora0:=_ora0 shr 1;
   _ora1:=_ora1 shr 1;
   _ora2:=_ora2 shr 1;
  end;

  blockwrite(f, v, 1);
 end;

end;



procedure TForm1.N1Click(Sender: TObject);
// SAVE
var f: file;
    i, j, len, err: integer;
    v: byte;
    t: array [0..4] of byte;
    sg, grp0, test: Boolean;
    bf: array [0..256*1024] of byte;
    nam, nam2: string;
begin

 if max_balls>32 then begin
  Application.MessageBox('Liczba kul przekracza limit 32 sztuk.','Save *.LEV',MB_ICONEXCLAMATION);

  exit;
 end;


 SaveDialog1.FilterIndex:=2;

 grp0:=false;

 if SaveDialog1.Execute then begin

  nam:=SaveDialog1.FileName;

  assignfile(f, nam); rewrite(f,1);

{  for i:=0 to High(objList)-1 do
   if not(objList[i].d) then begin

    t[0]:=objList[i].o;
    t[1]:=objList[i].x;
    t[2]:=objList[i].y;
    t[3]:=objList[i].p;
    t[4]:=objList[i].g;

    blockwrite(f, t, 5);
   end;      }


// grupy 0..254
// obiekty 0..127
// obiekty bez OVERLAY

   for j:=0 to 127 do
   for v:=0 to 254 do begin

    sg:=false;

    for i:=0 to High(objList)-1 do
     if not(obj[objList[i].o].ovr) and not(objList[i].d) and (objList[i].g=v) and (objList[i].o=j) then begin

      if v=0 then grp0:=true;

      if not(sg) then begin
       t[0]:=v;             // zapisujemy grupe
       blockwrite(f, t, 1);

       if v>0 then begin
        t[0]:=objList[i].o;
        blockwrite(f, t, 1);
       end;

       sg:=true;
      end;

      if v=0 then begin
       t[0]:=objList[i].o;
       blockwrite(f, t, 1);
      end;

      t[0]:=objList[i].x;
      t[1]:=objList[i].y; 

      if v=0 then begin
       t[2]:=objList[i].p;
       blockwrite(f, t, 3);
      end else
       blockwrite(f, t, 2);

     end;


     if sg then begin
      t[0]:=$80;            // posX=$80, czyli konczymy zapis obiektow z grupy
      blockwrite(f, t, 1);
     end;

   end;


// obiekty z OVERLAY, pomijamy V=0 (KULE)

   for j:=0 to 127 do
   for v:=1 to 254 do begin

    sg:=false;

    for i:=0 to High(objList)-1 do
     if obj[objList[i].o].ovr and not(objList[i].d) and (objList[i].g=v) and (objList[i].o=j) then begin

//      if v=0 then grp0:=true;

      if not(sg) then begin
       t[0]:=v;             // zapisujemy grupe
       blockwrite(f, t, 1);

       if v>0 then begin
        t[0]:=objList[i].o;
        blockwrite(f, t, 1);
       end;

       sg:=true;
      end;

//      if v=0 then begin
//       t[0]:=objList[i].o;
//       blockwrite(f, t, 1);
//      end;

      t[0]:=objList[i].x;
      t[1]:=objList[i].y;

//      if v=0 then begin
//       t[2]:=objList[i].p;
//       blockwrite(f, t, 3);
//      end else
       blockwrite(f, t, 2);

     end;

     if sg then begin
      t[0]:=$80;            // posX=$80, czyli konczymy zapis obiektow z grupy
      blockwrite(f, t, 1);
     end;

   end;


   t[0]:=$ff;               // grupa = $ff, czyli koniec pliku z danymi
   blockwrite(f, t, 1);


   t[0]:=ord(CheckBox7.Checked)*$80 or
         ord(CheckBox8.Checked)*$40 or
         ord(CheckBox9.Checked)*$20 or
         ord(CheckBox10.Checked)*$10 or
         ord(CheckBox11.Checked)*8 or
         ord(CheckBox12.Checked)*4;

   t[0]:=t[0] xor $ff;

   t[1]:=StrToInt(LabeledEdit4.Text);
   t[2]:=StrToInt(LabeledEdit5.Text);

   t[3]:=Minutes.Position or (Seconds.Position shl 2);

   blockwrite(f, t, 4);


// zapisanie informacji o duchach PMG

  if not(PMGEnabled.Checked) then begin

   t[0]:=0;
   blockwrite(f, t, 1);

  end else begin

   t[0]:=ord(OverlayOrder.Checked[0])*$80 +
         ord(OverlayOrder.Checked[1])*$40 +
         ord(OverlayOrder.Checked[2])*$20 +
         ord(OverlayOrder.Checked[3])*$10 +
         StrToInt(OverlayHeight.Text);

   blockwrite(f, t, 1);

   t[0]:=OverlayColors[0,0];                 // PM colors
   t[1]:=OverlayColors[1,0];
   t[2]:=OverlayColors[2,0];
   blockwrite(f, t, 3);

   t[0]:=StrToInt(LabeledEdit6.Text)+48;     // players
   t[1]:=StrToInt(LabeledEdit8.Text)+48;
   t[2]:=StrToInt(LabeledEdit9.Text)+48;
   blockwrite(f, t, 3);

   t[0]:=StrToInt(LabeledEdit7.Text)+48;     // missiles
   t[1]:=StrToInt(LabeledEdit10.Text)+48;
   t[2]:=StrToInt(LabeledEdit11.Text)+48;
   blockwrite(f, t, 3);

   zapisz_ply(f, 1);
   zapisz_ply(f, 2);
   zapisz_ply(f, 3);

   zapisz_mis(f);

   test:=false;
   for i:=0 to StrToInt(form1.OverlayHeight.Text)-1 do begin
    if OverlayColors[0,i]<>OverlayColors[0,0] then test:=true;
    if OverlayColors[1,i]<>OverlayColors[1,0] then test:=true;
    if OverlayColors[2,i]<>OverlayColors[2,0] then test:=true;
   end;

   if not(test) then begin
    t[0]:=0;
    blockwrite(f, t, 1);
   end else begin

    t[0]:=$ff;            
    blockwrite(f, t, 1);

    for i:=0 to StrToInt(form1.OverlayHeight.Text)-1 do
     blockwrite(f, OverlayColors[0,i], 1);

    for i:=0 to StrToInt(form1.OverlayHeight.Text)-1 do
     blockwrite(f, OverlayColors[1,i], 1);

    for i:=0 to StrToInt(form1.OverlayHeight.Text)-1 do
     blockwrite(f, OverlayColors[2,i], 1);

   end;

  end;

  closefile(f);

  nam2:=ChangeFileExt(nam,'.xex');

  SaveRES('PANG',nam2);

  assignfile(f, nam2); reset(f,1);
  blockread(f, bf, sizeof(bf), len);
  closefile(f);

  i:=0;
  while (i<len) and not((bf[i]=ord('t')) and (bf[i+1]=ord('u')) and (bf[i+2]=ord('t')) and (bf[i+3]=ord('a')) and (bf[i+4]=ord('j'))) do inc(i);

  assignfile(f, nam); reset(f,1);
  blockread(f, bf[i], 1024, err);
  closefile(f);


  i:=0;
  while (i<len) and not((bf[i]=ord('t')) and (bf[i+1]=ord('e')) and (bf[i+2]=ord('x')) and (bf[i+3]=ord('t')) and (bf[i+4]=ord('u'))) do inc(i);

  texture:=ChangeFileExt(texture, '.df7');

  form1.Caption:=title+' ('+SaveDialog1.FileName+')';

  assignfile(f, texture); reset(f,1);
  blockread(f, bf[i], 6000, err);
  closefile(f);


  assignfile(f, nam2); rewrite(f,1);
  blockwrite(f, bf, len);
  closefile(f);

  if not(grp0) then Application.MessageBox('Musi zostac zdefiniowana conajmniej jedna kula (OBJECT=0..3, GROUP=0).','Save *.LEV',MB_ICONEXCLAMATION);

 end;

end;


procedure TForm1.Image2MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 palMov:=Point(x shr 4,y shr 4);
end;


procedure hero;
begin
 with form1 do begin

 image6.Visible:=true;

 image6.Width:=48; image6.Height:=64;

 with image6.Canvas do begin
  Pen.Color:=clRed; Brush.Color:=clRed;
  rectangle(0,0,48,64);
 end;

 image6.Left:=StrToInt(LabeledEdit4.Text)*16+image1.Left;
 image6.Top:=StrToInt(LabeledEdit5.Text)*16+image1.top;

 end;

end;


procedure TForm1.LabeledEdit4Change(Sender: TObject);
begin
 hero;
end;


procedure TForm1.SetPMGOverlay1Click(Sender: TObject);
// ADD PMG OVERLAY
var w,k,i: integer;
    a: byte;
begin
 ZapiszUNDO;

 searchOBJinit;

     for w:=ptOrigin.y to ptMove.y do
      for k:=ptOrigin.x to ptMove.x do begin

       i:=searchOBJ(Point(k,w));

       if i and $FF<>$FF then begin         // znaleziono obiekt
        a:=byte(i shr 8);

        if objList[a].y<15 then begin
         ovr[objList[a].x*4, objList[a].y].use:=true;
         ovr[objList[a].x*4+1, objList[a].y].use:=true;
         ovr[objList[a].x*4+2, objList[a].y].use:=true;
         ovr[objList[a].x*4+3, objList[a].y].use:=true;
        end;

       end;

      end;

shw_tex;
end;


procedure TForm1.LabeledEdit6Change(Sender: TObject);
begin
 PMGEnabled.Checked:=true;

 if StrToInt(LabeledEdit6.Text)>128 then LabeledEdit6.Text:='128';
 if StrToInt(LabeledEdit8.Text)>128 then LabeledEdit8.Text:='128';
 if StrToInt(LabeledEdit9.Text)>128 then LabeledEdit9.Text:='128';

 if StrToInt(LabeledEdit7.Text)>152 then LabeledEdit6.Text:='152';
 if StrToInt(LabeledEdit10.Text)>152 then LabeledEdit8.Text:='152';
 if StrToInt(LabeledEdit11.Text)>152 then LabeledEdit9.Text:='152';

 SelectMode.ItemIndex:=1;
 SelectMode.ItemIndex:=2;
end;


procedure TForm1.FormShow(Sender: TObject);
begin
 SelectMode.ItemIndex:=2;
 SelectMode.ItemIndex:=1;

 Clear1Click(form1);
end;


procedure TForm1.PMGEnabledClick(Sender: TObject);
begin

 if PMGEnabled.Checked then begin

  LabeledEdit6.Enabled:=true;
  LabeledEdit7.Enabled:=true;
  LabeledEdit8.Enabled:=true;
  LabeledEdit9.Enabled:=true;
  LabeledEdit10.Enabled:=true;
  LabeledEdit11.Enabled:=true;
  OverlayHeight.Enabled:=true;

  OverlayOrder.Enabled:=true;

  OverlayOrder.Checked[0]:=true;
  OverlayOrder.Checked[1]:=true;
  OverlayOrder.Checked[2]:=true;

  LabeledEdit6Change(nil);
 end else begin

  LabeledEdit6.Enabled:=false;
  LabeledEdit7.Enabled:=false;
  LabeledEdit8.Enabled:=false;
  LabeledEdit9.Enabled:=false;
  LabeledEdit10.Enabled:=false;
  LabeledEdit11.Enabled:=false;
  OverlayHeight.Enabled:=false;

  OverlayOrder.Enabled:=false;

  SelectMode.ItemIndex:=1;
 end;

end;



procedure TForm1.Clear1Click(Sender: TObject);
var i,j: integer;
begin
 ZapiszUNDO;

 for j:=0 to 18 do
  for i:=0 to 159 do ovr[i,j].use:=false;

 LabeledEdit6.Text:='20';
 LabeledEdit7.Text:='52';

 LabeledEdit8.Text:='60';
 LabeledEdit10.Text:='92';

 LabeledEdit9.Text:='100';
 LabeledEdit11.Text:='132';

 shw_tex;
end;


procedure TForm1.Priority11Click(Sender: TObject);
begin
 Priority11.Checked:=true;
 Priority81.Checked:=false;

 shw_tex;
end;


procedure TForm1.Priority81Click(Sender: TObject);
begin
 Priority11.Checked:=false;
 Priority81.Checked:=true;

 shw_tex;
end;


procedure TForm1.ClrPMGOverlay1Click(Sender: TObject);
// CLR PMG OVERLAY
var w,k,i: integer;
    a: byte;
begin
 ZapiszUNDO;

 searchOBJinit;

     for w:=ptOrigin.y to ptMove.y do
      for k:=ptOrigin.x to ptMove.x do begin

       i:=searchOBJ(Point(k,w));

       if i and $FF<>$FF then begin         // znaleziono obiekt
        a:=byte(i shr 8);

        if objList[a].y<15 then begin
         ovr[objList[a].x*4, objList[a].y].use:=false;
         ovr[objList[a].x*4+1, objList[a].y].use:=false;
         ovr[objList[a].x*4+2, objList[a].y].use:=false;
         ovr[objList[a].x*4+3, objList[a].y].use:=false;
        end;
         
       end;

      end;

shw_tex;
end;


end.
