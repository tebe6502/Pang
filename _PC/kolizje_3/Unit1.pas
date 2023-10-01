// 06.10.2008
// detekcja kolizji dla obiektów o jednakowych rozmiarach
// sprawdzana jest kolizja pomiedzy prostokatami
// na podstawie CI28.XEX

unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TForm1 = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Button1: TButton;
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Button1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

  rm, rc: TPoint;

implementation

{$R *.dfm}

procedure TForm1.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 rm:=Point(x,y);
end;


function collision: Boolean;
var x1,x2,y1,y2,s1,s2,v1,v2: byte;
begin

 Result:=true;

 s1:=28; v1:=32;
 s2:=16; v2:=25;

 x1:=rm.x; y1:=rm.y;
 x2:=rc.x; y2:=rc.y;

 with form1.image1.Canvas do begin
  brush.Color:=0; pen.Color:=0;
  rectangle(0,0,320,200);

  brush.Color:=clRed; Pen.Color:=clRed;
  rectangle(x1, y1, x1+s1, y1+v1);

  brush.Color:=clGreen; Pen.Color:=clGreen;
  rectangle(x2, y2, x2+s2, y2+v2);
 end;

 x1:=rm.x; y1:=rm.y;
 x2:=rc.x; y2:=rc.y;

{
	lda x2
	clc
	adc #s2
	sbc x1
	cmp #s1+s2-1
	bcs none
}

 if ( byte(x2+s2-x1-1) >= byte(s1+s2-1) ) then begin Result:=false; exit end;

{
	lda y2
	clc
	adc #v2
	sbc y1
	cmp #v1+v2-1
	bcs none
}

 if ( byte(y2+v2-y1-1) >= byte(v1+v2-1) ) then Result:=false;

end;


procedure TForm1.Image1Click(Sender: TObject);
begin

 if collision then
  label1.Caption:='Kolizja !!!'
 else
  label1.Caption:='';

end;


function GetCpuClockCycleCount: Int64;
asm
  dw $310F  // opcode for RDTSC
end;



procedure TForm1.Button1Click(Sender: TObject);
var vTick1, vTick2, vFrequency : int64;
    r: integer;

begin

vTick1:=GetCpuClockCycleCount;
vTick2:=GetCpuClockCycleCount;

r := (vTick2 - vTick1);

label1.Caption:=inttostr(r);

end;



procedure TForm1.FormCreate(Sender: TObject);
begin
 rc:=Point(120,90);
 Image1Click(form1);
end;

end.
