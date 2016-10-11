// Модуль реализации деревьев
unit MyTree;

interface  // Раздел описаний

// Описание типа - структура бинарного дерева на указателях:
// Представление в виде списковой структуры:
type
  tree_ptr = ^ tree_node;
  tree_node = record
     key: Integer;    // Ключ узла
     height: Integer; // Высота узла
     //info: string;  // Информационное поле, пока не используется
     //element: Real; // Вещественное значение, пока не используется
     left: tree_ptr; // Левый потомок (указатель)
     right: tree_ptr; // Правый потомок (указатель)
  end;

procedure FrontOrderLeft(v: tree_ptr);  // 1) Процедура прямого левого обхода с выводом на консоль
procedure FrontOrderRight(v: tree_ptr); // 2) Процедура прямого правого обхода с выводом на консоль
procedure BackOrderLeft(v: tree_ptr);   // 3) Процедура обратного левого обхода с выводом на консоль
procedure BackOrderRight(v: tree_ptr);  // 4) Процедура обратного правого обхода с выводом на консоль
procedure InnerOrderLeft(v: tree_ptr);  // 5) Процедура левого внутреннего обхода с выводом на консоль
procedure InnerOrderRight(v: tree_ptr); // 6) Процедура правого внутреннего обхода с выводом на консоль
//
function BuildBalancedTree(n: Integer): tree_ptr;
function MassiveToBalancedTree(arr: array of Integer): tree_ptr;
//
procedure PrintTree(t: tree_ptr; h: Integer); // 9) Процедура печати дерева с h отступами
function HeightNode(t: tree_ptr): Integer;    // 10) Функция возврата высоты узла
function BalanceFactorNode(p: tree_ptr): Integer; // 11) Процедура для вычисляния balance factor заданного узла
procedure FixHeight(p: tree_ptr); // 12) Процедура восстановления корректного значения поля height
function RotateRight(p: tree_ptr): tree_ptr; // 13) Правый поворот вокруг p
function RotateLeft(q: tree_ptr): tree_ptr; // 14) Левый поворот вокруг p
function BalanceNode(p: tree_ptr): tree_ptr; // 15) Функция балансировки при дисбалансе
function InsertKey(p: tree_ptr; k: Integer): tree_ptr; // 16) Функция вставки ключа k в дерево с корнем p
//
function FindMinNode(p: tree_ptr): tree_ptr;  // 17) Вспомогательная функция поиска узла с минимальным ключем в дереве p
function RemoveMinNode(p: tree_ptr): tree_ptr; // 18) Cлужебная функция для удаления минимального элемента из заданного дерева:
function RemoveKey(p: tree_ptr; k: Integer): tree_ptr; // 19) Собственно, сама функция удаления элемента по его ключу // удаление ключа k из дерева p
//
function ParentCount(v: tree_ptr): Integer; // 20) Рекурсивная функция подсчета количества наследников у узла
function SumLR(v: tree_ptr): Integer; // 21) Функция поиска и суммирования ключей
function CountLR(v: tree_ptr): Integer; // 22) Функция поиска и суммирования количества узлов

var i: Integer;
    massiv: array of Integer;
    

implementation
// ---- Раздел реализаций ---

// -----------------------------------------------------------------------------
// ПРЯМОЙ ОБХОД
// Прямой порядок обхода (FrontOrder, DirectOrder, TopDownOrder, сверху вниз)
// заключается в том, что корень некоторого дерева посещается раньше,
// чем его поддеревья. Если после корня посещается его левое (правое)
// поддерево, то обход называется прямым левым (правым) обходом.

// 1) Процедура прямого левого обхода с выводом на консоль
procedure FrontOrderLeft(v: tree_ptr);
begin
  if v <> nil then
  begin
    Write(v^.key, ' '); // Напечатать значение ключа
    FrontOrderLeft(v^.left);
    FrontOrderLeft(v^.right);
  end;
end;

// 2) Процедура прямого правого обхода с выводом на консоль
procedure FrontOrderRight(v: tree_ptr);
begin
  if v <> nil then
  begin
    Write(v^.key, ' '); // Напечатать значение ключа
    FrontOrderRight(v^.right);
    FrontOrderRight(v^.left);
  end;
end;

// -----------------------------------------------------------------------------
// ОБРАТНЫЙ ОБХОД
// Обратный порядок обхода (BackOrder, DownTopOrder, снизу вверх)
// заключается в том, что корень дерева посещается после его поддеревьев.
// Если сначала посещается левое (правое) поддерево корня,
// то обход называется обратным левым (правым) обходом.

// 3) Процедура обратного левого обхода с выводом на консоль
procedure BackOrderLeft(v: tree_ptr);
begin
  if v <> nil then
  begin
    BackOrderLeft(v^.left);
    BackOrderLeft(v^.right);
    Write(v^.key, ' '); // Напечатать значение ключа
  end;
end;

// 4) Процедура обратного правого обхода с выводом на консоль
procedure BackOrderRight(v: tree_ptr);
begin
  if v <> nil then
  begin
    BackOrderRight(v^.right);
    BackOrderRight(v^.left);
    Write(v^.key, ' '); // Напечатать значение ключа
  end;
