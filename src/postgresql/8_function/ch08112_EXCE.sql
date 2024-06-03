-- UNION EXCEPT INTERSECT
-- 

CREATE TABLE tbl1(id int,name text);
INSERT INTO tbl1 VALUES(1,'AAA'),(2,'BBB'),(3,'CCC');

CREATE TABLE tbl2(id int,name text);

INSERT INTO tbl2 VALUES(2,'BBB'),(3,'CCC'),(4,'DDD');

-- 和集合 4レコード
SELECT * FROM tbl1 UNION ALL SELCT * FROM tbl2 ORDER BY id;

-- 和集合 重複部分も含める　結果は6レコード
SELECT * FROM tbl UNION SELECT * FROM tbl2 ORDER BY id;
-- データ型の不一致
SELECT id,name FROM tbl2 UNION SELECT name, id FROM tbl2 ORDER BY id;