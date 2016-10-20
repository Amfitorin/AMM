program Project2;

{$APPTYPE CONSOLE}

uses
  EsConsole in 'EsConsole.pas',
  MySimpleTree in 'MySimpleTree.pas';

// ������ ���������� ����������� ������ � ������� ������ � ���

var myFile: Text; // ��������� ���������� ���� Text ��� ���������� �  ��������� ������
    tmp: Integer;

    uk: tree_ptr;
    sum, count, srednee: Integer;

begin
  // ������� ���������� �� ������:
  Writeln('| ------------------------------------------------------- |');
  Writeln('| ������� �.�., ���, 2 ����, 1 �������. ������� 2, ���. 3 |');
  Writeln('| ����� � ������� (������ ���������) ������� �� ��������  |');
  Writeln('| ������� �� ������ ������, � ������� ���������� �������� |');
  Writeln('| � ����� ��������� ���������� �� ���������� �������� �   |');
  Writeln('| ������ ��������� �� 1. ��������� ������ (�����) �����   |');
  Writeln('| ����������� ������.                                     |');
  Writeln('| ------------------------------------------------------- |');
  Writeln;

  assign(myFile, 'in3.txt'); // ��������� ���� � ���������� myFile

  reset(myFile); // ��������� ���� �� ������

  // ������ ���� � ������:
  tmp:= 0;
  while not Eof(myFile) do // ��������� ���� ������ ����� �� �����
    begin
      readln(myFile, tmp); // ��������� ����� �� ��������� ���������
      uk:= InsertKey(uk, tmp);  // � ��������� �� � ������
    end;
  close(myFile); // ��������� ����, ����������� �������

  Write('   '); Write('�������� ������ (������ ����� �����): ');
  FrontOrderLeft(uk); // ������� �� ������� ������ ����� ������� ��, ��� ����������, ���� ������
  Writeln;

  Write('   '); WriteLn('���������: ');
  Writeln;
  PrintLeftTree(uk); // ������ ����������������� ������

  // ���� � ������� ������ ��������� ������� �� ��������
  uk:= FindMiddleAndRightRemove(uk);
  Writeln;

  // FrontOrderLeft(uk);  Writeln;
  Write('   '); Write('����� ������ (������ ����� �����): ');
  FrontOrderLeft(uk); // ������� �� ������� ������ ����� ������� ��, ��� ����������, ���� ������
  Writeln;

  Write('   '); WriteLn('���������: ');
  Writeln;
  PrintLeftTree(uk); // ������ ����������������� ������

  Readln;
end.
