#include <iostream>
#include <cstdlib>
#include <ctime>

using namespace std;

// ����� ���������� ������� ���������:
int insertionSort(int* arr, int ssize)
{
    int i, j;
    int tmp; //   ��������� ���������� ��� �������� ��������������� ��������
    // ��������� ���������� �������:
    for (i = 1; i < ssize; i++)
    {
        tmp = arr[i]; // ����������� ������� �������
        arr[0] = tmp; // ������������� �������� �� ������� �������
        j = i; // ���������� �����
        while(tmp < arr[j-1])
        {
            arr[j] = arr[j-1];
            --j; // ��� � ������
        }
        arr[j] = tmp; // �������� ������� ������� �� ���������� �����
    }
    return 0;
}

// ����� ���������� ������ ���������� ����������� ���������
int insertionSortBisection(int* arr, int ssize)
{
    int i, j;
    int M, L, R;
    int tmp; //   ��������� ���������� ��� �������� ��������������� ��������
    // ��������� ���������� �������:
    for (i = 1; i < ssize; i++)
    {
        tmp = arr[i]; // ����������� ������� �������
        L = 1;
        R = i;
        while(L < R){
            M = (L + R) / 2;
            if (arr[M] <= tmp) L = M + 1; // ����������� �������
            else R = M;
        }
        for (j = i; j >= R + 1; j--) arr[j] = arr[j-1]; // ����������� ��� �������� ������
        arr[R] = tmp; // ������������� �� ���������� ����� ������� �������
    }
    return 0;
}

// ����� ������� ���������� � ���������:
int ssort(int* arr, int L, int R)
{
	int i, j;
	int x, w;
	// ��������� ���������� �������:
	i = L; j = R;
	x = arr[(L + R) / 2];
	do{
		while (arr[i] < x) i++;
		while (x < arr[j]) j--;
		if (i <= j){
			w = arr[i]; arr[i] = arr[j]; arr[j] = w; i++; j--;
		}
	} while (i <= j);
	if (L < j) ssort(arr, L, j);
	if (i < R) ssort(arr, i, R);
	return 0;
}
int quickSort(int* arr, int size)
{
    ssort(arr, 1, size-1);
    return 0;
}




// ����� ������� ���������� ��� ��������:
int quickSortNonRecursive(int* arr, int ssize)
{
	int i, j;
	int L, R, s;
	int x, w;
	// ����������� �������� ������ ��� �������� ���� �������� ������� size:
	int *stackLow = new int[ssize]; // ���� ������ ��������
	int *stackHigh = new int[ssize]; // ���� ������� ��������

	// ��������� ���������� �������:
	s = 1; // ������� ������� �� �������������, �� ��� �������� � ������ �����������, � ��� ���� �� s = 0;
        stackLow[1] = 1; // � ��������� stackLow[0] = 0; - ������� �� ����������
        stackHigh[1] = ssize - 1; // � ��������� stackHigh[0] = size - 1; - ������� �� ����������
        do { // ����� ������� ������ �� �����
            L = stackLow[s]; R = stackHigh[s]; s = s - 1;
            do { // ��������� ������� arr[L] ... arr[R]
                i = L; j = R;
                x = arr[(L + R) / 2];
                do {
                    while (arr[i] < x) i = i + 1;
                    while (x < arr[j]) j = j - 1;
                    if (i <= j){
                        w = arr[i]; arr[i] = arr[j]; arr[j] = w; i = i + 1; j = j - 1;
                    }
                } while (i < j); // ��������� ���� ��������, � � ����� - �� ��� ���, ���� �� ������ ������� - ��� ���� i > j
                if (i < R){ // ��������� � ����� ����� �� ���������� ������ �����
                    s = s + 1; stackLow[s] = i; stackHigh[s] = R;
                }
                R = j;
            } while (L < R); // ������ L � R ������������ ����� �����
        } while (s > 0); // c while (s >= 0) �� ���������  while (s = -1)
	return 0;
}

// ����� ���������� ������ �������:
int selectionSort(int* arr, int ssize)
{
	int i, j, k;
	int tmp;
	// ��������� ���������� �������:
    for (i = 1; i < ssize - 1; i++){
        k = i;
        tmp = arr[i];
        for(j = i + 1; j < ssize; j++){
            if (arr[j] < tmp){
                k = j;
                tmp = arr[k];
            }
        }
        arr[k] = arr[i];
        arr[i] = tmp;
    }
	return 0;
}

// ����� ���������� ������� ������ (����������� ����������):
int bubbleSort(int* arr, int ssize)
{
    int i, j;
    int tmp;
    // ��������� ���������� �������:
    for (i = 2; i < ssize; i++){
        for (j = ssize - 1; j >= i; j--){
            if (arr[j-1] > arr[j]){
                tmp = arr[j-1];
                arr[j-1] = arr[j];
                arr[j] = tmp;
            }
        }
    }
	return 0;
}

// ����� ��������� ���������� (�������� �������� � �������� ������, ����������� ����������� ����������):
int shakerSort(int* arr, int ssize)
{
    int k, j, L, R;
    int tmp;

    // ��������� ���������� �������:
    L = 2;
    R = ssize - 1;
    k = ssize - 1;
    do{
        for (j = R; j >= L; j--){ // ������ ������ ������
            if (arr[j-1] > arr[j]){
                tmp = arr[j-1];
                arr[j-1] = arr[j];
                arr[j] = tmp;
                k = j;
            }
        }
        L = k + 1; // �������� ����� ������� ������
        for (j = L; j <= R; j++){ // ������ ����� �������
            if (arr[j-1] > arr[j]){
                tmp = arr[j-1];
                arr[j-1] = arr[j];
                arr[j] = tmp;
                k = j; // �������� �������
            }
        }
        R = k - 1; // �������� ������ ������� �����
    } while (L <= R);
	return 0;
}

