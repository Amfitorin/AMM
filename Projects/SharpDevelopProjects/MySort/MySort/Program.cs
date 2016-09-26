/*
 * Created by SharpDevelop.
 * User: Hroniko
 * Date: 12.09.2016
 * Time: 15:00
 * 
 * To change this template use Tools | Options | Coding | Edit Standard Headers.
 */
using System;
using System.Diagnostics;

namespace MySort
{
	class Program
	{
		public static void Main(string[] args)
		{
			Console.WriteLine("Введите число элементов, начало и конец диапазона через пробел:");
			
			string[] stroka = Console.ReadLine().Split(' ');
			
			int size = int.Parse(stroka[0]);
			int start = int.Parse(stroka[1]);
			int finish = int.Parse(stroka[2]);
				
			//int maxSize = 100;
	        /*ArraySort arr = new ArraySort(maxSize);
	        arr.add(77);
	        arr.add(99);
	        arr.add(44);
	        arr.add(55);
	        arr.add(22);
	        arr.add(88);
	        arr.add(11);
	        arr.add(00);
	        arr.add(66);
	        arr.add(33); */
	        ArraySort arr = new ArraySort(size, start, finish);
	        ArraySort arrB = new ArraySort(arr); // Делаем копию
	
	        // arr.display();
	        
			Stopwatch stopwatch = new Stopwatch();
	        stopwatch.Start();
	        arr.shakerSort();
	        stopwatch.Stop();
	        Console.WriteLine("Время сортировки №1: " + (stopwatch.ElapsedMilliseconds).ToString() + " мс");
	        // arr.display();
	
			Stopwatch stopwatchB = new Stopwatch();
	        stopwatchB.Start();
	        arrB.bubbleSort(); // sortDirectInclusionBisection();
	        stopwatchB.Stop();
			Console.WriteLine("Время сортировки №2: " + (stopwatchB.ElapsedMilliseconds).ToString() + " мс");
			// arrB.display();
			
	        Console.Write("Press any key to continue . . . ");
			Console.ReadKey(true);
		}
	}
}