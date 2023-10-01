program pang_asm;

{$APPTYPE CONSOLE}

uses
  SysUtils;

type

 tablica = array [0..32*240] of byte;

var
 tb0, tb1, tb2, tb3: tablica;

 tora: array [0..255] of Boolean;

 tmsk, tshp: array [0..255] of byte;

 mic: array [0..7683] of byte;

 f: file;
 t: textfile;
 err: integer;

 kula: string;


procedure zapisz(x,y: byte; b: byte; var tb: tablica);
var v: byte;
    i, j, k, rx: integer;
    a, r, iny: Boolean;
begin

 r:=false;  iny:=false;

 writeln(t, '_',b);

 inc(y,x);

 rx:=0;

 for j:=0 to 7 do begin

  v:=$ff;
  for i:=x to y-1 do v:=v and tb[j+i*32];

  if v<>$ff then begin

   if iny then writeln(t, #9'@@INC ',kula);


   for k:=0 to 254 do
   if tora[k] then begin       // jesli TORA = TRUE to jest to krawedz kuli

    for i:=x to y-1 do
     if tb[j+i*32]=k then begin

      writeln(t, #9'lda (ln',i-x,'),y');
      writeln(t, #9'and #$',IntToHex(tmsk[k],2));
      writeln(t, #9'ora #$',IntToHex(tshp[k],2));  if tshp[k]=0 then writeln('blee');
      writeln(t, #9'sta (ln',i-x,'),y');

      r:=true;
     end;
   end;


   for k:=0 to 254 do
   if not(tora[k]) then begin

    a:=false;
    for i:=x to y-1 do
     if tb[j+i*32]=k then begin

      if not(a) then begin
       writeln(t, #9'lda #$',IntToHex(k,2));
       a:=true;
      end;

      writeln(t, #9'sta (ln',i-x,'),y');

      r:=false;
     end;
   end;

  iny:=true;

//  if r then
//   writeln(t, #9'mva #$ff clridx,y')
//  else
//   writeln(t, #9'sta clridx,y');

//  writeln(t, #9'MIN_MAX_Y ',rx);

//  writeln(t, #9'iny');
  end;

  inc(rx);
 end;

 //writeln(t, #9'jmp BALL.testXY');
 writeln(t, #9'jmp BALL.MINMAX');
end;


procedure init;
var i: integer;
    v: byte;
begin

 fillchar(tora, sizeof(tora), false);

 // TORA - jesli jest przynajmniej jeden pixel koloru 11 oraz inne pixle
 for i:=0 to 255-1 do
  if (i and $c0=$C0) or (i and $30=$30) or (i and $c=$c) or (i and $3=3) then tora[i]:=true;


 for i:=0 to 255 do begin
  v:=i;

  if v and $c0=$c0 then v:=v or $c0 else v:=v and ($c0 xor $ff);
  if v and $30=$30 then v:=v or $30 else v:=v and ($30 xor $ff);
  if v and $0c=$0c then v:=v or $0c else v:=v and ($0c xor $ff);
  if v and $03=$03 then v:=v or $03 else v:=v and ($03 xor $ff);

  tmsk[i]:=v;
 end;

 for i:=0 to 255 do begin
  v:=i;

  if v and $c0=$c0 then v:=v and ($c0 xor $ff);
  if v and $30=$30 then v:=v and ($30 xor $ff);
  if v and $0c=$0c then v:=v and ($0c xor $ff);
  if v and $03=$03 then v:=v and ($03 xor $ff);

  tshp[i]:=v;
 end;


 assignfile(f, 'mic\kula_OK_0.mic'); reset(f,1);
 blockread(f, tb0, sizeof(tb0), err);
 closefile(f);

 assignfile(f, 'mic\kula_OK_1.mic'); reset(f,1);
 blockread(f, tb1, sizeof(tb1), err);
 closefile(f);

 assignfile(f, 'mic\kula_OK_2.mic'); reset(f,1);
 blockread(f, tb2, sizeof(tb2), err);
 closefile(f);

 assignfile(f, 'mic\kula_OK_3.mic'); reset(f,1);
 blockread(f, tb3, sizeof(tb3), err);
 closefile(f);

end;


function hznak(const j,k: integer; var col: integer): Boolean;
var i: integer;
    v: byte;
begin
         Result:=false;

         for i:=0 to 7 do begin
          v:=mic[j*256+i*32+k];
          if v<>$FF then
           {if (v and $c0=$c0) or (v and $30=$30) or (v and $0c=$0c) or (v and $03=$03) then} begin
            Result:=true; col:=k; Break
           end;
         end;
end;


function vznak(const j,k: integer; var row: integer): Boolean;
var i: integer;
    v: byte;
begin
         Result:=false;

         for i:=0 to 7 do begin
          v:=mic[j*256+i*32+k];
          if v<>$FF then
           {if (v and $c0=$c0) or (v and $30=$30) or (v and $0c=$0c) or (v and $03=$03) then} begin
            Result:=true; row:=j; Break
           end;
         end;
end;


procedure kolizja(const kierunek:char; h,v,siz: byte);
var f: file;
    b, o: boolean;
    j, x, y, col: integer;
begin

 col:=0;

 assignfile(f, 'mic\kula_OK_'+IntToStr(h)+'.mic');
 reset(f,1);

 case siz of
  4: blockread(f, mic, 5*256);
  3: blockread(f, mic, 9*256);
  2: blockread(f, mic, 12*256);
  1: blockread(f, mic, 14*256);
 end;

 fillchar(mic, sizeof(mic), $ff);

 blockread(f, mic[(v*2)*32], siz*256);
                                                 closefile(f);

 case kierunek of

  'L', 'R':
       begin

        o:=false; y:=-100;

        for j:=0 to siz-1 do begin

         b:=false;

         if kierunek='L' then begin
          x:=0; while not(b) and (x<8) do begin b:=hznak(j, x, col); inc(x) end;
         end else begin
          x:=8; while not(b) and (x>=0) do begin b:=hznak(j,x, col); dec(x) end;
         end;

        // if not(colis[col,j]) then
         if b then begin

          if y=48*j+col-1 then
           writeln(t,#9'iny')
          else
           writeln(t,#9'ldy #48*',j,'+',col);

         //colis[col,j]:=true;

          y:=48*j+col;

          if o then
           writeln(t,#9'ora (inv),y')
          else
           writeln(t,#9'lda (inv),y');

          o:=true;
         end;

        end;

       end;


  'U', 'D':
       begin

        o:=false; y:=-100;

        for x:=0 to siz-1 do begin

         b:=false;

         if kierunek='U' then begin
          j:=0; while not(b) and (j<8) do begin b:=vznak(j, x, col); inc(j) end;
         end else begin
          j:=8; while not(b) and (j>=0) do begin b:=vznak(j,x, col); dec(j) end;
         end;


         if b then begin

          if y=x+48*col-1 then
           writeln(t,#9'iny')
          else
           writeln(t,#9'ldy #',x,'+48*',col);

          y:=x+48*col;

          if o then
           writeln(t,#9'ora (inv),y')
          else
           writeln(t,#9'lda (inv),y');

          o:=true;
         end;

        end;

       end;

  end;

end;


procedure detekcja(const siz: byte);
var h, v: byte;
begin

 writeln(t,#9'lda posy');
 writeln(t,#9'and #7');
 writeln(t,#9'lsr @');
 writeln(t,#9'tay');

 writeln(t,#9'lda posx,x');
 writeln(t,#9'and #3');
 writeln(t,#9'add tmul4,y');
 writeln(t,#9'tay'#13#10);

 writeln(t,#9'mva ladr,y _jmp+1');
 writeln(t,#9'mva hadr,y _jmp+2');

 writeln(t,'_jmp'#9'jmp $ffff'#13#10);

 writeln(t,'ladr'#9'dta l(h0v0,h1v0,h2v0,h3v0, h0v1,h1v1,h2v1,h3v1, h0v2,h1v2,h2v2,h3v2, h0v3,h1v3,h2v3,h3v3)');
 writeln(t,'hadr'#9'dta h(h0v0,h1v0,h2v0,h3v0, h0v1,h1v1,h2v1,h3v1, h0v2,h1v2,h2v2,h3v2, h0v3,h1v3,h2v3,h3v3)');

 for v:=0 to 3 do
 for h:=0 to 3 do begin


 writeln(t,#13#10'h',h,'v',v);

 writeln(t,#9'lda addx,x');
 writeln(t,#9'beq up',h,v);
 writeln(t,#9'bpl right',h,v,#13#10);

// left
 kolizja('L',h,v, siz);

 writeln(t,#13#10#9'jmp eox',h,v);

 writeln(t,'right',h,v);

// right
 kolizja('R',h,v, siz);


 writeln(t,#13#10'eox',h,v,#9'beq up',h,v,#13#10);

 writeln(t,#9'lda addx,x');
 writeln(t,#9'eor #$fe');
 writeln(t,#9'sta addx,x'#13#10);

 writeln(t,'up',h,v,#9'lda addcnt,x');
 writeln(t,#9'bpl down',h,v,#13#10);

// up
 kolizja('U',h,v, siz);

 writeln(t,#9'jmp BALL_COLLISION.return2'#13#10);

//down
 writeln(t,'down',h,v);

 kolizja('D',h,v, siz);

 writeln(t,#9'jmp BALL_COLLISION.return2'#13#10);


 end;

 writeln(t,'.endl');
end;


begin
 init;

 kula:='inck0';
 assignfile(t, 'kula0.asm'); rewrite(t);
 writeln(t, '.local'#9'k0');
 zapisz(0,40, 0, tb0);
 zapisz(0,40, 1, tb1);
 zapisz(0,40, 2, tb2);
 zapisz(0,40, 3, tb3);
 writeln(t, '.end');
 closefile(t);

 kula:='inck1';
 assignfile(t, 'kula1.asm'); rewrite(t);
 writeln(t, '.local'#9'k1');
 zapisz(40,32, 0, tb0);
 zapisz(40,32, 1, tb1);
 zapisz(40,32, 2, tb2);
 zapisz(40,32, 3, tb3);
 writeln(t, '.end');
 closefile(t);

 kula:='inck2';
 assignfile(t, 'kula2.asm'); rewrite(t);
 writeln(t, '.local'#9'k2');
 zapisz(72,24, 0, tb0);
 zapisz(72,24, 1, tb1);
 zapisz(72,24, 2, tb2);
 zapisz(72,24, 3, tb3);
 writeln(t, '.end');
 closefile(t);

 kula:='inck3';
 assignfile(t, 'kula3.asm'); rewrite(t);
 writeln(t, '.local'#9'k3');
 zapisz(96,16, 0, tb0);
 zapisz(96,16, 1, tb1);
 zapisz(96,16, 2, tb2);
 zapisz(96,16, 3, tb3);
 writeln(t, '.end');
 closefile(t);

 kula:='inck4';
 assignfile(t, 'kula4.asm'); rewrite(t);
 writeln(t, '.local'#9'k4');
 zapisz(112,8, 0, tb0);
 zapisz(112,8, 1, tb1);
 zapisz(112,8, 2, tb2);
 zapisz(112,8, 3, tb3);
 writeln(t, '.end');
 closefile(t);

//*****************************************

 assignfile(t, 'ckula0.asm'); rewrite(t);
 writeln(t, '.local'#9'CK0',#13#10);
 detekcja(5);
 closefile(t);

 assignfile(t, 'ckula1.asm'); rewrite(t);
 writeln(t, '.LOCAL'#9'CK1',#13#10);
 detekcja(4);
 closefile(t);

 assignfile(t, 'ckula2.asm'); rewrite(t);
 writeln(t, '.LOCAL'#9'CK2',#13#10);
 detekcja(3);
 closefile(t);

 assignfile(t, 'ckula3.asm'); rewrite(t);
 writeln(t, '.LOCAL'#9'CK3',#13#10);
 detekcja(2);
 closefile(t);

{ assignfile(t, 'ckula4.asm'); rewrite(t);
 writeln(t, '.LOCAL'#9'CK4',#13#10);
 detekcja(1);
 closefile(t); }

end.