int main()
{
    setlocale(LC_ALL, "rus");
    {/* // ������� ���� ��� ����� ������� �������
    cout << "Sortirovka Massiva" << endl;
    cout << "size = "; // ��������� ������ �������, ������� ���������� �������������
    int size;
    cin >> size;
    int *aa = new int[size]; // ����������� �������� ������ ��� �������� ������� ������� size
    for (int i = 0; i < size; i++) cin >> aa[i]; // ��������� ������
    sortDirectInclusion(aa, size);
    // ������� ��������������� ������
    for (int i = 0; i < size; i++) cout << aa[i] << ' ';
    return 0; */}

    // ������� ���� ��� ��������� ��������� �������
    cout << "���������� �������" << endl;
    cout << "������� ����� ���������: ";
    int asize;
    cin >> asize;
    asize = asize + 1;
    int *aa = new int[asize]; // ����������� �������� ������ ��� �������� ������� ������� size
    cout << "������� �������� ��������� (��������, 10 30): ";
    int start, endd;
    cin >> start;
    cin >> endd;
    // ��������� ��������� ��������� ����� ��� �������:
    aa[0] = 0; // ��������
    for (int i = 1; i < asize; i++)
	{
		aa[i] = start + rand() % (endd - start + 1);	// start ... end
	}
	 // ������� ��������������� ������
     //for (int i = 1; i < size; i++) cout << aa[i] << ' ';
     //cout << endl;

	// ������ ����� ������� ��� ������ ����������:
	int *a1 = new int[asize]; // ����������� �������� ������ ��� �������� ������� ������� size
	int *a2 = new int[asize];
	int *a3 = new int[asize];
	int *a4 = new int[asize];
	int *a5 = new int[asize];
	int *a6 = new int[asize];
	int *a7 = new int[asize];
	int *a8 = new int[asize];
	int *a9 = new int[asize];
	int *a10 = new int[asize];
	for (int i = 0; i < asize; i++)
    {
        a1[i] = a2[i] = a3[i] = a4[i] = a5[i] = a6[i] = a7[i] = a8[i] = a9[i] = a10[i] = aa[i];
    }


    // ��������� ���������� ������� ���������:
    int t1 = clock(); // ���������� ������
    insertionSort(a1, asize); //bubbleSort(aa, size);
    t1 = clock() - t1; // �, �������, ��������� ������������ ����������
    //������� ��������������� ������
    //for (int i = 1; i < size; i++) cout << a1[i] << ' ';
    //cout << endl;

    // ��������� ���������� ������� ��������� � ���������:
    int t2 = clock(); // ���������� ������
    insertionSortBisection(a2, asize);
    t2 = clock() - t2; // ��������� ������������ ����������
    //������� ��������������� ������
    //for (int i = 1; i < size; i++) cout << a2[i] << ' ';
    //cout << endl;

    // ��������� ������� ���������� � ���������:
    int t3 = clock(); // ���������� ������
    quickSort(a3, asize);
    t3 = clock() - t3; // ��������� ������������ ����������
    //������� ��������������� ������
    //for (int i = 1; i < size; i++) cout << a3[i] << ' ';
    //cout << endl;

    // ��������� ������� ���������� ��� ��������:
    int t4 = clock(); // ���������� ������
    quickSortNonRecursive(a4, asize);
    t4 = clock() - t4; // ��������� ������������ ����������
    //������� ��������������� ������
    //for (int i = 1; i < size; i++) cout << a4[i] << ' ';
    //cout << endl;

    // ��������� ���������� ������ �������:
    int t5 = clock(); // ���������� ������
    selectionSort(a5, asize);
    t5 = clock() - t5; // ��������� ������������ ����������
    //������� ��������������� ������
    //for (int i = 1; i < size; i++) cout << a5[i] << ' ';
    //cout << endl;

    // ��������� ���������� ���������:
    int t6 = clock(); // ���������� ������
    bubbleSort(a6, asize);
    t6 = clock() - t6; // ��������� ������������ ����������
    //������� ��������������� ������
    //for (int i = 1; i < size; i++) cout << a6[i] << ' ';
    //cout << endl;

    // ��������� ��������� ����������:
    int t7 = clock(); // ���������� ������
    shakerSort(a7, asize);
    t7 = clock() - t7; // ��������� ������������ ����������
    //������� ��������������� ������
    //for (int i = 1; i < size; i++) cout << a7[i] << ' ';
    //cout << endl;

    cout << "������������ ���������� ������� ���������: " << t1 << " ��" << endl;
    cout << "������������ ���������� ������� ��������� � ���������: " << t2 << " ��" << endl;
    cout << "������������ ������� ���������� � ���������: " << t3 << " ��" << endl;
    cout << "������������ ������� ���������� ��� ��������: " << t4 << " ��" << endl;
    cout << "������������ ���������� ������ �������: " << t5 << " ��" << endl;
    cout << "������������ ���������� ���������: " << t6 << " ��" << endl;
    cout << "������������ ��������� ����������: " << t7 << " ��" << endl;
    return 0;
}
