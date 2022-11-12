pragma foreign_keys = ON;

insert into users(name, surname, email, gender, register_date, occupation_id) values
("Dmitriy", "Katin", "dmitriykatinn@gmail.com", "male", DATE("now"), (select id from occupations where occupations.title = "student"));
insert into users(name, surname, email, gender, register_date, occupation_id) values
("Pavel", "Kochetkov", "pavel.kochetkov@gmail.com", "male", DATE("now"), (select id from occupations where occupations.title = "student"));
insert into users(name, surname, email, gender, register_date, occupation_id) values
("Margar", "Melkonyan", "margar.melkonyan@gmail.com", "male", DATE("now"), (select id from occupations where occupations.title = "student"));
insert into users(name, surname, email, gender, register_date, occupation_id) values
("Egor", "Melyakin", "egor.melyakin@gmail.com", "male", DATE("now"), (select id from occupations where occupations.title = "student"));
insert into users(name, surname, email, gender, register_date, occupation_id) values
("Maksim", "Negrya", "maksim.negrya@gmail.com", "male", DATE("now"), (select id from occupations where occupations.title = "student"));


insert into movies(title, year) values
("The Witcher", 2019);
insert into movies(title, year) values
("1917", 2019);
insert into movies(title, year) values
("Unthinkable", 2009);


insert into ratings(user_id, movie_id, rating, "timestamp") values(
(select id from users where users.email = "dmitriykatinn@gmail.com"), 
(select id from movies where movies.title = "The Witcher" and movies.year = 2019),
4, strftime('%s','now'));
insert into ratings(user_id, movie_id, rating, "timestamp") values(
(select id from users where users.email = "dmitriykatinn@gmail.com"), 
(select id from movies where movies.title = "1917" and movies.year = 2019),
4.5, strftime('%s','now'));
insert into ratings(user_id, movie_id, rating, "timestamp") values(
(select id from users where users.email = "dmitriykatinn@gmail.com"), 
(select id from movies where movies.title = "Unthinkable" and movies.year = 2009),
4, strftime('%s','now'));