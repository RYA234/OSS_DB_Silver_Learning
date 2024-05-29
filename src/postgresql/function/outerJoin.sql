-- outer JOINについて
-- docker-compose  exec -it postgresql  psql -U postgres -f src/postgresql/function/outerJoin.sql -d docker
-- 結合の種類
-- https://www.postgresql.jp/document/9.3/html/queries-table-expressions.html


-- 下準備
DROP TABLE IF EXISTS users CASCADE ;
CREATE TABLE users(id INTEGER,dept_name text,department_id INTEGER);
INSERT INTO users VALUES(1,'鈴木',2),(2,'佐藤',3),(3,'田中',4),(4,'渡辺',5);

DROP TABLE IF EXISTS dept CASCADE ;
CREATE TABLE dept(department_id INTEGER,name text);
INSERT INTO dept VALUES(1,'総務'),(2,'企画'),(3,'営業'),(4,'開発');

--  LEFT 結合
-- 左側のテーブルをすべて表示する。　左側に無いカラムはnullで表示する
SELECT * FROM users LEFT OUTER JOIN dept ON users.department_id = dept.department_id;

--  RIGHT 結合
-- 右側のテーブルをすべて表示する。　右側に無いカラムはnullで表示する
SELECT * FROM users RIGHT OUTER JOIN dept ON users.department_id = dept.department_id;

--  FULL 結合
-- LEFTとRIGHTの結果を合わせたもの
SELECT * FROM users FULL OUTER JOIN dept ON users.department_id = dept.department_id;



-- 後処理
DROP TABLE IF EXISTS users CASCADE ;
DROP TABLE IF EXISTS dept CASCADE ;
