// ������ ���������� ������ ��������
unit MySimpleTree;

interface  // ������ ��������

uses SysUtils,
    MySimpleSort;  // ���������� ������ � ����������� ����������
    
// �������� ���� - ��������� ��������� ������ �� ����������:
// ������������� � ���� ��������� ���������:
type
  tree_ptr = ^ tree_node;
  tree_node = record
     key: Integer;    // ���� ����
     height: Integer; // ������ ���� (���������� � ����� �� ���� �� �������� ���������� �������)
     depth: Integer; // ������� ���� (���������� � ����� �� ����� �� ����)
     weight: Integer; // �������� �����-������ ������������ ��������� �������� (�� �����������)
     //info: string;  // �������������� ����, ���� �� ������������
     //element: Real; // ������������ ��������, ���� �� ������������
     left: tree_ptr; // ����� ������� (���������)
     right: tree_ptr; // ������ ������� (���������)
  end;

type
  Mass = array of Integer;

procedure FrontOrderLeft(v: tree_ptr);  // 1) ��������� ������� ������ ������ � ������� �� �������
procedure FrontOrderLeftPosition(v: tree_ptr);
procedure FrontOrderRight(v: tree_ptr); // 2) ��������� ������� ������� ������ � ������� �� �������
procedure BackOrderLeft(v: tree_ptr);   // 3) ��������� ��������� ������ ������ � ������� �� �������
procedure BackOrderRight(v: tree_ptr);  // 4) ��������� ��������� ������� ������ � ������� �� �������
procedure InnerOrderLeft(v: tree_ptr);  // 5) ��������� ������ ����������� ������ � ������� �� �������
procedure InnerOrderRight(v: tree_ptr); // 6) ��������� ������� ����������� ������ � ������� �� �������

//
procedure PrintTree(t: tree_ptr; h: Integer); // 9) ��������� ������ ������ � h ���������
function HeightNode(t: tree_ptr): Integer;    // 10) ������� �������� ������ ����
function BalanceFactorNode(p: tree_ptr): Integer; // 11) ��������� ��� ���������� balance factor ��������� ����
procedure FixHeight(p: tree_ptr); // 12) ��������� �������������� ����������� �������� ���� height
//procedure FixDepthNode(p: tree_ptr; rootHeight: Integer); // 13) ��������� �������������� ����������� �������� ���� depth ��������� ����
//procedure FixDepthTree(p: tree_ptr); // 14) ��������� �������������� ����������� �������� ���� depth ���� �����



// 16) ������� ������� ����� k � ������ � ������ p:
function InsertKey(p: tree_ptr; k: Integer): tree_ptr;
// 16) ������� ������� ����� k � ������ � ������ p:
procedure BalancedDepth(v: tree_ptr; d: Integer; w: Integer);
//
// 17) ��������������� ������� ������ ���� � ����������� ������ � ������ p
function FindMinNode(p: tree_ptr): tree_ptr;
// 17) ��������������� ������� ������ ���� � ����������� ������ � ������ p
function FindMaxNode(p: tree_ptr): tree_ptr;
// 16) ��������� ���������� ������ ������
procedure NormPrintTree(p: tree_ptr);
// 1) ��������� ������� ������ ������ � ������� �� �������
procedure FrontOrderLeftToMatrix(v: tree_ptr);

//
function RemoveMinNode(p: tree_ptr): tree_ptr; // 18) C�������� ������� ��� �������� ������������ �������� �� ��������� ������:
function RemoveKey(p: tree_ptr; k: Integer): tree_ptr; // 19) ����������, ���� ������� �������� �������� �� ��� ����� // �������� ����� k �� ������ p
//
function ParentCount(v: tree_ptr): Integer;
procedure CopyLR(v: tree_ptr; var arr : Mass);
function CopyLRtoMassiv(v: tree_ptr): Mass;
function CountLR(v: tree_ptr): Integer;
procedure LR(v: tree_ptr);
procedure PrintArr(arr: Mass);

var i: Integer;
    massiv: array of Integer;
    masPlot: array of Char;
    msv: array of array of String;  // ������������ ��������� ������ �� �����
    

implementation
// ---- ������ ���������� ---

// -----------------------------------------------------------------------------
// ������ �����
// ������ ������� ������ (FrontOrder, DirectOrder, TopDownOrder, ������ ����)
// ����������� � ���, ��� ������ ���������� ������ ���������� ������,
// ��� ��� ����������. ���� ����� ����� ���������� ��� ����� (������)
// ���������, �� ����� ���������� ������ ����� (������) �������.

