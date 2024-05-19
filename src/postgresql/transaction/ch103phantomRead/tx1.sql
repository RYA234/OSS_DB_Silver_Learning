-- docker-compose  exec -it postgresql  psql -U docker -f src/postgresql/transaction/ch103phantomRead/tx1.sql -d docker
DROP TABLE IF EXISTS tbl CASCADE;
CREATE TABLE tbl(id int,value int);
GRANT ALL ON tbl TO tx2;
INSERT INTO tbl VALUES(1,5),(2,8);
SELECT * FROM tbl;
BEGIN;
SET TRANSACTION ISOLATION LEVEL  READ COMMITTED ;
SHOW transaction_isolation;
SELECT pg_sleep(4);
UPDATE tbl SET value=10 WHERE id=1;
SELECT pg_sleep(4);
INSERT INTO tbl VALUES(3,12);
COMMIT;
SELECT * FROM tbl;
SELECT pg_sleep(4);
-- SELECT * FROM tbl ORDER BY id;
-- SELECT pg_sleep(4);
