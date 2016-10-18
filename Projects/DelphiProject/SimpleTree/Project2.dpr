program Project2;

{$APPTYPE CONSOLE}

uses
  EsConsole in 'EsConsole.pas', // ���������� ������ ����������� �������
  // SysUtils, // ��� �� �����, ���� EsConsole ��� ���� �����
  MyTree in 'MySimpleTree.pas'; // ������ ���������� ����������� ������ � ������� ������ � ���

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

  assign(myFile, 'in.txt'); // ��������� ���� � ���������� myFile

  reset(myFile); // ��������� ���� �� ������

  // ������ ���� � ������:
  tmp:= 0;
  while not Eof(myFile) do // ��������� ���� ������ ����� �� �����
    begin
      readln(myFile, tmp); // ��������� ����� �� ��������� ���������
      uk:= InsertKey(uk, tmp);  // � ��������� �� � ������
    end;
  close(myFile); // ��������� ����, ����������� �������

  Write('-> '); Writeln('�������� ������ (������ ����� �����):');
  Write('   '); FrontOrderLeftPosition(uk);  Writeln; // ������� �� ������� ������ ����� ������� ��, ��� ����������, ���� ������

  //
  Writeln;
  Write('-> '); Write('���������� �������: '); sum:= SumLR(uk);
  Writeln;
  Write('-> '); Writeln('����� ���������� ������ = ', sum);
  Write('-> '); Write('���������� ������ = '); count:= CountLR(uk); Writeln(count);
  Write('-> '); Write('��������� ������� (������� ��������) = '); srednee:= sum div count; Writeln(srednee);
  Writeln;
  NormPrintTree(uk);

  // FrontOrderLeft(uk);  Writeln;

  ////uk:= RemoveKey(uk, srednee); // ������� �������� �������
  ////Write('-> '); Writeln('������ ����� �������� �������� (������ ����� �����):');
  ////Write('   '); FrontOrderLeftPosition(uk);  Writeln;


  // uk:= RemoveKey(uk, 1);
  // FrontOrderLeft(uk);  Writeln;


  // PrintTree(uk, 0); // ������ ����������������� ������

  Readln;
end.
