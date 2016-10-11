program Project2;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  MyTree in 'MyTree.pas';

var arr: array of Integer;
    var myFile: Text; // ��������� ���������� ���� Text ��� ���������� �  ��������� ������
    i: Integer;

    uk: tree_ptr;

    sum, count, srednee: Integer;

begin
  { TODO -oUser -cConsole Main : Insert code here }
  SetLength(arr, 21);  // ��������� ����� ����������� �������
  assign(myFile, 'in.txt'); // ��������� ���� � ���������� myFile
  reset(myFile); // ��������� ���� �� ������

  // ������ ���� � ������:
  i:= 0;
  while not Eof(myFile) do // ��������� ���� ������ ����� �� �����
    begin
      readln(myFile, arr[i]); // ��������� ����� � ������
      Inc(i);
    end;
  close(myFile); // ��������� ����, ����������� �������

  // � ��������� ������ � ���������������� ������ (�� �����)
  // uk:= MassiveToBalancedTree(arr);

  //for i:=0 to 20 do write(arr[i], ' ');
  //FrontOrderLeft(uk);  Writeln;
  //FrontOrderRight(uk); Writeln;

  for i:=0 to 20 do uk:= InsertKey(uk, arr[i]);
  //FrontOrderLeft(uk);  Writeln;

  Write('Keys: '); sum:= SumLR(uk);
  Writeln;
  Writeln('Sum = ', sum);
  Write('Count Key = '); count:= CountLR(uk); Writeln(count);

  Write('Srednee znacheniye = '); srednee:= sum div count; Writeln(srednee);

  FrontOrderLeft(uk);  Writeln;
  uk:= RemoveKey(uk, srednee);
  FrontOrderLeft(uk);  Writeln;


  uk:= RemoveKey(uk, 1);
  FrontOrderLeft(uk);  Writeln;


  // PrintTree(uk, 0); // ������ ������

  Readln;
end.
