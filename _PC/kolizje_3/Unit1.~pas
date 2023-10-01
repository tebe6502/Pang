// 06.10.2008
// detekcja kolizji dla obiektów o jednakowych rozmiarach
// sprawdzana jest kolizja pomiedzy prostokatami

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


procedure TForm1.Image1Click(Sender: TObject);
var cx1, cx2, cy1, cy2: integer;
    zm: string;
    label jump;
begin

 with image1.Canvas do begin
  brush.Color:=0; pen.Color:=0;
  rectangle(0,0,320,200);

  brush.Color:=clRed; Pen.Color:=clRed;
  rectangle(rm.X, rm.Y, rm.X+12, rm.y+21);

  brush.Color:=clGreen; Pen.Color:=clGreen;
  rectangle(rc.X, rc.Y, rc.X+12, rc.y+21);
 end;

 zm:='';


 cx1:=rm.X-10;
 cx2:=rm.X+10;

 cy1:=rm.Y-18;
 cy2:=rm.Y+18;

 if (rc.X<cx1) or (rc.X>=cx2) then goto jump;
 if (rc.Y<cy1) or (rc.Y>=cy2) then goto jump;

 zm:='Kolizja !!!';

jump:
 label1.Caption:=zm;

end;


procedure TForm1.FormCreate(Sender: TObject);
begin
 rc:=Point(160,100);
 Image1Click(form1);
end;

end.
