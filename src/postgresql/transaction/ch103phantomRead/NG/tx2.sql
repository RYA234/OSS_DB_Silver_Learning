-- Phantom Readが再現しない ターミナル２で実行する
-- docker-compose  exec -it postgresql  psql -U tx2 -f src/postgresql/transaction/ch103phantomRead/NG/tx2.sql -d docker

SELECT pg_sleep(2); -- tx1.sql のトランザクション開始を待つ
BEGIN;
-- Phantom Readが発生しないように設定。
SET TRANSACTION ISOLATION LEVEL  SERIALIZABLE; 

SHOW transaction_isolation;
SELECT pg_sleep(4); -- tx1.sql の更新を待つ
SELECT * FROM tbl;
SELECT pg_sleep(4); -- tx1.sql の挿入を待つ
SELECT * FROM tbl;  -- ファントムリードは発生しない

COMMIT;