// 1) ��������� ������� ������ ������ � ������� �� �������
procedure FrontOrderLeft(v: tree_ptr);
begin
  if v <> nil then
  begin
    Write(v^.key, ' '); // ���������� �������� �����
    FrontOrderLeft(v^.left);
    FrontOrderLeft(v^.right);
  end;
end;
// 1.1) ��������� ������� ������ ������ � ������� �� ������� (� ������� �������)
procedure FrontOrderLeftPosition(v: tree_ptr);
begin
  if v <> nil then
  begin
    Write(v^.key, '[', v^.weight, ',', v^.depth, '] '); // ���������� �������� �����
    FrontOrderLeftPosition(v^.left);
    FrontOrderLeftPosition(v^.right);
  end;
end;

// 2) ��������� ������� ������� ������ � ������� �� �������
procedure FrontOrderRight(v: tree_ptr);
begin
  if v <> nil then
  begin
    Write(v^.key, ' '); // ���������� �������� �����
    FrontOrderRight(v^.right);
    FrontOrderRight(v^.left);
  end;
end;

// -----------------------------------------------------------------------------
// �������� �����
// �������� ������� ������ (BackOrder, DownTopOrder, ����� �����)
// ����������� � ���, ��� ������ ������ ���������� ����� ��� �����������.
// ���� ������� ���������� ����� (������) ��������� �����,
// �� ����� ���������� �������� ����� (������) �������.

// 3) ��������� ��������� ������ ������ � ������� �� �������
procedure BackOrderLeft(v: tree_ptr);
begin
  if v <> nil then
  begin
    BackOrderLeft(v^.left);
    BackOrderLeft(v^.right);
    Write(v^.key, ' '); // ���������� �������� �����
  end;
end;

// 4) ��������� ��������� ������� ������ � ������� �� �������
procedure BackOrderRight(v: tree_ptr);
begin
  if v <> nil then
  begin
    BackOrderRight(v^.right);
    BackOrderRight(v^.left);
    Write(v^.key, ' '); // ���������� �������� �����
  end;
end;

// -----------------------------------------------------------------------------
// ���������� �����
// ���������� ������� ������ (InnnerOrder, ����� ������� ��� ������ ������)
// ����������� � ���, ��� ������ ���������� ����� ��������� ������ �� ���
// �����������. ���� ������ ���������� ����� ��������� ��� ������ (�������)
// ���������, �� ����� ���������� ���������� ����� (������) �������. �������,
// ��� ���������� ����� (������) ����� �������� ������� ������ � �������
// ����������� (��������) ������ ������.

// 5) ��������� ������ ����������� ������ � ������� �� �������
procedure InnerOrderLeft(v: tree_ptr);
begin 
  if v <> nil then
  begin
    InnerOrderLeft(v^.left);
    Write(v^.key, ' '); // ���������� �������� �����
    InnerOrderLeft(v^.right);
  end;
end;

// 6) ��������� ������� ����������� ������ � ������� �� �������
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
// ��������������� �������
// (��������� � 1962 ���� ���������� ������� ��������-�������� � ��������)

