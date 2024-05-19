-- docker-compose  exec -it postgresql  psql -U docker -f src/postgresql/function/ch0811.sql -d docker
--  関数作成 P8-11-2

CREATE FUNCTION add_func(int,int) RETURNS bigint AS $$
SELECT ($1+$2)::bigint
$$LANGUAGE SQL;
SELECT add_func(1,2);

\docker

-- レコードを追加する関数
CREATE TABLE tbl(col1 int,col2 text);
INSERT INTO tbl VALUES(1,'AAA');
CREATE FUNCTION select_func(int,text) RETURNS SETOF tbl AS $$
SELECT * FROM tbl WHERE col1 = $1 AND col2 = $2
$$ LANGUAGE SQL;
SELECT select_func(1,'AAA');


CREATE PRODEDURE insert_proc(int,text) AS $$
INSERT INTO tbl VALUES($1,$2)
$$ LANGUAGE SQL;
CALL insert_proc(2,'BBBB');
SELECT * FROM tbl;