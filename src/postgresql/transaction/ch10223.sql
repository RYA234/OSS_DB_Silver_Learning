DROP TABLE IF EXISTS tbl CASCADE;
## COMMITの確認↓
CREATE TABLE tbl(c1 int);

BEGIN;
INSERT INTO tbl VALUES(1);
SELECT * FROM tbl;

SAVEPOINT sp1;
INSERT INTO tbl VALUES(2);

SAVEPOINT sp2;
INSERT INTO tbl VALUES(3);

SAVEPOINT sp3;
INSERT INTO tbl VALUES(4);
SELECT * FROM tbl;


ROLLBACK TO sp2;
SELECT * FROM tbl;

