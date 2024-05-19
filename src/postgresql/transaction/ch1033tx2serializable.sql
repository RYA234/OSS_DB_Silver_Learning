-- bashを2つ開いて、実行する
-- docker-compose  exec -it postgresql  psql -U tx2 -f src/postgresql/transaction/ch1033tx2serializable.sql -d docker
\dt;
SELECT pg_sleep(4);
BEGIN;
SET TRANSACTION ISOLATION LEVEL SERIALIZABLE;
SHOW default_transaction_isolation;
SELECT pg_sleep(4);
SELECT * FROM tbl ORDER BY id;

SELECT pg_sleep(4);
SELECT * FROM tbl ORDER BY id;

COMMIT;