end;

// -----------------------------------------------------------------------------
// ВНУТРЕННИЙ ОБХОД
// Внутренний порядок обхода (InnnerOrder, слева направо или справа налево)
// заключается в том, что корень посещается после посещения одного из его
// поддеревьев. Если корень посещается после посещения его левого (правого)
// поддерева, то обход называется внутренним левым (правым) обходом. Заметим,
// что внутренний левый (правый) обход посещает вершины дерева в порядке
// возрастания (убывания) ключей вершин.

// 5) Процедура левого внутреннего обхода с выводом на консоль
procedure InnerOrderLeft(v: tree_ptr);
begin 
  if v <> nil then
  begin
    InnerOrderLeft(v^.left);
    Write(v^.key, ' '); // Напечатать значение ключа
    InnerOrderLeft(v^.right);
  end;
end;

// 6) Процедура правого внутреннего обхода с выводом на консоль
procedure InnerOrderRight(v: tree_ptr);
begin
  if v <> nil then
  begin
    InnerOrderRight(v^.right);
    Write(v^.key, ' ');
    InnerOrderRight(v^.left);
  end;
end;

// -----------------------------------------------------------------------------
// ИДЕАЛЬНО СБАЛАНСИРОВАННОЕ ДЕРЕВО (пробное)
// 7) Функция формирования идеально сбалансированного дерева
// передаем массив, пробегая по которому, будет строится дерево
function BuildBalancedTree(n: Integer): tree_ptr;
var p: tree_ptr;
    x, nl, nr: Integer;
begin
  if n = 0 then p:= nil
  else
  begin
    nl:= n div 2;
    nr:= n - (nl + 1);
    New(p);
    p^.key:= massiv[i];
    Inc(i);
    p^.left:= BuildBalancedTree(nl);
    p^.right:= BuildBalancedTree(nr); //
  end;
  BuildBalancedTree:= p;
end;

// 8) Функция передачи массива для формирования идеально сбалансированного дерева
function MassiveToBalancedTree(arr: array of Integer): tree_ptr;
begin
  SetLength(massiv, Length(arr));  // Установка длины одномерного массива
  for i:=0 to Length(arr)-1 do massiv[i]:= arr[i];
  i:=0;
  MassiveToBalancedTree:= BuildBalancedTree(Length(massiv));
end;

// -----------------------------------------------------------------------------
// ВСПОМОГАТЕЛЬНЫЕ ФУНКЦИИ
// (придуманы в 1962 году советскими учеными Адельсон-Вельским и Ландисом)

