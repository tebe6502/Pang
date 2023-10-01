uses crt;

type obr=array[0..64000] of byte;

var g:file of byte;
    a,b,c,px,py,px_,py_,l,dd,_dd,iy,ix,ei,qq,ww,cnt,miny,maxy,l_sc:integer;
    i,j,bajt:byte;
    f:word;
    x,y,z,x1,x2,x3,x4,y1,y2,y3,y4,z1,z2,z3,z4,ddx,ddx_,ddy,ddy_:real;
    _x1,_x2,_x3,_x4,_y1,_y2,_y3,_y4,tst:integer;
    cosa,sina,alfa,beta,k:real;
    tsin:array [0..255] of real;
    edge:array [0..511] of word;
    zoompic:array [0..4095] of byte;
    wsp:array [0..3000] of record
              x,y,z:real;
              end;
    t:file of integer;
    video:array [0..0] of byte absolute $a000:0;
    scr:^obr;
    xp,yp,xk,yk:integer;
    label stop;


const
     ofs=256;
     ile=1;
     d=-100;
     dx=160;
     dy=100;
     vy=-200;
     pixel=8;                { 1281 pixli - torus.dat }
     r=30;
     stp=360/256;

     szer=16;

 sciany:array [0..29] of integer=(
 0,1,2,3,0, 5,4,7,6,5, 4,5,1,0,4, 1,5,6,2,1, 6,7,3,2,6, 4,0,3,7,4);



procedure waiting;
label again;
begin
  asm
     mov dx,03dah
   again:
     in al,dx
     test al,1000b
     jz again
end;
end;

procedure clear;
begin
fillchar(scr^,64000,0);
end;

procedure putpixel(x,y:word;c:byte);
begin
scr^[x+y*320]:=c;
end;

procedure Line(x1, y1, x2, y2 : integer; color : byte);
var d,dinc2:integer;
    dinc1,xinc1,xinc2,i,npix,dx,dy,x,x_,y_,ly,y,yinc1,yinc2:byte;
begin

  { Calculate dx and dy for initialisation }
  dx := abs(x2 - x1);
  dy := abs(y2 - y1);

  { Initialize all vars based on which is the independent variable }
 if (y2-y1>=0) then begin
  ei:=0; cnt:=cnt+dy;
 end else ei:=ofs;

  if dx >= dy then begin

     { x is independent variable }
      npix := dx + 1;
      dinc1 := dy Shl 1;
      d := dinc1 - dx;
      dinc2 := (dy - dx) shl 1;
      xinc1 := 1;
      xinc2 := 1;
      yinc1 := 0;
      yinc2 := 1;
    end
  else
    begin

      { y is independent variable }
      npix := dy + 1;
      dinc1 := dx Shl 1;
      d := dinc1 - dy;
      dinc2 := (dx - dy) shl 1;
      xinc1 := 0;
      xinc2 := 1;
      yinc1 := 1;
      yinc2 := 1;
    end;

  { Make sure x and y move in the right directions }
  if x1 > x2 then
    begin
      xinc1 := - xinc1;
      xinc2 := - xinc2;
    end;
  if y1 > y2 then
    begin
      yinc1 := - yinc1;
      yinc2 := - yinc2;
    end;

  { Start drawing at <x1, y1> }
  x:= x1;
  y:= y1; ly:=0;

  { Draw the pixels }
  for i := 1 to npix do begin

{   PutPixel(x, y, color);}

if ei=0 then begin if ly<>y then begin edge[y+ei]:=x; ly:=y; end;
 end else begin
  edge[y+ei]:=x; end;

      if d < 0 then
        begin
          d:=d+dinc1;
          x:=x+xinc1;
          y:=y+yinc1;
        end
      else
        begin
          d:=d+dinc2;
          x:=x+xinc2;
          y:=y+yinc2;
        end;
    end;
end;

procedure rzut;
begin
x:=wsp[l].x;
y:=wsp[l].y;
z:=wsp[l].z;

