// detekcja kolizji dla Panga
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
var a, b, c, d, e, f, g, h: TPoint;
    zm: string;
    label jump;
begin

 with image1.Canvas do begin
  brush.Color:=0; pen.Color:=0;
  rectangle(0,0,320,200);

  brush.Color:=clRed; Pen.Color:=clRed;
  rectangle(rm.X, rm.Y, rm.X+20, rm.y+39);

  brush.Color:=clGreen; Pen.Color:=clGreen;
  rectangle(rc.X, rc.Y, rc.X+10, rc.y+32);
 end;

 d.X:=rc.X;
 d.Y:=rc.Y+32;

 c.X:=rc.X+10;
 c.Y:=rc.Y+32;

 b.x:=rc.X+10;
 b.Y:=rc.Y;

 a:=rc;


 h.X:=rm.X;
 h.Y:=rm.Y+39;

 g.X:=rm.X+20;
 g.Y:=rm.Y+39;

 f.x:=rm.X+20;
 f.Y:=rm.Y;

 e:=rm;

 label1.Caption:='Brak kolizji';

// prostokaty musza zawsze sie przeciac, jesli prostokat zostanie wpisany
// w prostokat wowczas kolizja nie zostanie wykryta
//
// dlatego najlepiej jesli prostokaty sa tych samych rozmiarow, albo
// prostokat z ktorym porownujemy jest zawsze wiekszy od pozostalych

 zm:='';


 if ( ((E.y < D.y) and (E.y >= A.y)) or ((G.y < D.y) and (G.y >= A.y))) then

 if (F.x >= D.x) then
  if (F.x < C.x) then begin
   zm:='z lewej strony';
   goto jump;
  end else
   if (E.x < D.x) then begin
    zm:='zawierajaca';
    goto jump;
   end else
    if (E.x < C.x) then begin
     zm:='z prawej strony';
     goto jump;
    end else exit;

 exit;

jump:

  label1.Caption:='Kolizja '+zm;

end;


procedure TForm1.FormCreate(Sender: TObject);
begin
 rc:=Point(160,100);
 Image1Click(form1);
end;

end.
