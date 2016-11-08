-- Бедарев А.А. Практическая работа №1.
-- 1)
SELECT * FROM departments
ORDER BY department_id;

-- 2)
SELECT e.customer_id,
       e.cust_first_name || ' ' ||  e.cust_last_name "NAME",
       e.cust_email
FROM customers e
ORDER BY customer_id;

-- 3)
SELECT em.last_name, 
       em.first_name,
       em.job_id,
       em.email,
       em.phone_number,
       CASE
          WHEN em.salary * 12 <= 150000 THEN
          	ROUND(em.salary * 0.7)
          ELSE 
          	ROUND(em.salary * 0.65)
          END AS SALARY
FROM employees em
WHERE em.salary * 12 BETWEEN 100000 AND 200000
ORDER BY em.job_id, SALARY DESC, em.last_name;

-- 4)
SELECT co.COUNTRY_ID AS "Код страны",
	   co.COUNTRY_NAME AS "Название страны"
FROM COUNTRIES co
WHERE co.COUNTRY_ID IN ('DE', 'IT', 'RU')
ORDER BY co.COUNTRY_NAME;

-- 5)
SELECT em.FIRST_NAME || ' ' || em.LAST_NAME
FROM EMPLOYEES em
WHERE em.LAST_NAME LIKE '_a%'
	AND LOWER(em.FIRST_NAME) LIKE '%d%'
ORDER BY em.FIRST_NAME;

-- 6)
SELECT *
FROM EMPLOYEES em
WHERE  LENGTH(em.FIRST_NAME)<5
	OR LENGTH(em.LAST_NAME)<5
ORDER BY LENGTH(em.FIRST_NAME) + LENGTH(em.LAST_NAME),
		 LENGTH(em.LAST_NAME),
		 em.LAST_NAME,
		 em.FIRST_NAME
;

-- 7)
SELECT  jo.JOB_ID,
		jo.JOB_TITLE,
		ROUND( (jo.MAX_SALARY + jo.MIN_SALARY)/2*(1-0.18), -2 ) AS "AVG_SALARY" /* Округление до сотых*/
FROM JOBS jo
ORDER BY "AVG_SALARY" DESC,
		 jo.JOB_ID
;

-- 8)
SELECT 	cu.CUST_LAST_NAME,
		cu.CUST_FIRST_NAME,
		CASE
			WHEN cu.CREDIT_LIMIT >= 3500 THEN
				'A'
			WHEN cu.CREDIT_LIMIT >= 1000 THEN
				'B'
			ELSE
				'C'
			END AS CATEGORY,
		CASE
			WHEN cu.CREDIT_LIMIT >= 3500 THEN /* А тут никак нельзя WHEN CATEGORY = 'A'  ??? */
				'Внимание, VIP-клиенты'
			ELSE
				NULL
			END AS COMMENTS
FROM CUSTOMERS cu
ORDER BY CATEGORY,
		 cu.CUST_LAST_NAME
;

-- 9)
SELECT DECODE( EXTRACT(MONTH FROM o.ORDER_DATE), 1,  'Январь',
												 2,  'Февраль',
												 3,  'Март',
												 4,  'Апрель',
												 5,  'Май',
												 6,  'Июнь',
												 7,  'Июль',
												 8,  'Август',
												 9,  'Сентябрь',
												 10, 'Октябрь',
												 11, 'Ноябрь',
												 12, 'Декабрь'										 
												 ) AS MONTH
FROM ORDERS o
WHERE o.ORDER_DATE BETWEEN DATE'1998-01-01' AND DATE'1998-12-31'
		AND o.ORDER_STATUS > 0 /* где количество заказов больше нуля */
GROUP BY EXTRACT(MONTH FROM o.ORDER_DATE)
ORDER BY EXTRACT(MONTH FROM o.ORDER_DATE)
;

