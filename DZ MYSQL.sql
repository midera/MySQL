# 1. +Вибрати усіх клієнтів, чиє ім'я має менше ніж 6 символів.
SELECT * FROM client WHERE LENGTH(FirstName) <6;

# 2. +Вибрати львівські відділення банку.
SELECT * FROM department WHERE DepartmentCity = 'Lviv';

#3. +Вибрати клієнтів з вищою освітою та посортувати по прізвищу.
SELECT LastName FROM client WHERE Education = 'high';

#4. +Виконати сортування у зворотньому порядку над таблицею Заявка і вивести 5 останніх елементів.
SELECT * FROM client ORDER BY FirstName DESC LIMIT 5;

#5. +Вивести усіх клієнтів, чиє прізвище закінчується на OV чи OVA.
SELECT * FROM client WHERE LastName LIKE '%OV' AND '%OVA';

#6. +Вивести клієнтів банку, які обслуговуються київськими відділеннями.
 SELECT * FROM client c JOIN department d 
 ON c.Department_idDepartment = d.idDepartment
WHERE DepartmentCity = 'Kyiv';

#7. +Вивести імена клієнтів та їхні номера телефону, погрупувавши їх за іменами.
SELECT	c.LastName,
		c.Passport 
 FROM client c 
 GROUP BY FirstName;
 
#8. +Вивести дані про клієнтів, які мають кредит більше ніж на 5000 тисяч гривень.
SELECT * FROM application WHERE
CreditState = 'Not returned' AND Sum > 5000;

#9. +Порахувати кількість клієнтів усіх відділень та лише львівських відділень.
SELECT COUNT(idClient) FROM client c 
JOIN department d ON 
 c.Department_idDepartment = d.idDepartment;

SELECT COUNT(idClient) FROM client c
 JOIN department d ON  
 c.Department_idDepartment = d.idDepartment 
 WHERE DepartmentCity = 'Lviv';
 
 #10. Знайти кредити, які мають найбільшу суму для кожного клієнта окремо.
SELECT FirstName,LastName ,MAX(Sum)  AS maxSum
FROM application a
 JOIN client c ON  a.Client_idClient=c.idClient
 GROUP BY Client_idClient;
 
# 11. Визначити кількість заявок на крдеит для кожного клієнта.
SELECT  FirstName,LastName , count(Client_idClient) AS numApplications
FROM application a JOIN client c ON a.Client_idClient=c.idClient
 GROUP BY Client_idClient;
 
#12. Визначити найбільший та найменший кредити.
SELECT MAX(Sum) AS maxCredit FROM application; 
SELECT MIN(Sum) AS minCredit FROM application; 

# 13. Порахувати кількість кредитів для клієнтів,які мають вищу освіту.
SELECT count(idApplication) FROM application a 
JOIN client c ON a.Client_idClient = c.idClient
WHERE Education='high';

#14. Вивести дані про клієнта, в якого середня сума кредитів найвища.
SELECT  Client_idClient AS idClientFirstName,
       LastName,
       SUM(Sum)        AS creditSum,
       AVG(Sum)        AS averageSum
FROM application
         JOIN client c ON application.Client_idClient = c.idClient
GROUP BY Client_idClient
ORDER BY averageSum DESC
LIMIT 1;

#15. Вивести відділення, яке видало в кредити найбільше грошей
SELECT Department_idDepartment AS Department, 
DepartmentCity AS City, sum(Sum) AS SumCredit
 FROM application a
			JOIN client c ON a.Client_idClient = c.idClient
			JOIN department d ON  c.Department_idDepartment = d.idDepartment
 GROUP BY Department_idDepartment
 ORDER BY  SumCredit DESC
LIMIT 1;
# 16. Вивести відділення, яке видало найбільший кредит.
SELECT Department_idDepartment AS Department, 
DepartmentCity AS City, MAX(Sum) AS MaxCredit
 FROM application a
			JOIN client c ON a.Client_idClient = c.idClient
			JOIN department d ON  c.Department_idDepartment = d.idDepartment;

# 17. Усім клієнтам, які мають вищу освіту, встановити усі їхні кредити у розмірі 6000 грн.
UPDATE application a 
JOIN client c ON 
 a.Client_idClient = c.idClient
SET a.Sum      = 6000,
    a.Currency = 'Gryvnia'
WHERE c.Education = 'high';

#18. Усіх клієнтів київських відділень пересилити до Києва.
UPDATE client c 
JOIN department d ON c.Department_idDepartment = d.idDepartment
SET c.City = 'Kyiv'
WHERE d.DepartmentCity = 'Kyiv';

#19. Видалити усі кредити, які є повернені.
DELETE FROM application
WHERE CreditState = 'returned'
 LIMIT 10;
#20. Видалити кредити клієнтів, в яких друга літера прізвища є голосною.


#Знайти львівські відділення, які видали кредитів на загальну суму більше ніж 5000
 SELECT DepartmentCity, SUM(Sum) FROM application 
 JOIN client c ON application.Client_idClient=c.idClient
 JOIN department d ON c.Department_idDepartment = d.idDepartment
 WHERE d.DepartmentCity = 'Lviv' AND Sum > 5000;
 
#????Знайти клієнтів, які повністю погасили кредити на суму більше ніж 5000
SELECT FirstName,
	   LastName,MAX(Sum) FROM application 
 JOIN client c ON application.Client_idClient=c.idClient
WHERE CreditState = 'Returned' AND Sum = 5000;

/* Знайти максимальний неповернений кредит.*/
SELECT  MAX(Sum) FROM application
WHERE CreditState = 'Not returned';
/*Знайти клієнта, сума кредиту якого найменша*/
SELECT  FirstName,
	    LastName ,
        MIN(Sum)
AS creditMin FROM client  c
JOIN application a ON c.idClient = a.Client_idClient
GROUP BY Client_idClient
ORDER BY min(Sum)
LIMIT 1;            

/*Знайти кредити, сума яких більша за середнє значення усіх кредитів*/
SELECT  FirstName,
	    LastName ,
        AVG(Sum)
AS creditMin FROM client  c
JOIN application a ON c.idClient = a.Client_idClient
GROUP BY Client_idClient
ORDER BY AVG(Sum)
LIMIT 10; 

/*Знайти клієнтів, які є з того самого міста, що і клієнт, який взяв найбільшу кількість кредитів*/
SELECT *, MAX(Sum) FROM client c
JOIN application a ON c.idClient = a.Client_idClient
GROUP BY Client_idClient
ORDER BY MAX(Sum);  

#місто чувака який набрав найбільше кредитів
 


set sql_safe_updates = 0;
set sql_safe_updates = 1;

















 




