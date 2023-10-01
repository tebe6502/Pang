program ludek_death;

{$APPTYPE CONSOLE}

uses
  SysUtils;

type

 tablica = array [0..32*240] of byte;

var
 tb0, tb1, tb2, tb3: tablica;

 tora: array [0..255] of Boolean;

 tmsk, tshp: array [0..255] of byte;

 f: file;
 t: textfile;
 err: integer;

 kula, jsr: string;

 skp: integer = 8;
 ile: integer = 32;
 ofs: integer;

 bck: Boolean = false;


procedure zapisz(x: byte; b: byte; var tb: tablica);
var v, y, _inc: byte;
    i, j, k, rx: integer;
    a, r, iny: Boolean;
begin

 r:=false;  iny:=false;

 if not(bck) and (jsr='') then
  writeln(t, '_',b,0)
 else
  writeln(t, '_',b);

 inc(x,skp);

 y:=ile;

 inc(y,x);

 rx:=0;

 _inc:=0;

 if jsr<>'' then begin {writeln(t,#9'jsr ',jsr,'._',b,_inc,#13#10);} inc(_inc) end;

 for j:=0 to 7 do begin

  v:=$ff;
  for i:=x to y-1 do v:=v and tb[j+i*32];

  if v<>$ff then begin

   if iny then begin

    if not(bck) and (jsr='') then begin
     writeln(t, #9'rts');
     writeln(t, '_',b,_inc+1);
    end else
     writeln(t, #9'@@INCRW');

    //if jsr<>'' then writeln(t,#9'jsr ',jsr,'._',b,_inc,#13#10);

    inc(_inc);
   end;

   for k:=0 to 254 do
   if tora[k] then begin       // jesli TORA = TRUE to traktuj jako krawedz 

    for i:=x to y-1 do
     if tb[j+i*32]=k then begin

      if i-x>=ofs then begin
       writeln(t, #9'lda (rw',i-x,'),y');
       writeln(t, #9'and #$',IntToHex(tmsk[k],2));
       if tshp[k]<>0 then writeln(t, #9'ora #$',IntToHex(tshp[k],2));
       writeln(t, #9'sta (rw',i-x,'),y');

       r:=true;
      end;

     end;
   end;


   for k:=0 to 254 do
   if not(tora[k]) then begin

    a:=false;
    for i:=x to y-1 do
     if tb[j+i*32]=k then begin

      if i-x>=ofs then begin

       if not(a) then begin
        writeln(t, #9'lda #$',IntToHex(k,2));
        a:=true;
       end;

       writeln(t, #9'sta (rw',i-x,'),y');

       r:=false;

      end;

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

 if KULA=''then begin
  writeln(t,#9,'rts');
 end else
  writeln(t, #9'jmp ',KULA);

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


end;



begin

 init;


 assignfile(f, 'mic\death0.mic'); reset(f,1);
 blockread(f, tb0, sizeof(tb0), err);
 closefile(f);

 assignfile(f, 'mic\death1.mic'); reset(f,1);
 blockread(f, tb1, sizeof(tb1), err);
 closefile(f);

 assignfile(f, 'mic\death2.mic'); reset(f,1);
 blockread(f, tb2, sizeof(tb2), err);
 closefile(f);

 assignfile(f, 'mic\death3.mic'); reset(f,1);
 blockread(f, tb3, sizeof(tb3), err);
 closefile(f);


 skp:=8;
 ile:=32;
 ofs:=0;

 kula:='FRM0';  jsr:='DEF0';
 assignfile(t, 'frmD0.asm'); rewrite(t);
 writeln(t, '.local'#9'frmD0');
 zapisz(0, 0, tb0);
 zapisz(0, 1, tb1);
 zapisz(0, 2, tb2);
 zapisz(0, 3, tb3);
 writeln(t, '.end');
 closefile(t);


end.