-- 10)
SELECT DISTINCT /* DISTINCT - оператор работы только с уникальными значениями столбца */
	to_char(o.ORDER_DATE, 'Month', 'NLS_DATE_LANGUAGE = RUSSIAN') AS MONTH /* использование to_char в русской локали */
FROM ORDERS o
WHERE o.ORDER_DATE BETWEEN DATE'1998-01-01' AND DATE'1998-12-31'
		AND o.ORDER_STATUS > 0 /* где количество заказов больше нуля */
/* Не используем группировку, так как работаем только с уникальными значениями столбца через DISTINCT : */
/* GROUP BY to_char(o.ORDER_DATE, 'Month', 'NLS_DATE_LANGUAGE = RUSSIAN') /* <-- Почему не работает псевдоним MONTH ? */
/* ORDER BY TO_CHAR(o.ORDER_DATE, 'fmMM') */ /* <-- Почему не работает сортировка? И как отсортировать? */
;

-- 11) По реализации хорошая статья http://www.geocities.ws/luzanovp/calendar.html
SELECT  TO_CHAR(TRUNC(SYSDATE, 'MM') + ROWNUM - 1) AS DT,
		CASE
			WHEN TO_CHAR(TRUNC(SYSDATE, 'MM') + ROWNUM - 1, 'fmDAY', 'NLS_DATE_LANGUAGE = RUSSIAN') = 'СУББОТА' 
				OR TO_CHAR(TRUNC(SYSDATE, 'MM') + ROWNUM - 1, 'fmDAY', 'NLS_DATE_LANGUAGE = RUSSIAN') = 'ВОСКРЕСЕНЬЕ'			
			THEN
				'Выходной'
			ELSE
				NULL
			END AS COMMENTS
FROM all_objects
WHERE ROWNUM <= TO_NUMBER(TO_CHAR(LAST_DAY(SYSDATE), 'DD'))
;
 
-- 12)
SELECT 	em.EMPLOYEE_ID, /* Код сотрудника */
		em.LAST_NAME || ' ' || em.FIRST_NAME AS EMP_NAME, /* Фамилия + Имя через пробел */
		em.JOB_ID, /* Код должности */
		em.SALARY, /* Зарплата */
		em.COMMISSION_PCT /* Комиссионные проценты */
FROM EMPLOYEES em
WHERE em.COMMISSION_PCT IS NOT NULL
ORDER BY em.COMMISSION_PCT DESC,
		 em.EMPLOYEE_ID
;

-- 13)
/* SELECT *
FROM ORDERS o
;

SELECT 	TO_CHAR(o.ORDER_DATE, 'YYYY') AS YEAR,
		TO_CHAR(o.ORDER_DATE, 'fmMM', 'NLS_DATE_LANGUAGE = RUSSIAN')AS QUART1_SUM
FROM ORDERS o
;
*/
SELECT 	TO_CHAR(o.ORDER_DATE, 'YYYY') AS YEAR,
		SUM(  DECODE( TO_CHAR(o.ORDER_DATE, 'fmMM'), 	'1',  o.ORDER_TOTAL,
														'2',  o.ORDER_TOTAL,
														'3',  o.ORDER_TOTAL									 
												 							) ) AS QUART1_SUM,
		SUM(  DECODE( TO_CHAR(o.ORDER_DATE, 'fmMM'), 	'4',  o.ORDER_TOTAL,
														'5',  o.ORDER_TOTAL,
														'6',  o.ORDER_TOTAL									 
												 							) ) AS QUART2_SUM,
		SUM(  DECODE( TO_CHAR(o.ORDER_DATE, 'fmMM'), 	'7',  o.ORDER_TOTAL,
														'8',  o.ORDER_TOTAL,
														'9',  o.ORDER_TOTAL									 
												 							) ) AS QUART3_SUM,
		SUM(  DECODE( TO_CHAR(o.ORDER_DATE, 'fmMM'), 	'10',  o.ORDER_TOTAL,
														'11',  o.ORDER_TOTAL,
														'12',  o.ORDER_TOTAL									 
												 							) ) AS QUART4_SUM,
		SUM(o.ORDER_TOTAL) AS YEAR_SUM
