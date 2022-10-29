#!/bin/bash
chcp 65001

sqlite3 movies_rating.db < db_init.sql

echo "1. Найти все пары пользователей, оценивших один и тот же фильм. Устранить дубликаты, проверить отсутствие пар с самим собой. Для каждой пары должны быть указаны имена пользователей и название фильма, который они ценили."
echo --------------------------------------------------
sqlite3 movies_rating.db -box -echo "select u1.name as first_user, u2.name as second_user, m.title from ratings r1 join ratings r2 on r1.movie_id = r2.movie_id and r1.id > r2.id join users u1 on r1.user_id = u1.id join users u2 on r2.user_id = u2.id join movies m on r1.movie_id = m.id;"
echo " "

echo "2. Найти 10 самых свежих оценок от разных пользователей, вывести названия фильмов, имена пользователей, оценку, дату отзыва в формате ГГГГ-ММ-ДД."
echo --------------------------------------------------
sqlite3 movies_rating.db -box -echo "select m.title, u.name, r.rating, date(r.timestamp, 'unixepoch') as rated_at from ratings r join users u on r.user_id = u.id join movies m on r.movie_id = m.id group by u.name order by rated_at desc limit 10;"
echo " "

echo "3. Вывести в одном списке все фильмы с максимальным средним рейтингом и все фильмы с минимальным средним рейтингом. Общий список отсортировать по году выпуска и названию фильма. В зависимости от рейтинга в колонке "Рекомендуем" для фильмов должно быть написано "Да" или "Нет"."
echo --------------------------------------------------
sqlite3 movies_rating.db -box -echo "select title, year, case when avg_rating = max_rating then 'Да' else 'Нет' end as 'Рекомендуем' from(select m.title, m.year, round(avg(r.rating), 2) as avg_rating, max(round(avg(r.rating), 2)) over() as max_rating, min(round(avg(r.rating), 2)) over() as min_rating from ratings r join movies m on r.movie_id = m.id group by r.movie_id) where avg_rating = max_rating or avg_rating = min_rating order by year, title;"
echo " "

echo "4. Вычислить количество оценок и среднюю оценку, которую дали фильмам пользователи-женщины в период с 2010 по 2012 год."
echo --------------------------------------------------
sqlite3 movies_rating.db -box -echo "select count(*) as ratings_count, round(avg(r.rating), 2) as average_rating from ratings r join users u on r.user_id = u.id where u.gender = 'female' and datetime(r.timestamp, 'unixepoch') between '2010-01-01' and '2012-01-01';"
echo " "

echo "5. Составить список фильмов с указанием их средней оценки и места в рейтинге по средней оценке. Полученный список отсортировать по году выпуска и названиям фильмов. В списке оставить первые 20 записей."
echo --------------------------------------------------
sqlite3 movies_rating.db -box -echo "select title, year,  round(avg(r.rating), 2) as rating_average, rank() over(order by avg(r.rating) desc) as rating_pos from movies m join ratings r on m.id = r.movie_id group by m.id order by year, title limit 20;"
echo " "

echo "6. Вывести список из 10 последних зарегистрированных пользователей в формате \"Фамилия Имя Дата регистрации\" (сначала фамилия, потом имя)."
echo --------------------------------------------------
sqlite3 movies_rating.db -box -echo "select substr(name, instr(name, ' ') + 1) || ' ' || substr(name, 1, instr(name, ' ')  - 1) as name, register_date from users order by register_date desc limit 10;"
echo " "

echo "7. С помощью рекурсивного CTE составить таблицу умножения для чисел от 1 до 10. Должен получиться один столбец следующего вида:"
echo --------------------------------------------------
sqlite3 movies_rating.db -box -echo "with recursive mult_table(res, kol) as (select '1x1=1', 1 union all select cast(kol / 10 + 1 as text) || 'x' || cast(kol % 10 + 1 as text) || '=' || cast((kol / 10 + 1) * (kol % 10 + 1) as text), kol + 1 from mult_table limit 100) select res from mult_table;"
echo " "

echo "8. С помощью рекурсивного CTE выделить все жанры фильмов, имеющиеся в таблице movies (каждый жанр в отдельной строке)."
echo --------------------------------------------------
sqlite3 movies_rating.db -box -echo "with recursive find_genres(genres, str) as ( select substr(m.genres || '|', 1, instr(m.genres || '|', '|') - 1), substr(m.genres || '|', instr(m.genres || '|', '|') + 1) from movies m union all select substr(str, 1, instr(str, '|') - 1), substr(str, instr(str, '|') + 1) from find_genres where str != '') select distinct genres from find_genres;"