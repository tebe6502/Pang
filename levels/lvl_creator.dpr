program lvl_creator;

{$APPTYPE CONSOLE}

uses
  SysUtils, IniFiles;

type
  TLvl = record
          fnam: string;
          len: integer;
          lvl, map: byte;
         end;

var
 MainPath, path: string;

 all: integer;

 tb: array of TLvl;

 buf: array [0..16383] of byte;


procedure SaveAll(fnam: string);
var i, ln: integer;
    f,g: file;
    a: word;
begin


 fnam:=ChangeFileExt(fnam, '.dat');

 assignfile(g, fnam); rewrite(g,1);

 a:=0;

 for i := 0 to High(tb) - 1 do begin
  blockwrite(g, a, 2);

  inc(a, tb[i].len);
 end;


 for i := 0 to High(tb) - 1 do begin

  assignfile(f, tb[i].fnam); reset(f, 1);
  blockread(f, buf, sizeof(buf), ln);
  closefile(f);

  blockwrite(g, buf, ln);
  
 end;

 closefile(g);

end;


procedure readINI(fnam: string);
var INI: TINIFile;
    l, m, k, len: integer;
    s, fn, ext: string;
    f: file;
begin

 SetLength(tb, 1);

 writeln('Read: ', fnam);

 INI := TINIFile.Create(fnam);

 path:=INI.ReadString('dir','path','');
 ext:=INI.ReadString('ext','ext','lev');

 path := IncludeTrailingPathDelimiter( path );

 for l := 1 to 12 do begin

  writeln;
  writeln('Level: ',l);

  for m := 1 to 6 do begin
    s:=INI.ReadString('lvl'+IntToStr(l),IntToStr(m),'');

    fn:=path+s+'.'+ext;

    if s<>'' then begin

     writeln('map_',m,' = ', fn);

     if not(FileExists(fn)) then begin
      writeln('Cannot open file ''',fn,'''');
      halt;
     end;

     for k := High(tb)-1 downto 0 do
      if tb[k].fnam = fn then begin
       Writeln('Map duplicate ''',fn,'''');
       halt;
      end;

     assignfile(f, fn); reset(f, 1);
     len:=FileSize(f);
     closefile(f);

     k:=High(tb);
     tb[k].fnam := fn;
     tb[k].lvl := l;
     tb[k].map := m;
     tb[k].len := len;

     SetLength(tb, k+2);

     inc(all, len);
    end;


  end;

 end;


 INI.Free;

end;


begin

 MainPath := ExtractFilePath(ParamStr(0));
 MainPath := IncludeTrailingPathDelimiter( MainPath );

 if ParamCount <> 1 then begin
   Writeln('lvl_creator 1.0');
   Writeln('Usage: lvl_creator filename.inf');
   halt;
 end;

 readIni(MainPath + ParamStr(1));

 SaveAll(MainPath + ParamStr(1));

 writeln;
 writeln(all,' bytes');
end.
