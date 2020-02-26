# Скорректсировал запросы и где то изменил свою баззу данных, с учетом запросов которые были на уроке
#сюда добавлять не стал

# Task.2 Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей 
# ПС: наверное не лучшее решение.

USE vk;
SELECT * FROM likes;
CREATE TEMPORARY TABLE youngest_id (
id INT UNSIGNED
);
INSERT INTO youngest_id SELECT user_id FROM profiles ORDER BY TO_DAYS(NOW()) - TO_DAYS(birthdate) LIMIT 10;
SELECT * FROM youngest_id;
SELECT COUNT(*) AS Total_likes FROM likes WHERE target_id IN (SELECT id FROM media WHERE user_id IN (SELECT id FROM youngest_id));

# Task.3 Определить кто больше поставил лайков (всего) - мужчины или женщины?

SELECT COUNT(*) as Total_likes, (CASE(sex) WHEN 'm' THEN 'man' WHEN 'f' THEN 'women' END) AS sex FROM (SELECT user_id AS user,
(SELECT sex FROM profiles WHERE user_id = user) as sex FROM likes) likes_sex GROUP BY sex ORDER BY Total_likes DESC; 

# Task.4 Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети.

SELECT id, (SELECT COUNT(*) FROM likes WHERE users.id = likes.user_id) + 
(SELECT COUNT(*) FROM posts WHERE users.id = posts.user_id) AS acts FROM users GROUP BY id ORDER BY  acts LIMIT 10;
