USE shop;

# Task.1 Составьте список пользователей users, которые осуществили хотя бы один заказ orders в интернет магазине.

SELECT CONCAT(first_name, ' ', last_name) AS name, COUNT(*) AS value 
FROM users JOIN orders ON users.id = orders.users_id GROUP BY name ORDER BY value DESC; 

# Task.2 Выведите список товаров products и разделов catalogs, который соответствует товару.
# P.s. не уверен, что правтльно понял постановку задачи

SELECT catalogs.name, products.name, products.description, products.price 
FROM catalogs JOIN products WHERE catalogs.id =  products.catalog_id AND products.name = 'AMD FX-8320';

# Task.3 (по желанию) Пусть имеется таблица рейсов flights (id, from, to) и таблица городов cities (label, name). 
# Поля from, to и label содержат английские названия городов, поле name — русское. 
# Выведите список рейсов flights с русскими названиями городов.
# p.s. не получилось убрать ячйеки с со значением NULL 

SELECT flights.id, (SELECT cities.name WHERE flights.fromm = cities.label), 
(SELECT cities.name WHERE flights.too = cities.label) FROM flights JOIN cities ON flights.too = cities.label OR flights.fromm = cities.label
ORDER by flights.id;