
// RMT2SNG (22.10.2009 - 23.04.2011) by Tebe/Madteam
// fpc -Mdelphi -vh -O3 rmt2sng.dpr

program rmt2sng;

{$APPTYPE CONSOLE}

type

 idx_string = record
               idx: integer;
               str: string;
              end;

var
 module: array of string;
 track, instrument, song: array of idx_string;

 used_instrument, used_track, sfx: array [0..255, 0..255] of Boolean;

 zm, hlp, input_file: string;

 sng_line_begin, idx, cnt, hlp0, hlp1, error: integer;


procedure write_module(var txt: textfile);
var i: integer;
begin

 writeln(txt, '[MODULE]');
 for i:=0 to High(module)-1 do writeln(txt, module[i]);

 writeln(txt);
end;


procedure write_song(var txt: textfile; sng: integer);
var i: integer;
begin

 writeln(txt, '[SONG]');
 for i:=0 to High(song)-1 do
  if (song[i].idx=sng) or (sng<0) then writeln(txt, song[i].str);

end;


procedure write_instrument(var txt: textfile; ins: integer);
var i: integer;
    header: Boolean;
begin

 header:=false;

 for i:=0 to High(instrument)-1 do
  if instrument[i].idx=ins then begin

   if not(header) then begin
    writeln(txt, #13#10'[INSTRUMENT]');
    header:=true;
   end;

   writeln(txt, instrument[i].str);
  end;

end;


procedure write_track(var txt: textfile; trc: integer);
var i: integer;
    header: Boolean;
begin

  header:=false;

  for i:=0 to High(track)-1 do
   if track[i].idx=trc then begin

    if not(header) then begin
     writeln(txt, #13#10'[TRACK]');
     header:=true;
    end;

    writeln(txt, track[i].str);
   end;

end;


procedure read_rmt(fnam: string);
var txt: textfile;
    a, tmp: string;
    head: char;
    i,j, k, x, err: integer;
    trc, ins, sng: integer;
    buf: array [0..255] of Boolean;

const
    tHex: array [0..15] of char =
    ('0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F');

begin

assignfile(txt, fnam); reset(txt);

readln(txt, a);

head:='M';

if a<>'[MODULE]' then begin
 writeln('Invalid file format.');
 exit;
end;

trc:=-1;
ins:=-1;
sng:=0;

for j:=0 to 255 do
 for i:=0 to 255 do begin
  used_instrument[i,j]:=false;
  used_track[i,j]:=false;
 end;


while not eof(txt) do begin
 readln(txt, a);

 if (a<>'') then
  if a[1]='[' then
   if a='[SONG]' then begin
     head:='S';
     readln(txt, a);
   end else
    if a='[TRACK]' then begin
     head:='T';
     readln(txt,a);

     val('$'+copy(a,1,2), trc, err);
    end else
     if a='[INSTRUMENT]' then begin
      head:='I';
      readln(txt,a);

      val('$'+copy(a,1,2), ins, err); 
     end else begin
      writeln('Invalid header ',a);
      exit;
     end;

 if a<>'' then 
 case head of
  'M': begin
        i:=High(module);
        module[i]:=a;

        SetLength(module, i+2);
       end;

  'S': begin
        i:=High(song);
        song[i].idx:=sng;

        if a<>'' then
         if copy(a,1,10)='Go to line' then begin
          inc(sng);

          val('$'+copy(a,12,2), x, err);

          tmp:='00';
          tmp[1]:=tHex[byte(x-sng_line_begin) shr 4];
          tmp[2]:=tHex[byte(x-sng_line_begin) and $f];

          a:='Go to line '+tmp;

          sng_line_begin:=i+1;
         end else begin

          k:=1;
          while k<=length(a) do begin

           if a[k]<>'-' then begin
            tmp:='$'+a[k]+a[k+1];
            val(tmp, x, err);

            used_track[sng, x]:=true;
           end;

           inc(k,3);
          end;

         end;

        song[i].str:=a;
         
        SetLength(song, i+2);
       end;

  'I': begin
        i:=High(instrument);
        instrument[i].idx:=ins;
        instrument[i].str:=a;

        SetLength(instrument, i+2);
       end;

  'T': begin
        i:=High(track);
        track[i].idx:=trc;
        track[i].str:=a;

        if a<>'' then
        if (a[1] in ['A'..'H']) and (a[3] in ['1'..'4']) then begin
         tmp:='$'+a[5]+a[6];
         val(tmp, x, err);

         used_instrument[trc, x]:=true;
        end;

        SetLength(track, i+2);
       end;

 end;

end;

closefile(txt);


for i:=0 to sng-1 do begin
 write('Song #',i);

 str(i,zm);
 assignfile(txt, 'song'+zm+'.txt'); rewrite(txt);

 write_module(txt);     // [MODULE]

 write_song(txt, i);    // [SONG]

 fillchar(buf, sizeof(buf), false);

 for k:=0 to 255 do
  if used_track[i,k] then
   for err:=0 to 255 do
    if used_instrument[k,err] then buf[err]:=true;

 for k:=0 to 255 do
  if sfx[i,k] then buf[k]:=true;

 x:=0;
 for k:=0 to 255 do
  if buf[k] then begin
   write_instrument(txt, k);
   inc(x);
  end;

 write(', Instruments: ',x);

 fillchar(buf, sizeof(buf), false);

 for k:=0 to 255 do
  if used_track[i,k] then buf[k]:=true;

 x:=0;
 for k:=0 to 255 do
  if buf[k] then begin
   write_track(txt, k);
   inc(x);
  end;

 writeln(', Tracks: ',x);

 closefile(txt);
end;


// --------------------------------------------
// SAVE ALL
// --------------------------------------------

{ assignfile(txt, 'test.txt'); rewrite(txt);

 write_module(txt);

 write_song(txt, -1);

 for j:=0 to 255 do write_instrument(txt, j);

 for j:=0 to 255 do write_track(txt, j);

 closefile(txt);
}
end;


procedure Syntax;
begin
 writeln('rmt2sng v1.0');
 writeln('Syntax: rmt2sng rmt_file.txt [-i:instrument,song0,song1...]');
 halt;
end;


begin

 SetLength(module, 1);
 SetLength(track, 1);
 SetLength(song, 1);
 SetLength(instrument, 1);

 if ParamCount=0 then
  Syntax
 else
  for cnt:=1 to ParamCount do
   if ParamStr(cnt)[1]='-' then begin

    zm:=copy(ParamStr(cnt),1,3);

    if (zm<>'-i:') and (zm<>'-I:') then
     Syntax
    else begin

     idx:=4;

     hlp:='';
     while (ParamStr(cnt)[idx]<>',') and (idx<=length(ParamStr(cnt))) do begin
      hlp:=hlp+ParamStr(cnt)[idx];
      inc(idx);
     end;

     if hlp='' then Syntax;
     val(hlp, hlp0, error);

     inc(idx);

     while idx<=length(ParamStr(cnt)) do begin

      hlp:='';
      while (ParamStr(cnt)[idx]<>',') and (idx<=length(ParamStr(cnt))) do begin
       hlp:=hlp+ParamStr(cnt)[idx];
       inc(idx);
      end;

      if hlp='' then Syntax;
      val(hlp, hlp1, error);

      sfx[hlp1,hlp0]:=true;      // song, instrument

      inc(idx);
     end;

    end;

   end else
    input_file:=ParamStr(cnt);

 read_rmt(input_file);

end.
