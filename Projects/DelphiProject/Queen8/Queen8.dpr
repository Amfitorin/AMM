program Queen8;

{$APPTYPE CONSOLE}

uses
  SysUtils;
var i: Integer;
    a: array [1 .. 8] of Boolean;
    b: array [2 .. 16] of Boolean;
    c: array [-7 .. 7] of Boolean;
    x: array [1 .. 8] of Integer;

procedure Print;
var k: Integer;
begin
  for k:= 1 to 8 do write(x[k], ' ');
  Writeln;
end;

procedure TryIt (i: Integer);
var j: Integer;
begin
  for j:= 1 to 8 do
  begin
    if a[j] and b[i+j] and c[i-j] then
    begin
      x[i]:= j;
      a[j]:= False;
      b[i+j]:= False;
      c[i-j]:= False;
      if i<8 then  TryIt(i+1) else Print;
      a[j]:= True;
      b[i+j]:= True;
      c[i-j]:= True;
    end;
  end;
end;

// Тело основной программы
begin
  // Начальная инициализация:
  for i:= 1 to 8 do a[i]:= True;
  for i:= 2 to 16 do b[i]:= True;
  for i:= -7 to 7 do c[i]:= True;

  // И вызываем процедуру расстановки:
  TryIt(1);

  Readln;
end.
