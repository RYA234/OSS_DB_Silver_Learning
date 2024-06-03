-- CROSS JOINについて
-- docker-compose  exec -it postgresql  psql -U postgres -f src/postgresql/function/crossJoin.sql -d docker
-- https://www.postgresql.jp/docs/9.2/queries-table-expressions.html

-- 下準備
DROP TABLE IF EXISTS users CASCADE ;
CREATE TABLE users(id INTEGER,dept_name text,department_id INTEGER);
INSERT INTO users VALUES(1,'鈴木',2),(2,'佐藤',3),(3,'田中',4),(4,'渡辺',5);

DROP TABLE IF EXISTS dept CASCADE ;
CREATE TABLE dept(department_id INTEGER,name text);
INSERT INTO dept VALUES(1,'総務'),(2,'企画'),(3,'営業'),(4,'開発');

-- CROSS JOIN
--- ２つのテーブルのレコード数を掛け合わせた数だけ結合される
--- 今回の場合は　4*4 = 16個のレコードが表示される。
--- 用途がわからない
SELECT * FROM users CROSS JOIN dept;

-- 後処理
DROP TABLE IF EXISTS users CASCADE ;
DROP TABLE IF EXISTS dept CASCADE ;