// 9) Процедура печати дерева с h отступами
procedure PrintTree(t: tree_ptr; h: Integer);
var j: Integer;
begin
  if t <> nil then
  begin
    PrintTree(t^.left, h+1);
    for j:= 0 to h do Write(#9); // Знак табуляции
    Writeln(t^.key);
    Writeln;
    PrintTree(t^.right, h+1);
  end;
end;


// -----------------------------------------------------------------------------
// ФУНКЦИИ ДЛЯ РЕАЛИЗАЦИИ АВЛ-ДЕРЕВЬЕВ, ВСТАВКА ЭЛЕМЕНТА
// (придуманы в 1962 году советскими учеными Адельсон-Вельским и Ландисом)

// 10) Функция возврата высоты узла:
function HeightNode(t: tree_ptr): Integer;
begin
  if t <> nil then
  HeightNode:= t^.height
  else HeightNode:= 0;
end;

// 11) Процедура для вычисляния balance factor заданного узла (работает только с ненулевыми указателями):
function BalanceFactorNode(p: tree_ptr): Integer;
begin
  BalanceFactorNode:= HeightNode(p^.right) - HeightNode(p^.left);
end;

// 12) Процедура восстановления корректного значения поля height заданного узла
//(при условии, что значения этого поля в правом и левом дочерних узлах являются
// корректными):
procedure FixHeight(p: tree_ptr);
var hL, hR: Integer;
begin
  hL:= HeightNode(p^.left);
  hR:= HeightNode(p^.right);
  if hL > hR then p^.height:= hL + 1
  else p^.height:= hR + 1;
end;

// Балансировка узлов
// В процессе добавления или удаления узлов в АВЛ-дереве возможно возникновение
// ситуации, когда balance factor некоторых узлов оказывается равными 2 или -2,
// т.е. возникает расбалансировка поддерева. Для выправления ситуации
// применяются хорошо известные повороты вокруг тех или иных узлов дерева.

// 13) Правый поворот вокруг p:
function RotateRight(p: tree_ptr): tree_ptr;
var q: tree_ptr;
begin
  q:= p^.left;
  p^.left:= q^.right;
  q^.right:= p;
  FixHeight(p);
  FixHeight(q);
  RotateRight:= q;
end;

// 14) Левый поворот вокруг p:
function RotateLeft(q: tree_ptr): tree_ptr;
var p: tree_ptr;
begin
  p:= q^.right;
  q^.right:= p^.left;
  p^.left:= q;
  FixHeight(q);
  FixHeight(p);
  RotateLeft:= p;
end;

// 15) Функция балансировки при дисбалансе:
function BalanceNode(p: tree_ptr): tree_ptr; // Балансировка узла p
begin
  FixHeight(p);
  if BalanceFactorNode(p) = 2 then
  begin
    if BalanceFactorNode(p^.right) < 0 then p^.right:= RotateRight(p^.right);
    Result:= RotateLeft(p);
  end
  else
  if BalanceFactorNode(p) = -2 then
  begin
    if BalanceFactorNode(p^.left) > 0 then
    p^.left:= RotateLeft(p^.left);
    Result:= RotateRight(p);
  end
  else BalanceNode:= p; // Балансировка не нужна
end;

// 16) Функция вставки ключа k в дерево с корнем p:
function InsertKey(p: tree_ptr; k: Integer): tree_ptr;
begin
  if p = nil then
  begin
    New(p);
    p^.key:= k;
    p^.height:=0;
    p^.left:= nil;
    p^.right:= nil;
    result:= p;
  end
  else
  begin
    if k < p^.key then p^.left:= InsertKey(p^.left, k)
    else p^.right:= InsertKey(p^.right, k);
    Result:= BalanceNode(p);
  end;
end;

// -----------------------------------------------------------------------------
// ФУНКЦИИ ДЛЯ РЕАЛИЗАЦИИ АВЛ-ДЕРЕВЬЕВ, УДАЛЕНИЕ ЭЛЕМЕНТА

// 17) Вспомогательная функция поиска узла с минимальным ключем в дереве p
function FindMinNode(p: tree_ptr): tree_ptr;
begin
  if p^.left <> nil then Result:= FindMinNode(p^.left)
  else Result:= p;
end;  

// 18) Cлужебная функция для удаления минимального элемента из заданного дерева:
function RemoveMinNode(p: tree_ptr): tree_ptr;
begin
  if (p^.left = nil) then Result:= p^.right
  else
  begin
    p^.left:= RemoveMinNode(p^.left);
    Result:= BalanceNode(p);
  end;
end;  

// 19) Собственно, сама функция удаления элемента по его ключу:
function RemoveKey(p: tree_ptr; k: Integer): tree_ptr; // удаление ключа k из дерева p
var q, r, min: tree_ptr;
begin
  if p = nil then Result:= nil
  else
  begin
    if k < p^.key then p^.left:= RemoveKey(p^.left, k)
    else
      if k > p^.key then p^.right:= RemoveKey(p^.right, k)
      else  // Нашли ключ, т.е. k = p^.key
        begin
          // Writeln(p^.key); // 11 Для отладки
          q:= p^.left; // Запомнили левое поддерево   // 10
          r:=p^.right; // Запомнили правое поддерево  // 13
          if r = nil then p:= q   // Если правого поддререва нет, просто переносим на место строго узла новый
          else
          begin
            min:= FindMinNode(r); // иначе ищем минимальный элемент в правом поддереве и запоминаем его
            // Writeln(min^.key); // 12 Для отладки
            min^.right:= RemoveMinNode(r); // Перенесли в правой поддерево 12 элемента элемент 13 и всю его цепочку
            // Writeln((min^.right)^.key);  // Для отладки
            min^.left:= q;
            p:= min; // Вот этого не было
            Result:= BalanceNode(min);
          end;  
        end;  
  end;
  // И если не пустой указатель, то балансируем узел, или просто возвращаем nil
  if p <> nil then Result:= BalanceNode(p)
  else Result:= nil;
end;  


// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// ФУНКЦИИ ДЛЯ СОБСТВЕННО РЕШЕНИЯ ЗАДАЧИ

// 20) Рекурсивная функция подсчета количества наследников у узла
function ParentCount(v: tree_ptr): Integer;
begin
  if v <> nil then
  Result:= 1 + ParentCount(v^.left) + ParentCount(v^.right)
  else Result:= 0;
end;

// 21) Функция поиска и суммирования ключей тех узлов, у которых количество
// потомков в левом поддереве отличается от количества потомков в правом
// поддереве на 1
function SumLR(v: tree_ptr): Integer;
begin
  if v <> nil then
  begin
    if Abs( ParentCount(v^.left) - ParentCount(v^.right) ) = 1 then
    begin
      Write(v^.key, ' '); // Напечатать значение ключа
      Result:= v^.key + SumLR(v^.left) + SumLR(v^.right);  
    end
    else Result:= SumLR(v^.left) + SumLR(v^.right);
  end
  else Result:=0;
end;

// 22) Функция поиска и суммирования количества узлов, у которых количество
// потомков в левом поддереве отличается от количества потомков в правом
// поддереве на 1
function CountLR(v: tree_ptr): Integer;
begin
  if v <> nil then
  begin
    if Abs( ParentCount(v^.left) - ParentCount(v^.right) ) = 1 then
    begin
      Result:= 1 + CountLR(v^.left) + CountLR(v^.right);
    end
    else Result:= CountLR(v^.left) + CountLR(v^.right);
  end
  else Result:=0;
end;



end.
