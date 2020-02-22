# task1 Пусть в таблице users поля created_at и updated_at оказались незаполненными. 
#Заполните их текущими датой и временем.
USE shop;
UPDATE users SET created_at = NOW();
UPDATE users SET updated_at = NOW();

#Task1.2 Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR и 
#в них долгое время помещались значения в формате "20.10.2017 8:10". 
#Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.
ALTER TABLE users MODIFY created_at DATETIME;
ALTER TABLE users MODIFY updated_at DATETIME;

#Task1.3 В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры:
#0, если товар закончился и выше нуля, если на складе имеются запасы. Необходимо отсортировать записи таким образом, 
#чтобы они выводились в порядке увеличения значения value. Однако, нулевые запасы должны выводиться в конце, после всех записей.
SELECT * FROM storehouses_products ORDER BY value = 0, value;

#Task 2.1 Подсчитайте средний возраст пользователей в таблице users
SELECT AVG((TO_DAYS(NOW()) - TO_DAYS(birthdate)) / 365.25) AS Averange_old FROM profiles;

# Task 2.2 Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели. 
#Следует учесть, что необходимы дни недели текущего года, а не года рождения.
UPDATE profiles SET day_birth = DAYOFWEEK(CONCAT(YEAR(NOW()), '-', MONTH(birthdate), '-', DAY(birthdate)));
SELECT COUNT(*) AS Total, day_birth FROM profiles GROUP BY day_birth ORDER BY day_birth;
