program Project2;

{$APPTYPE CONSOLE}

uses
  EsConsole in 'EsConsole.pas', // Подключаем модуль русификации консоли
  // SysUtils, // уже не нужен, есть EsConsole для этих целей
  MyTree in 'MySimpleTree.pas'; // Модуль реализации простейшего дерева и функций работы с ним

var myFile: Text; // Объявляем переменную типа Text для асоцииации с  текстовым файлом
    tmp: Integer;

    uk: tree_ptr;
    sum, count, srednee: Integer;

begin
  // Выводим информацию по задаче:
  Writeln('| ------------------------------------------------------- |');
  Writeln('| Бедарев А.А., ПММ, 2 курс, 1 семестр. Задание 2, Вар. 3 |');
  Writeln('| Найти и удалить (правым удалением) среднюю по значению  |');
  Writeln('| вершину из вершин дерева, у которых количество потомков |');
  Writeln('| в левом поддереве отличается от количества потомков в   |');
  Writeln('| правом поддереве на 1. Выполнить прямой (левый) обход   |');
  Writeln('| полученного дерева.                                     |');
  Writeln('| ------------------------------------------------------- |');
  Writeln;

  assign(myFile, 'in.txt'); // Связываем файл с переменной myFile

  reset(myFile); // Открываем файл на чтение

  // Читаем файл в массив:
  tmp:= 0;
  while not Eof(myFile) do // Запускаем цикл чтения чисел из файла
    begin
      readln(myFile, tmp); // Считываем число во временную перемнную
      uk:= InsertKey(uk, tmp);  // и добавляем ее в дерево
    end;
  close(myFile); // Закрываем файл, освобождаем ресурсы

  Write('-> '); Writeln('Исходное дерево (прямой левый обход):');
  Write('   '); FrontOrderLeftPosition(uk);  Writeln; // Выводим на консоль прямым левым обходом то, что получилось, наше дерево

  //
  Writeln;
  Write('-> '); Write('Подходящие вершины: '); sum:= SumLR(uk);
  Writeln;
  Write('-> '); Writeln('Сумма подходящих ключей = ', sum);
  Write('-> '); Write('Количество ключей = '); count:= CountLR(uk); Writeln(count);
  Write('-> '); Write('Удаляемая вершина (среднее значение) = '); srednee:= sum div count; Writeln(srednee);
  Writeln;
  NormPrintTree(uk);

  // FrontOrderLeft(uk);  Writeln;

  ////uk:= RemoveKey(uk, srednee); // Удаляем ненужный элемент
  ////Write('-> '); Writeln('Дерево после удаления элемента (прямой левый обход):');
  ////Write('   '); FrontOrderLeftPosition(uk);  Writeln;


  // uk:= RemoveKey(uk, 1);
  // FrontOrderLeft(uk);  Writeln;


  // PrintTree(uk, 0); // Печать пространственного дерева

  Readln;
end.
