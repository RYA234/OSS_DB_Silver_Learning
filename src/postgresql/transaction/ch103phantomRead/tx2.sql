-- docker-compose  exec -it postgresql  psql -U tx2 -f src/postgresql/transaction/ch103phantomRead/tx2.sql -d docker

SELECT pg_sleep(2);
BEGIN;
SET TRANSACTION ISOLATION LEVEL  READ COMMITTED;

SHOW transaction_isolation;
SELECT pg_sleep(4);
SELECT * FROM tbl;
SELECT pg_sleep(4);
SELECT * FROM tbl;

COMMIT;