sina:=tsin[i];
cosa:=tsin[j];

x1:=x;
y1:=cosa*y-sina*z;
z1:=sina*y+cosa*z;

x2:=cosa*x1-sina*y1;
y2:=sina*x1+cosa*y1;
z2:=z1;

x4:=x2;
y4:=y2+vy+dd;
z4:=z2;

px:=round(-x4/y4*d)+dx;if px<0 then px:=0; if px>319 then px:=319;
py:=round(-z4/y4*d)+dy;if py>199 then py:=199;

if py<miny then miny:=py;
if py>maxy then maxy:=py;
end;



procedure fill;
begin
 for py:=miny+1 to miny+cnt do begin

if edge[py]>=edge[py+ofs] then
  for px:=edge[py+ofs] to edge[py] do scr^[px+py*320]:=ix+5 else
  for px:=edge[py] to edge[py+ofs] do scr^[px+py*320]:=ix+5;
 end;
end;


begin
getmem(scr,64000);

{assign(g,'t64_3.bmp');reset(g);b:=0;
for a:=0 to 117 do read(g,bajt);
for a:=0 to 2047 do begin
read (g,bajt); zoompic[b]:=(bajt shr 4); zoompic[b+1]:=(bajt and $f); b:=b+2;
end;
close(g);
}

fillchar(wsp,sizeof(wsp),0);

x:=0;y:=360/256;
for a:=0 to 255 do begin
tsin[a]:=sin(x*pi/180);x:=x+y;
end;

 asm
 mov ax,$13
 int $10
 end;

 port[$3c8]:=0;for a:=0 to 767 do port[$3c9]:=a;


{ ** SZESCIAN ** }
l:=0;
   wsp[l].x:=25; wsp[l].y:=25; wsp[l].z:=25; inc(l);
   wsp[l].x:=-25; wsp[l].y:=25; wsp[l].z:=25; inc(l);
   wsp[l].x:=-25; wsp[l].y:=-25; wsp[l].z:=25; inc(l);
   wsp[l].x:=25; wsp[l].y:=-25; wsp[l].z:=25; inc(l);
   wsp[l].x:=25; wsp[l].y:=25; wsp[l].z:=-25; inc(l);
   wsp[l].x:=-25; wsp[l].y:=25; wsp[l].z:=-25; inc(l);
   wsp[l].x:=-25; wsp[l].y:=-25; wsp[l].z:=-25; inc(l);
   wsp[l].x:=25; wsp[l].y:=-25; wsp[l].z:=-25; inc(l);


px_:=0; py_:=0;
i:=0;j:=64; dd:=0; _dd:=5;

{i:=3*17; j:=i+64;}

repeat
for l_sc:=0 to 5 do begin
cnt:=0; miny:=$ff; maxy:=0; fillchar(edge,sizeof(edge),0);
ix:=l_sc*5;
  l:=sciany[ix]; rzut; _x1:=px; _y1:=py;
  l:=sciany[ix+1]; rzut; _x2:=px; _y2:=py;
  l:=sciany[ix+2]; rzut; _x3:=px; _y3:=py;
  l:=sciany[ix+3]; rzut; _x4:=px; _y4:=py;

{ test widocznosci }
 tst:=(_x3-_x1)*(_y2-_y1)-(_x2-_x1)*(_y3-_y1);
 if tst>=0 then begin
  line(_x1,_y1,_x2,_y2,63+ix);
  line(_x2,_y2,_x3,_y3,63+ix);
  line(_x3,_y3,_x4,_y4,63+ix);
  line(_x4,_y4,_x1,_y1,63+ix);
 fill;
 end;
end;

delay(10); waiting;
move(scr^,video,64000); clear;

{inc(dd,_dd); if abs(dd)>=$80 then _dd:=-_dd;}
{dd:=$80;}

inc(i,3); inc(j,3);
until keypressed;

stop:
asm
   mov ax,3
   int $10
end;

writeln(qq,',',ww);
end.