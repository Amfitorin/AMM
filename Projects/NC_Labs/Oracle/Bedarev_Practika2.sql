SELECT * 
FROM EMPLOYEES em
ORDER BY  /* Сортируем: */
			CASE /* 1) сначала по именам, начинающимся на гласную */
				WHEN SUBSTR(em.FIRST_NAME, 1, 1) IN ('A', 'E', 'I', 'O', 'U', 'Y') /* Если первая буква имени начинается с гласной, то */	
				/* WHEN LOWER(SUBSTR(em.FIRST_NAME, 1, 1)) IN ('a', 'e', 'i', 'o', 'u', 'y') /* Если первая буква имени начинается с гласной, то */	
				THEN
					1
				ELSE
					2
				END,
			SUBSTR(em.FIRST_NAME, 1, 1), /* 2) Затем по первой букве имени */
			LENGTH(em.FIRST_NAME) /* Затем по длине имени */
;

-- Отобрать сотрудников, у который среди букв фамилии встречается первая буква имени
SELECT * 
FROM EMPLOYEES em 
WHERE LOWER(em.LAST_NAME) LIKE ( '%' || LOWER(SUBSTR(em.FIRST_NAME, 1, 1)) || '%' )
;