#Task.1 Добавить необходимые внешние ключи для всех таблиц базы данных vk (приложить команды).
# Про likes: Почитал документацию не нашел возможности создания внешнего ключа с условием. Вижу выход в создании промежуточной таблицы 
# (со столбцами пост_айди, меди_айди,юзер_айди и т.д.)
# для связи лайкс с другими таблицами. Но что то мне подсказывает, что это не оптимальный вариант. МБ if или case,
# но не смог найти синтаксис
USE vk;

      
ALTER TABLE profiles
  ADD CONSTRAINT profiles_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
      ON DELETE CASCADE;

     ALTER TABLE profiles DROP FOREIGN KEY profles_user_id_fk;
ALTER TABLE profiles MODIFY COLUMN photo_id INT(10) UNSIGNED;

ALTER TABLE profiles 
  ADD CONSTRAINT profiles_photo_id_fk
    FOREIGN KEY (photo_id) REFERENCES media(id)
      ON DELETE SET NULL;
      
ALTER TABLE messages
  ADD CONSTRAINT messages_from_user_id_fk 
    FOREIGN KEY (from_user_id) REFERENCES users(id),
  ADD CONSTRAINT messages_to_user_id_fk 
    FOREIGN KEY (to_user_id) REFERENCES users(id);
    
 
ALTER TABLE communities_users 
  ADD CONSTRAINT communities_users_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
    ON DELETE CASCADE,
  ADD CONSTRAINT communities_users_community_id_fk 
    FOREIGN KEY (community_id) REFERENCES communities(id)
    ON DELETE CASCADE;
    
ALTER TABLE friendship 
  ADD CONSTRAINT friendship_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
    ON DELETE CASCADE,
  ADD CONSTRAINT friendship_friend_id_fk 
    FOREIGN KEY (friend_id) REFERENCES users(id)
    ON DELETE CASCADE,
  ADD CONSTRAINT friendship_status_id_fk 
    FOREIGN KEY (status_id) REFERENCES friendship_statuses(id);
   
ALTER TABLE posts
  ADD CONSTRAINT posts_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
    ON DELETE CASCADE,
  ADD CONSTRAINT posts_media_id_fk 
    FOREIGN KEY (media_id) REFERENCES media(id)
    ON DELETE CASCADE;
 
ALTER TABLE vk.media
  ADD CONSTRAINT media_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
    ON DELETE CASCADE,
  ADD CONSTRAINT media_type_id_fk 
    FOREIGN KEY (media_type_id) REFERENCES media_types(id);
   
ALTER TABLE likes
  ADD CONSTRAINT likes_user_id_fk 
    FOREIGN KEY (user_id) REFERENCES users(id)
    ON DELETE CASCADE,
  ADD CONSTRAINT likes_target_type_id_fk 
    FOREIGN KEY (target_type_id) REFERENCES target_types(id); 
# Почитал документацию не нашел возможности создания внешнего ключа с условием. Вижу выход в создании промежуточной таблицы (со столбцами пост_айди, меди_айди,юзер_айди и т.д.)
# для связи лайкс с другими таблицами. Но что то мне подсказывает, что это не оптимальный вариант. МБ if или case,
# но не смог найти синтаксис

#Task.3 Переписать запросы, заданые к ДЗ урока 6 с использованием JOIN (четыре запроса).   
# Подсчитать общее количество лайков, которые получили 10 самых молодых пользователей.

SELECT COUNT(*) AS Total_likes FROM likes JOIN (SELECT * FROM profiles ORDER BY profiles.birthdate LIMIT 10) AS young_prof 
ON likes.user_id = young_prof.user_id AND likes.target_type_id = 2;

# Определить кто больше поставил лайков (всего) - мужчины или женщины?

SELECT COUNT(*) AS Total_likes, (CASE(sex) WHEN 'm' THEN 'man' WHEN 'f' THEN 'women' END) AS sex FROM profiles JOIN likes ON profiles.user_id = likes.user_id GROUP BY sex;

# Найти 10 пользователей, которые проявляют наименьшую активность в использовании социальной сети.
   
SELECT users.id, CONCAT(first_name, ' ', last_name), COUNT(posts.id) + COUNT(likes.id) AS acts FROM users LEFT JOIN likes ON users.id = likes.user_id LEFT JOIN posts 
ON users.id = posts.user_id GROUP BY users.id ORDER BY acts LIMIT 10;
