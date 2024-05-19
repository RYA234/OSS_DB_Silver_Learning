-- docker-compose  exec -it postgresql  psql -U docker -f src/postgresql/transaction/ch1033tx1serializable.sql -d docker
DROP TABLE IF EXISTS tbl CASCADE;
CREATE TABLE tbl(id int,value int);
GRANT ALL ON tbl TO tx2;
INSERT INTO tbl VALUES(1,100),(2,150),(3,200);
SELECT * FROM tbl;
SELECT pg_sleep(2);
BEGIN;
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
SHOW default_transaction_isolation;
SELECT pg_sleep(4);
UPDATE tbl SET value=150 WHERE id=1;
SELECT * FROM tbl ORDER BY id;

SELECT pg_sleep(4);
COMMIT;

SELECT pg_sleep(2);
