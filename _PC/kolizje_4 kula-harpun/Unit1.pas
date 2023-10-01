// 04.05.2012
// detekcja kolizji kula - harpun

unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TForm1 = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
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
var x1,x2,y1,y2,s1,s2,v1,v2, r,t: integer;
begin

 Result:=false;

 r:=15;

 x1:=rm.x; y1:=rm.y;
 x2:=rc.x; y2:=rc.y;

 with form1.image1.Canvas do begin
  brush.Color:=0; pen.Color:=0;
  rectangle(0,0,320,200);

  brush.Color:=clRed; Pen.Color:=clRed;
  Chord(x1,y1,x1+r,y1+r,0,0,0,0);

  brush.Color:=clGreen; Pen.Color:=clGreen;
  rectangle(x2, y2, x2+1, 200);
 end;

 x1:=rm.x; y1:=rm.y;
 x2:=rc.x; y2:=rc.y;

 t:=y2-y1;

 if (x2>=x1-r) and (x2<x1+r) then
  if t<r then Result:=true else
   if t>0 then Result:=true;


end;


procedure TForm1.Image1Click(Sender: TObject);
begin

 if collision then
  label1.Caption:='Kolizja !!!'
 else
  label1.Caption:='';

end;


procedure TForm1.FormCreate(Sender: TObject);
begin
 rc:=Point(120,90);
 Image1Click(form1);
end;

end.
