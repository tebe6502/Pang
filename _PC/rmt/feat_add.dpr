program feat_add;

{$APPTYPE CONSOLE}

//uses
//  SysUtils;

type
   __vars = record
             name: string;
             value: integer;
            end;

var
 vars: array of __vars;

 cnt, len: integer;

 fout: textfile;

 zm: string;

 fspeed: integer = -1;
 cspeed: integer = -1;


procedure Syntax;
begin
 writeln('featadd file0.feat file1.feat [file2.feat]');
 halt;
end;


procedure omin_spacje(var i: integer; var a: string);
begin
 if a<>'' then
  while a[i] in [' ',#9] do inc(i);
end;


procedure add_vars(a,b: string);
var i, err, x: integer;
    ok: Boolean;
begin

 if (a='FEAT_INSTRSPEED') or (a='FEAT_CONSTANTSPEED') then b:='0';

 ok:=false;
 for i:=0 to High(vars)-1 do
  if vars[i].name=a then begin ok:=true; Break end;

 val(b, x, err);

 if not(ok) then begin
  i:=High(vars);

  vars[i].name:=a;
  vars[i].value:=x;

  SetLength(vars, i+2);
 end else
  vars[i].value:=vars[i].value or x;

end;


procedure read_feat(fnam: string);
var t: textfile;
    a, value, lab: string;
    i, x, err: integer;
begin

 assignfile(t, fnam); reset(t);

 while not eof(t) do begin
  readln(t, a);

  i:=1;
  omin_spacje(i,a);

  if a[i]<>';' then begin

   lab:='';
   while not(a[i] in [' ',#9,#0]) do begin
    lab:=lab+a[i];
    inc(i);
   end;

   omin_spacje(i,a);

   value:='000';
   value[1]:=a[i];
   value[2]:=a[i+1];
   value[3]:=a[i+2];

   if value<>'equ' then begin
    writeln('FEAT syntax error.');
    halt;
   end;

   inc(i,3);

   omin_spacje(i,a);

   value:='';
   while not(a[i] in [' ',#9,#0,';']) do begin
    value:=value+a[i];
    inc(i);
   end;

   add_vars(lab, value);

   val(value, x, err);


   if lab='FEAT_INSTRSPEED' then begin

    if fspeed < 0 then
     fspeed := x
    else
     if fspeed <> x then writeln('WARNING ''',fnam,'''',': Different FEAT_INSTRSPEED value (',x,')');

   end;

{
   if lab='FEAT_CONSTANTSPEED' then begin

    if cspeed < 0 then
     cspeed := x
    else
     if cspeed <> x then begin
      writeln(fnam);
      writeln('Different FEAT_CONSTANTSPEED value.');
      halt;
     end;

   end;
}

  end;

 end;

 closefile(t);
end;


begin

 SetLength(vars, 1);

 if ParamCount=0 then
  Syntax
 else
  for cnt:=2 to ParamCount do read_feat(ParamStr(cnt));


 assignfile(fout, ParamStr(1)); rewrite(fout);

 for cnt:=0 to High(vars)-1 do begin

  zm:=vars[cnt].name;
  len:=length(zm);

  while len<32 do begin
   zm:=zm+#9;
   inc(len,8);
  end;

  writeln(fout, zm+'equ'+#9,vars[cnt].value);

 end;

 closefile(fout);

end.
