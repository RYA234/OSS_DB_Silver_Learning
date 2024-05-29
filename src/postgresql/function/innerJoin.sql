-- 内部結合について
-- docker-compose  exec -it postgresql  psql -U postgres -f src/postgresql/function/innerJoin.sql -d docker
-- https://www.postgresql.jp/docs/9.2/queries-table-expressions.html

-- 下準備
DROP TABLE IF EXISTS users CASCADE ;
CREATE TABLE users(id INTEGER,dept_name text,department_id INTEGER);
INSERT INTO users VALUES(1,'鈴木',2),(2,'佐藤',3),(3,'田中',4),(4,'渡辺',5);

DROP TABLE IF EXISTS dept CASCADE ;
CREATE TABLE dept(department_id INTEGER,name text);
INSERT INTO dept VALUES(1,'総務'),(2,'企画'),(3,'営業'),(4,'開発');

-- users とdeptのカラムをそのまま接続して表示する
SELECT * FROM users INNER JOIN dept ON users.department_id = dept.department_id;


--USINGを使った場合、重複しているところはまとめられ、一番左に出力される。
-- カラム名が同じである必要がある
SELECT * FROM users INNER JOIN dept USING (department_id);

-- 後処理
DROP TABLE IF EXISTS users CASCADE ;
DROP TABLE IF EXISTS dept CASCADE ;
