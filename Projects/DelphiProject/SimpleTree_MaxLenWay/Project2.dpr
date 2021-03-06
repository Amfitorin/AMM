program Project2;

{$APPTYPE CONSOLE}

uses
  EsConsole in 'EsConsole.pas',
  MySimpleTree in 'MySimpleTree.pas';

// ������ ���������� ����������� ������ � ������� ������ � ���

var myFile: Text; // ���������� ���� Text ��� ���������� � ��������� ������
    tmp: Integer;

    uk, tmpNode: tree_ptr;
    sum, count, srednee: Integer;

begin
  // ������� ���������� �� ������:
  Writeln('| ------------------------------------------------------- |');
  Writeln('| ������� �.�., ���, 2 ����, 1 �������. ������� 3, (� 20) |'); 
  Writeln('| ����� ���� ����� ������, ����������� ������� �� ������  |');
  Writeln('| ������, ������� ���� ������������ �����, ��� ��������   |');
  Writeln('| ����� ������ �������� ������ ����������.                |');
  Writeln('| ------------------------------------------------------- |');
  Writeln;

  // 1) --------------- ������ �� ����� � ����������� ������ ------------------
  assign(myFile, 'in3.txt'); // ��������� ���� � ���������� myFile
  reset(myFile); // ��������� ���� �� ������
  // ������ ������ ������� ����� ����� � ������:
  tmp:= 0;
  while not Eof(myFile) do // ��������� ���� ������ ����� �� �����
    begin
      readln(myFile, tmp); // ��������� ����� �� ��������� ���������
      uk:= InsertKey(uk, tmp);  // � ��������� �� � ������
    end;
  close(myFile); // ��������� ����, ����������� �������
  // 1) -----------------------------------------------------------------------

  // 2) --------------- ����� ��������� ������ � ������� ----------------------
  Write('   �������� ������ (������ ����� �����): ');
  FrontOrderLeft(uk); // ������� �� ������� ������ ����� ������� ���� ������
  Writeln;

  WriteLn('   ���������: ');
  Writeln;
  PrintLeftTree(uk); // ������ ����������������� ������
  // 2) -----------------------------------------------------------------------

  // 3) ------------------ ���������� ���������� ������� ----------------------
  //WriteLn('   ����� �������� ��� ���������: ', SumKey_MaxLenWay(uk));
  tmpNode:= FindNodeBetween_MaxLenWay(uk);
  WriteLn('   ����, ����� ������� �������� ������� ����: ', tmpNode^.key);
  WriteLn('   ����� �������� ��������� ��� ������� ����: ', SumKey_MaxLenWay(tmpNode) );
  write('   ���� ������������ �����: '); PrintMaxLenWay(tmpNode);
  Writeln('   ����� ����: ', MaxLenWay(tmpNode) );
 {
  // ���� � ������� ������ ��������� ������� �� ��������
  uk:= FindMiddleAndRightRemove(uk);
  Writeln;
  // 3) -----------------------------------------------------------------------

  // 4) ------------- ����� ������������� ������ � ������� --------------------
  Write('   ����� ������ (������ ����� �����): ');
  FrontOrderLeft(uk); // ������� �� ������� ������ ����� ������� ���� ������
  Writeln;

  WriteLn('   ���������: ');
  Writeln;
  PrintLeftTree(uk); // ������ ����������������� ������
  // 4) -----------------------------------------------------------------------
  }
  Readln;  // �������� ������� ������� � ����� �� ���������
end.
