-- Создаем необходимые таблицы
CREATE TABLE Users(
    userId integer PRIMARY KEY,
    age integer NOT NULL
);

CREATE TABLE Items (
    itemId integer PRIMARY KEY,
    price numeric CHECK (price > 0)
);

CREATE TABLE Purchases(
    purchaseId INTEGER PRIMARY KEY,
    userId INTEGER NOT NULL REFERENCES Users,
    itemId INTEGER NOT NULL REFERENCES Items,
    date DATE NOT NULL
);

-- Заполняем таблицы данными
INSERT INTO Users VALUES
    (1, 15), (2, 20), (3, 25), (4, 30),
    (5, 35), (6, 40), (7, 45), (8, 45),
    (9, 50), (10, 55)
;

INSERT INTO Items VALUES
    (1, 10),(2, 20),(3, 30),
    (4, 40),(5, 50),(6, 60)
;

INSERT INTO Purchases VALUES
    (1, 1 , 1, '2010-10-10'),(2, 3, 2, '2010-11-10'),(3, 1, 3, '2010-11-10'),(4, 3 ,3, '2010-12-10'),
    (5, 5, 6, '2011-11-11'),(6, 6, 4, '2011-11-11'),(7, 5, 6, '2011-11-12'),(8, 7, 4, '2010-10-15'),
    (9, 8, 2, '2011-11-13'),(10, 10, 2, '2011-11-13'),(11, 4, 1, '2011-11-14'),(12, 2, 4, '2010-12-10')
;

--A)
--Этот запрос забирает из базы данных потраченную сумму в месяцы пользователями в возрасте от 18 до 25

SELECT AVG(price) FROM Purchases
LEFT JOIN Users USING (userid)
LEFT JOIN Items USING (itemid)
WHERE 25 >= age AND 18 <= age;

--Этот запрос забирает из базы данных потраченную сумму в месяцы пользователями в возрасте от 26 до 35

SELECT AVG(price) FROM Purchases
LEFT JOIN Users USING (userid)
LEFT JOIN Items USING (itemid)
WHERE 35 >= age AND 26 <= age;

--Б) Запрос выводит 2 месяца один за 2010 другой за 2011. Для понятности вывожу цену и год
SELECT DISTINCT
	Sum(price) As Sm,
    EXTRACT(MONTH from date) as Mon,
    EXTRACT(YEAR FROM date) as YEAR from Purchases
LEFT JOIN Items USING (itemid)
LEFT JOIN Users USING (userid)
WHERE age > 35
GROUP BY date;


--В) Запрос выводит товар приносящий самую большую выручку за 2011 год (он последний)
SELECT DISTINCT itemid FROM purchases
LEFT JOIN items USING (itemid)
WHERE date = (SELECT MAX(date) FROM purchases);

--Г) Запрос выдает 3 товара с самой большой выручкой за все года
SELECT itemid, SUM(price) FROM purchases
LEFT JOIN items USING (itemid)
GROUP BY itemid
LIMIT 3;

-- Проверено в PostgreSQL