FROM ORDERS o
WHERE o.ORDER_DATE BETWEEN DATE'1995-01-01' AND DATE'2000-12-31'
GROUP BY TO_CHAR(o.ORDER_DATE, 'YYYY')
ORDER BY YEAR
;

-- 14)
SELECT 	pin.PRODUCT_ID, /* Номер товара */
		pin.PRODUCT_NAME, /* Имя товара */
		TO_NUMBER(SUBSTR(TO_CHAR(pin.WARRANTY_PERIOD), 2, 2)) * 12 + TO_NUMBER(SUBSTR(TO_CHAR(pin.WARRANTY_PERIOD), 5, 6)) AS WARRANTY_MONTHS,
		/* Пересчитывем гарантию, из диапазона вида 1-1 в количество месяцев */
		pin.LIST_PRICE, /* Цена памяти */
		pin.CATALOG_URL /* Ссылка на URL */
FROM PRODUCT_INFORMATION pin
WHERE  	REGEXP_LIKE(  LOWER(pin.PRODUCT_NAME),'[[:digit:]]+[ ]*(mb|gb)'  ) /* где для товара указан размер в MB или GB, обязательно с числом перед ними*/
		AND NOT REGEXP_LIKE(  LOWER(pin.PRODUCT_NAME),'^hd'  ) /* Где название товара не начинается с HD - то есть это не Hard Disk *//* SUBSTR(pin.PRODUCT_NAME, 0, 2) <> 'HD' */
		AND NOT REGEXP_LIKE(  LOWER( SUBSTR(pin.PRODUCT_DESCRIPTION, 1, 30) ),'(disk|drive|hard)'  )
		/* Где в первых 30 символах товара не встречаются слова disk, drive или hard */
ORDER BY /* Группируем через CASE по размеру памяти - по убыванию, где через регулярки вытаскиваем размер памяти и приводим его к виду в МБ: */
		(CASE
			WHEN REGEXP_LIKE(  LOWER(pin.PRODUCT_NAME),'[[:digit:]]+[ ]*mb'  ) THEN
				TO_NUMBER(  regexp_substr(regexp_substr(LOWER(pin.PRODUCT_NAME),'[[:digit:]]+[ ]*mb') , '[[:digit:]]+[ ]*')  )
			WHEN REGEXP_LIKE(  LOWER(pin.PRODUCT_NAME),'[[:digit:]]+[ ]*gb'  )  THEN
				TO_NUMBER(  regexp_substr(regexp_substr(LOWER(pin.PRODUCT_NAME),'[[:digit:]]+[ ]*gb') , '[[:digit:]]+[ ]*')  ) * 1024
			ELSE TO_NUMBER('0')
			END) DESC,
		pin.LIST_PRICE /* и группируем по цене - по возрастанию */
;

-- 15)
/* SELECT (TO_DATE('01.01.2001 ' || '21.30', 'dd.mm.yyyy hh24.mi') - TO_DATE('01.01.2001 ' || to_char(sysdate,'hh24.mi'), 'dd.mm.yyyy hh24.mi'))*24*60 AS MINUTES
FROM DUAL;

SELECT (TO_DATE(to_char(sysdate,'dd.mm.yyyy ') || '21.30', 'dd.mm.yyyy hh24.mi') - TO_DATE(to_char(sysdate,'dd.mm.yyyy hh24.mi'), 'dd.mm.yyyy hh24.mi'))*24*60 AS MINUTES
FROM DUAL;
*/

SELECT ROUND( (TO_DATE(TO_CHAR(SYSDATE,'dd.mm.yyyy ') || '21.30', 'dd.mm.yyyy hh24.mi') - SYSDATE)*24*60 ) AS MINUTES
FROM DUAL;