// 9) ��������� ������ ������ � h ���������
procedure PrintTree(t: tree_ptr; h: Integer);
var j: Integer;
begin
  if t <> nil then
  begin
    PrintTree(t^.left, h+1);
    for j:= 0 to h do Write(#9); // ���� ���������
    Writeln(t^.key);
    Writeln;
    PrintTree(t^.right, h+1);
  end;
end;




// -----------------------------------------------------------------------------
// ������� ��� ���������� ���-��������, ������� ��������
// (��������� � 1962 ���� ���������� ������� ��������-�������� � ��������)

// 10) ������� �������� ������ ����:
function HeightNode(t: tree_ptr): Integer;
begin
  if t <> nil then
  HeightNode:= t^.height
  else HeightNode:= 0;
end;

// 11) ��������� ��� ���������� balance factor ��������� ���� (�������� ������ � ���������� �����������):
function BalanceFactorNode(p: tree_ptr): Integer;
begin
  BalanceFactorNode:= HeightNode(p^.right) - HeightNode(p^.left);
end;

// 12) ��������� �������������� ����������� �������� ���� height ��������� ����
//(��� �������, ��� �������� ����� ���� � ������ � ����� �������� ����� ��������
// �����������):
procedure FixHeight(p: tree_ptr);
var hL, hR: Integer;
begin
  hL:= HeightNode(p^.left);
  hR:= HeightNode(p^.right);
  if hL > hR then p^.height:= hL + 1
  else p^.height:= hR + 1;
end;
//// 13) ��������� �������������� ����������� �������� ���� depth ��������� ����
//procedure FixDepthNode(p: tree_ptr; rootHeight: Integer);
//begin
//  if p <> nil then
//  begin
//    p^.depth:= rootHeight - p^.height; //
//    FixDepthNode(p^.left, rootHeight);
//    FixDepthNode(p^.right, rootHeight);
//  end;
//end;
//// 14) ��������� �������������� ����������� �������� ���� depth ���� �����
//procedure FixDepthTree(p: tree_ptr);
//begin
//  FixDepthNode(p, p^.height);
//end;  

// ������������ �����
// � �������� ���������� ��� �������� ����� � ���-������ �������� �������������
// ��������, ����� balance factor ��������� ����� ����������� ������� 2 ��� -2,
// �.�. ��������� ��������������� ���������. ��� ����������� ��������
// ����������� ������ ��������� �������� ������ ��� ��� ���� ����� ������.

// 16) ������� ������� ����� k � ������ � ������ p:
function InsertKey(p: tree_ptr; k: Integer): tree_ptr;
begin
  if p = nil then
  begin
    New(p);
    p^.key:= k;
    p^.height:=0;
    p^.depth:= 0;
    p^.weight:= 0;
    p^.left:= nil;
    p^.right:= nil;
    BalancedDepth(p, 0, 0);
    Result:= p;
  end
  else
  begin
    if k < p^.key then p^.left:= InsertKey(p^.left, k)
    else p^.right:= InsertKey(p^.right, k);
    BalancedDepth(p, 0, 0);
    // Result:= BalanceNode(p);
    Result:= p;
  end;
end;

// 16) ������� ��������� ������� �����:
procedure BalancedDepth(v: tree_ptr; d: Integer; w: Integer);
begin
  if v <> nil then
  begin
    v.depth:= d;
    v.weight:= w;
  end;
  if v^.left <> nil then
  begin
    BalancedDepth(v^.left, d+1, w-1);
  end;
  if v^.right <> nil then
  begin
    BalancedDepth(v^.right, d+1, w+1);
  end;
end;

// 17) ��������������� ������� ������ ���� � ����������� ������ � ������ p
function FindMinNode(p: tree_ptr): tree_ptr;
begin
  if p^.left <> nil then Result:= FindMinNode(p^.left)
  else Result:= p;
end;

// 17) ��������������� ������� ������ ���� � ����������� ������ � ������ p
function FindMaxNode(p: tree_ptr): tree_ptr;
begin
  if p^.right <> nil then Result:= FindMaxNode(p^.right)
  else Result:= p;
end;

// 16) ��������� ���������� ������ ������
procedure NormPrintTree(p: tree_ptr);
var sizeX, sizeY: Integer; // ������� �������
    i, j, z: Integer;
begin
  if p <> nil then
  begin
    if p^.left <> nil then
    begin
      NormPrintTree(p^.left);
    end
    else
    begin
      write(p^.key);
    end;

    if p^.right <> nil then
    begin
      write('  ');
      NormPrintTree(p^.right);
    end
    else
    begin
      write('  ');
      Writeln(p^.key);
    end; 

  end;
end;  


// 1) ��������� ������� ������ ������ � ���������� � ������
procedure FrontOrderLeftToMatrix(v: tree_ptr);
begin
  if v <> nil then
  begin
    //Writeln((v^.depth));
    msv[v^.depth, v^.weight + Length(msv) - 1]:= IntToStr(v^.key);
    //Write(msv[(v^.weight + Length(msv)), (v^.depth)], ' '); // ���������� �������� �����
    FrontOrderLeftToMatrix(v^.left);
    FrontOrderLeftToMatrix(v^.right);
  end;
end;



// -----------------------------------------------------------------------------
// ������� ��� ���������� ��������, �������� ��������



// 18) C�������� ������� ��� �������� ������������ �������� �� ��������� ������:
function RemoveMinNode(p: tree_ptr): tree_ptr;
begin
  if (p^.left = nil) then Result:= p^.right
  else
  begin
    p^.left:= RemoveMinNode(p^.left);
    // Result:= BalanceNode(p);
    Result:= p;
  end;
end;  

// 19) ����������, ���� ������� �������� �������� �� ��� �����:
function RemoveKey(p: tree_ptr; k: Integer): tree_ptr; // �������� ����� k �� ������ p
var q, r, min: tree_ptr;
begin
  if p = nil then Result:= nil
  else
  begin
    if k < p^.key then p^.left:= RemoveKey(p^.left, k)
    else
      if k > p^.key then p^.right:= RemoveKey(p^.right, k)
      else  // ����� ����, �.�. k = p^.key
        begin
          // Writeln(p^.key); // 11 ��� �������
          q:= p^.left; // ��������� ����� ���������   // 10
          r:=p^.right; // ��������� ������ ���������  // 13
          if r = nil then p:= q   // ���� ������� ���������� ���, ������ ��������� �� ����� ������ ���� �����
          else
          begin
            min:= FindMinNode(r); // ����� ���� ����������� ������� � ������ ��������� � ���������� ���
            // Writeln(min^.key); // 12 ��� �������
            min^.right:= RemoveMinNode(r); // ��������� � ������ ��������� 12 �������� ������� 13 � ��� ��� �������
            // Writeln((min^.right)^.key);  // ��� �������
            min^.left:= q;
            p:= min; // ��� ����� �� ����
            Result:= p; //BalanceNode(min);
          end;  
        end;  
  end;
  // � ���� �� ������ ���������, �� ����������� ����, ��� ������ ���������� nil
  if p <> nil then Result:= p //BalanceNode(p)
  else Result:= nil;
end;  


// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// -----------------------------------------------------------------------------
// ������� ��� ���������� ������� ������

// 20) ����������� ������� �������� ���������� ����������� � ����
function ParentCount(v: tree_ptr): Integer;
begin
  if v <> nil then
  Result:= 1 + ParentCount(v^.left) + ParentCount(v^.right)
  else Result:= 0;
end;

// 21) ��������� ������ � ����������� � ������ ������ ��� �����, � ������� ����������
// �������� � ����� ��������� ���������� �� ���������� �������� � ������
// ��������� �� 1
// �������� ��������� �� ������, ������ �� ������ � ����� ��������
procedure CopyLR(v: tree_ptr; var arr : Mass);
begin
  if v <> nil then
  begin
    if Abs( ParentCount(v^.left) - ParentCount(v^.right) ) = 1 then
    begin
      i:= i + 1;
      arr[i]:= v^.key; // ����������� �������� �����
      // Writeln(arr[i]);
    end;
    CopyLR(v^.left, arr);
    CopyLR(v^.right, arr);
  end;
end;

// ������� ����������� � ������
function CopyLRtoMassiv(v: tree_ptr): Mass;
var size : Integer;
    arr : Mass;
begin
  if v <> nil then
  begin
    // ���������� ���������� ���������, ����� �����, ������ ������� ������� ������:
    size:= CountLR(v);
    SetLength(arr, size);  // ���������� ����� ����������� �������
    i:= -1;
    CopyLR(v, arr); // ��������� ����������� ���������� �������� � ������
    Result:= arr;
  end
  else Result:= nil;
end;

// 22) ������� �������� ���������� �����, � ������� ����������
// �������� � ����� ��������� ���������� �� ���������� �������� � ������
// ��������� �� 1
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

// ��������� ���������� � �������� (������ ���������) ������� �� ��������
// ������� �� ������ ������, � ������� ���������� �������� � ����� ���������
// ���������� �� ���������� �������� � ������ ��������� �� 1

procedure LR(v: tree_ptr);
var arr: Mass;
    n: Integer; // ���������� ���������
    key: Integer; // ��������� ���� ������� �� �������� �������
begin
  // ���������� ���������� ���������� ���������:
  n:= CountLR(v);
  //Writeln(n);
  if n = 0 then
    Writeln('���������� ����� �� �������. ���������� ���������')
  else
  begin
    arr:= CopyLRtoMassiv(v); // ����� ��� ������, ��������� ��� ���������� �������� � ������
    QuickSortNonRecursive(arr); // ��������� ������
    PrintArr(arr); // �������� ��� �������� �������

    if (n mod 2) = 0 then
    begin
      Writeln('���������� ��������� ������ ���������� (', n, ')');
      Writeln('��� ������� ����� ��������� �����. ���������� ���������');
    end
    else
    begin
      Writeln('���������� ��������� �������� ���������� (', n, ')');
      Writeln('������� �� �������� �������: ', arr[(n mod 2)]);



      
    end;
  end;
end;

procedure PrintArr(arr: Mass);
var j: Integer;
begin
  write('���������� ��������: ');
  for j:= 0 to Length(arr)-1 do
  begin
    write(arr[j], ' ');
  end;
  Writeln;
end;



end.
