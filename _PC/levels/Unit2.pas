unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls;

type
  TForm2 = class(TForm)
    Image1: TImage;
    Image2: TImage;
    Shape1: TShape;
    Label1: TLabel;
    procedure FormShow(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure Image1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

  select: TPoint;


implementation

uses Unit1;

{$R *.dfm}

procedure TForm2.FormShow(Sender: TObject);
var tmp1, tmp2: byte;
    i: integer;
begin

 with image1.Canvas do begin
  Brush.Color:=clBtnface;
  Pen.Color:=clBtnface;
  Rectangle(0,0,image1.Width, image1.Height);
 end;

  for tmp2:=0 to 15 do
  for tmp1:=0 to 7 do
   with image1.Canvas do begin
    Pen.Color:=aPal[tmp1 shl 1+tmp2 shl 4];
    Brush.Color:=Pen.Color;
    Brush.Style:=bsSolid;
    Rectangle(tmp1 shl 4+1,tmp2*16+1,tmp1 shl 4+16-1,tmp2*16+15-1);

    Pen.Color:=0;
    Brush.Style:=bsClear;
    Rectangle(tmp1 shl 4+1,tmp2*16+1,tmp1 shl 4+16-1,tmp2*16+15-1);
  end;

 i:=select.x*2+select.y*16;

 with image2.Canvas do begin
  Pen.Color:=aPal[i]; Brush.Color:=aPal[i];
  rectangle(0,0,image2.width, image2.Height);
 end;

 Shape1.Left:=image1.Left+select.x*16-1;
 Shape1.Top:=image1.Top+select.y*16-1;

 Label1.Caption:='$'+IntToHex(select.x*2+select.y*16,2);

end;


procedure TForm2.FormKeyPress(Sender: TObject; var Key: Char);
begin
 if ord(key)=27 then form2.Close;
end;


procedure TForm2.Image1MouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
 select:=Point(x div 16, y div 16);
end;


procedure TForm2.Image1Click(Sender: TObject);
var c: TColor;
    i, x: integer;
begin

 i:=select.x*2+select.y*16;
 c:=aPal[i];

 Shape1.Left:=image1.Left+select.x*16-1;
 Shape1.Top:=image1.Top+select.y*16-1;

 Label1.Caption:='$'+IntToHex(select.x*2+select.y*16, 2);

 with image2.Canvas do begin
  Pen.Color:=c; Brush.Color:=c;
  rectangle(0,0,image2.width, image2.Height);
 end;

 case set_pm of
  $10: for x:=ovrxy.y to 14-1 do
        OverlayColors[ovrxy.x, x]:=byte(i);
 end;

 form1.SelectMode.ItemIndex:=1;
 form1.SelectMode.ItemIndex:=2;

end;

end.
