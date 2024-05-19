-- docker-compose  exec -it postgresql  psql -U docker -f src/postgresql/function/ch1002.sql -d docker
-- BEGIN COMMIT ROLLBACK

DROP TABLE IF EXISTS tbl CASCADE;
## COMMITの確認↓
CREATE TABLE tbl(c1 int);
START TRANSACTION;
INSERT INTO tbl VALUES(1);
SELECT * FROM tbl;
COMMIT;
## COMMITの確認↑


## ROLLBACKの確認↓
SELECT * FROM tbl;
BEGIN;
INSERT INTO tbl VALUES(2);
SELECT * FROM tbl;
ROLLBACK;
## ROLLBACKの確認↑

## ABORTの確認↓
SELECT * FROM tbl;

BEGIN;
INSERT INTO no-exists VALUES(3);
INSERT INTO tbl VALUES(3);
ABORT;
## ABORTの確認↑