## Лабораторная работа 2. Подготовка скриптов для создания таблиц и добавления данных

### Задание
Организовать процесс ETL (Extract, Transform, Load) для переноса исходных данных в БД SQLite. Написать утилиту, генерирующую SQL-скрипт db_init.sql для автоматического создания таблиц в базе (CREATE TABLE ...)  и загрузки в них данных (INSERT INTO ...)  из исходных текстовых файлов, которые нужно скопировать из каталога dataset. 
* Утилита должна быть кроссплатформенной (запускаться на разных платформах). Предлагаемые языки: Python, PowerShell. 
* База данных должна называться movies_rating.db.
* Таблицы: 
    * *movies*. Поля id (primary key), title, year, genres.
    * *ratings*. Поля id (primary key), user_id, movie_id, rating, timestamp.
    * *tags*. Поля id (primary key), user_id, movie_id, tag, timestamp.
    * *users*. Поля id (primary key), name, email, gender, register_date, occupation.
* Типы и размеры полей в таблице должны соответствовать структуре исходных текстовых файлов с данными.
* Если в момент запуска утилиты в базе movies_rating.db уже есть таблицы, их нужно удалить и создать заново.
* Утилита генерации SQL-скрипта и его исполнения с помощью sqlite3  должна запускаться кроссплатформенным shell-скриптом db_init.bat:
    * В первой строке этого файла разместить шебанг `#!/bin/bash`
    * Во второй строке написать команду для запуска утилиты (например, `python3 make_db_init.py`).
    * В третьей строке написать команду для загрузки созданного SQL-скрипта в базу movies_rating.db: `sqlite3 movies_rating.db < db_init.sql`
    * После добавления файла db_init.bat в индекс локального репозитория Git (то есть после выполнения команды `git add ...`) нужно сделать этот файл исполняемым для Linux: `git update-index --chmod=+x db_init.bat`.


* * *
### Требования к оформлению и коду
* Работать нужно в ветке Task02 Git-репозитория.
* Все файлы разместить в каталоге Task02.
* В файле README.md описать требования к окружению для корректной работы скрипта db_init.bat (например, на компьютере должны быть установлены Python v.3 и SQLite), после выполнения которого должна создаться заполненная база данных db_init.db.

* * *
### Дополнительные лекции
* Исполняемые файлы в Windows и Unix-подобных системах https://youtu.be/yuSveRKLUzg

* * *

### Отправка задания на проверку
Процедура отправки задания на проверку и манипуляции с репозиториями после проверки описаны в файле [Git_instruction.md](Git_instruction.md).

* * *
### Темы для изучения
* Встраиваемая СУБД SQLite.
    * <https://www.sqlite.org/docs.html> Документация на официальном сайте SQLite.
    * J.A. Kreibich "Using SQLite". Издательство O'Reilly, 2010 год.
    * G. Allen, M. Owens "The Definitive Guide to SQLite", second edition. Издательство Apres, 2010 год.
* Язык разметки Markdown.
    * <https://guides.hexlet.io/markdown/> Описание основных возможностей.
    * <https://guides.github.com/pdfs/markdown-cheatsheet-online.pdf> Шпаргалка (cheatsheet).
