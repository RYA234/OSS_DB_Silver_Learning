-- UNION EXCEPT INTERSECT
-- docker-compose  exec -it postgresql  psql -U docker -f src/postgresql/function/ch08112_union.sql -d docker
DROP TABLE IF EXISTS tbl1 CASCADE;
DROP TABLE IF EXISTS tbl2 CASCADE;
CREATE TABLE tbl1(id int,name text);
INSERT INTO tbl1 VALUES(1,'AAA'),(2,'BBB'),(3,'CCC');

CREATE TABLE tbl2(id int,name text);

INSERT INTO tbl2 VALUES(2,'BBB'),(3,'CCC'),(4,'DDD');

-- 和集合 4レコード
SELECT * FROM tbl1 UNION ALL SELECT * FROM tbl2 ORDER BY id;

-- 和集合 重複部分も含める　結果は6レコード
SELECT * FROM tbl1 UNION SELECT * FROM tbl2 ORDER BY id;
-- データ型の不一致
SELECT id,name FROM tbl2 UNION SELECT name, id FROM tbl2 ORDER BY id;
-- 差集合(EXCEPT) 左側のSELECT文から右側のSELECT文を引く。結果は1レコード
SELECT * FROM tbl1 EXCEPT SELECT * FROM tbl2 ORDER BY id;

-- INTERSECT ？？？
-- 双方のSQL文で共通するレコードを取得する。結果は2レコード
SELECT * from tbl1 INTERSECT SELECT * from tbl2 order by id;