-- 関数とプロシージャ
-- docker-compose  exec -it postgresql  psql -U docker -f src/postgresql/function/ch0811_function.sql -d docker
--  関数作成 P8-11-2
-- 各違いについて
-- 戻り値について　関数：有　プロシージャ：無
-- 呼び出し方法　関数:SELECT　プロシージャ:CALL
-- COMMIT/ROLLBACKできるか　関数：不可　プロシージャ：可

-- 二つのint型の和を出す関数
CREATE FUNCTION add_func(int,int) RETURNS bigint AS $$
SELECT ($1+$2)::bigint
$$LANGUAGE SQL;
-- 呼び出し
SELECT add_func(1,2);
\docker

-- レコードを追加する関数
CREATE TABLE tbl(col1 int,col2 text);
INSERT INTO tbl VALUES(1,'AAA');
CREATE FUNCTION select_func(int,text) RETURNS SETOF tbl AS $$
SELECT * FROM tbl WHERE col1 = $1 AND col2 = $2
$$ LANGUAGE SQL;
-- 呼び出し
SELECT select_func(1,'AAA');

-- テーブルにレコードを追加するプロシージャ
CREATE PRODEDURE insert_proc(int,text) AS $$
INSERT INTO tbl VALUES($1,$2)
$$ LANGUAGE SQL;
-- 呼び出し
CALL insert_proc(2,'BBBB');
SELECT * FROM tbl;