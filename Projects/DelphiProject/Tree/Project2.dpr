program Project2;

{$APPTYPE CONSOLE}

uses
  SysUtils,
  MyTree in 'MyTree.pas';

var arr: array of Integer;
    var myFile: Text; // Объявляем переменную типа Text для асоцииации с  текстовым файлом
    i: Integer;

    uk: tree_ptr;

    sum, count, srednee: Integer;

begin
  { TODO -oUser -cConsole Main : Insert code here }
  SetLength(arr, 21);  // Установка длины одномерного массива
  assign(myFile, 'in.txt'); // Связываем файл с переменной myFile
  reset(myFile); // Открываем файл на чтение

  // Читаем файл в массив:
  i:= 0;
  while not Eof(myFile) do // Запускаем цикл чтения чисел из файла
    begin
      readln(myFile, arr[i]); // Считываем число в массив
      Inc(i);
    end;
  close(myFile); // Закрываем файл, освобождаем ресурсы

  // И переносим массив в сбалансированное дерево (по Вирту)
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


  // PrintTree(uk, 0); // Печать дерева

  Readln;
end.
