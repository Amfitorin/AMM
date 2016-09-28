#include <iostream>
#include <cstdlib>
#include <ctime>

using namespace std;

// Метод сортировки прямыми вставками:
int insertionSort(int* arr, int ssize)
{
    int i, j;
    int tmp; //   Временная переменная для хранения обрабатываемого элемента
    // Запускаем сортировку массива:
    for (i = 1; i < ssize; i++)
    {
        tmp = arr[i]; // Вытаскиваем текущий элемент
        arr[0] = tmp; // Устанавливаем заглушку на нулевой элемент
        j = i; // Запоминаем место
        while(tmp < arr[j-1])
        {
            arr[j] = arr[j-1];
            --j; // Шаг к началу
        }
        arr[j] = tmp; // Помещаем текущий элемент на подходящее место
    }
    return 0;
}

// Метод сортировки прямым включением Модификация бисекцией
int insertionSortBisection(int* arr, int ssize)
{
    int i, j;
    int M, L, R;
    int tmp; //   Временная переменная для хранения обрабатываемого элемента
    // Запускаем сортировку массива:
    for (i = 1; i < ssize; i++)
    {
        tmp = arr[i]; // Вытаскиваем текущий элемент
        L = 1;
        R = i;
        while(L < R){
            M = (L + R) / 2;
            if (arr[M] <= tmp) L = M + 1; // Передвигаем границы
            else R = M;
        }
        for (j = i; j >= R + 1; j--) arr[j] = arr[j-1]; // Переместить все элементы вправо
        arr[R] = tmp; // Устанавливаем на подходящее место текущий элемент
    }
    return 0;
}

// Метод быстрой сортировки с рекурсией:
int ssort(int* arr, int L, int R)
{
	int i, j;
	int x, w;
	// Запускаем сортировку массива:
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




// Метод быстрой сортировки без рекурсии:
int quickSortNonRecursive(int* arr, int ssize)
{
	int i, j;
	int L, R, s;
	int x, w;
	// Динамически выделяем память под хранение двух массивов размера size:
	int *stackLow = new int[ssize]; // Стек нижних индексов
	int *stackHigh = new int[ssize]; // Стек верхних индексов

	// Запускаем сортировку массива:
	s = 1; // Нулевой элемент не рассматриваем, он для заглушки в других сортировках, а так надо бы s = 0;
        stackLow[1] = 1; // В оригинале stackLow[0] = 0; - нулевой не используем
        stackHigh[1] = ssize - 1; // В оригинале stackHigh[0] = size - 1; - нулевой не используем
        do { // Взять верхний запрос со стека
            L = stackLow[s]; R = stackHigh[s]; s = s - 1;
            do { // Разделить сегмент arr[L] ... arr[R]
                i = L; j = R;
                x = arr[(L + R) / 2];
                do {
                    while (arr[i] < x) i = i + 1;
                    while (x < arr[j]) j = j - 1;
                    if (i <= j){
                        w = arr[i]; arr[i] = arr[j]; arr[j] = w; i = i + 1; j = j - 1;
                    }
                } while (i < j); // выполнять пока истинной, а в делфи - до тех пор, пока не станет истинно - там надо i > j
                if (i < R){ // Сохранить в стеке запрс на сортировку правой части
                    s = s + 1; stackLow[s] = i; stackHigh[s] = R;
                }
                R = j;
            } while (L < R); // Теперь L и R ограничивает левую часть
        } while (s > 0); // c while (s >= 0) не заработал  while (s = -1)
	return 0;
}

// Метод сортировки прямым выбором:
int selectionSort(int* arr, int ssize)
{
	int i, j, k;
	int tmp;
	// Запускаем сортировку массива:
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

// Метод сортировки прямого обмена (Пузырьковая сортировка):
int bubbleSort(int* arr, int ssize)
{
    int i, j;
    int tmp;
    // Запускаем сортировку массива:
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

// Метод шейкерной сортировки (хождение зигзагом с сужением границ, модификация пузырьковой сортировки):
int shakerSort(int* arr, int ssize)
{
    int k, j, L, R;
    int tmp;

    // Запускаем сортировку массива:
    L = 2;
    R = ssize - 1;
    k = ssize - 1;
    do{
        for (j = R; j >= L; j--){ // Проход справа налево
            if (arr[j-1] > arr[j]){
                tmp = arr[j-1];
                arr[j-1] = arr[j];
                arr[j] = tmp;
                k = j;
            }
        }
        L = k + 1; // Сдвигаем левую границу вправо
        for (j = L; j <= R; j++){ // Проход слева направо
            if (arr[j-1] > arr[j]){
                tmp = arr[j-1];
                arr[j-1] = arr[j];
                arr[j] = tmp;
                k = j; // Сдвигаем границу
            }
        }
        R = k - 1; // Сдвигаем правую границу влево
    } while (L <= R);
	return 0;
}

// Метод сртировки Шелла (несколько последовательных сортировок с разной дальностью):
int shellSort(int* arr, int ssize){
    const int T = 4; // Всего T расстояний сортировки
    int i, j, k, m;
    int tmp;
    // Динамически выделяем память под хранение массива сортировок
	int *h = new int[T]; // Массив расстояний сортировок

    // Запускаем сортировку массива:
    h[0] = 9; h[1] = 5; h[2] = 3; h[3] = 1; // Задаем расстояния сортировки в массив расстояний
    for (m = 0; m < T; m++){
        k = h[m];
        for (i = k; i < ssize; i++){ // ?? i = k+1 из-за того, что у нас нулевой элемент используется в других сортировках как заглушка
            tmp = arr[i]; j = i - k;
            while ( (j >= k) && (tmp < arr[j]) ){
                arr[j+k] = arr[j];
                j = j - k;
            }
            if ( (j >= k) || (tmp >= arr[j]) ){
                arr[j+k] = tmp;
            }
            else {
                arr[j+k] = arr[j];
                arr[j] = tmp;
            }
        }
    }
    return 0;
}




int main()
{
    setlocale(LC_ALL, "rus");
    {/* // Кусочек кода для ввода массива вручную
    cout << "Sortirovka Massiva" << endl;
    cout << "size = "; // Считываем размер массива, который необходимо отсортировать
    int size;
    cin >> size;
    int *aa = new int[size]; // Динамически выделяем память под хранение массива размера size
    for (int i = 0; i < size; i++) cin >> aa[i]; // Считываем массив
    sortDirectInclusion(aa, size);
    // Выводим отсортированный массив
    for (int i = 0; i < size; i++) cout << aa[i] << ' ';
    return 0; */}

    // Кусочек кода для рандомной генерации массива
    cout << "Сортировка массива" << endl;
    cout << "Задайте число элементов: ";
    int asize;
    cin >> asize;
    asize = asize + 1;
    int *aa = new int[asize]; // Динамически выделяем память под хранение массива размера size
    cout << "Задайте диапазон генерации (например, 10 30): ";
    int start, endd;
    cin >> start;
    cin >> endd;
    // Запускаем генерацию случайных чисел для массива:
    aa[0] = 0; // Заглушка
    for (int i = 1; i < asize; i++)
	{
		aa[i] = start + rand() % (endd - start + 1);	// start ... end
	}
	 // Выводим сгенерированный массив
     //for (int i = 1; i < size; i++) cout << aa[i] << ' ';
     //cout << endl;

	// Делаем копию массива для каждой сортировки:
	int *a1 = new int[asize]; // Динамически выделяем память под хранение массива размера size
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


    // Выполняем сортировку прямыми вставками:
    int t1 = clock(); // Запоминаем начало
    insertionSort(a1, asize); //bubbleSort(aa, size);
    t1 = clock() - t1; // и, наконец, вычисляем длительность сортировки
    //Выводим отсортированный массив
    //for (int i = 1; i < size; i++) cout << a1[i] << ' ';
    //cout << endl;

    // Выполняем сортировку прямыми вставками с бисекцией:
    int t2 = clock(); // Запоминаем начало
    insertionSortBisection(a2, asize);
    t2 = clock() - t2; // вычисляем длительность сортировки
    //Выводим отсортированный массив
    //for (int i = 1; i < size; i++) cout << a2[i] << ' ';
    //cout << endl;

    // Выполняем быструю сортировку с рекурсией:
    int t3 = clock(); // Запоминаем начало
    quickSort(a3, asize);
    t3 = clock() - t3; // вычисляем длительность сортировки
    //Выводим отсортированный массив
    //for (int i = 1; i < size; i++) cout << a3[i] << ' ';
    //cout << endl;

    // Выполняем быструю сортировку без рекурсии:
    int t4 = clock(); // Запоминаем начало
    quickSortNonRecursive(a4, asize);
    t4 = clock() - t4; // вычисляем длительность сортировки
    //Выводим отсортированный массив
    //for (int i = 1; i < size; i++) cout << a4[i] << ' ';
    //cout << endl;

    // Выполняем сортировку прямым выбором:
    int t5 = clock(); // Запоминаем начало
    selectionSort(a5, asize);
    t5 = clock() - t5; // вычисляем длительность сортировки
    //Выводим отсортированный массив
    //for (int i = 1; i < size; i++) cout << a5[i] << ' ';
    //cout << endl;

    // Выполняем сортировку пузырьком:
    int t6 = clock(); // Запоминаем начало
    bubbleSort(a6, asize);
    t6 = clock() - t6; // вычисляем длительность сортировки
    //Выводим отсортированный массив
    //for (int i = 1; i < size; i++) cout << a6[i] << ' ';
    //cout << endl;

    // Выполняем шейкерную сортировку:
    int t7 = clock(); // Запоминаем начало
    shakerSort(a7, asize);
    t7 = clock() - t7; // вычисляем длительность сортировки
    //Выводим отсортированный массив
    //for (int i = 1; i < size; i++) cout << a7[i] << ' ';
    //cout << endl;

    cout << "Длительность сортировки прямыми вставками: " << t1 << " мс" << endl;
    cout << "Длительность сортировки прямыми вставками с бисекцией: " << t2 << " мс" << endl;
    cout << "Длительность быстрой сортировки с рекурсией: " << t3 << " мс" << endl;
    cout << "Длительность быстрой сортировки без рекурсии: " << t4 << " мс" << endl;
    cout << "Длительность сортировки прямым выбором: " << t5 << " мс" << endl;
    cout << "Длительность сортировки пузырьком: " << t6 << " мс" << endl;
    cout << "Длительность шейкерной сортировки: " << t7 << " мс" << endl;
    return 0;
}
