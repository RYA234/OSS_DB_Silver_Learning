-- デッドロック　再現する
-- tx1.sqlと同時に以下コマンドを実行する
-- docker-compose  exec -it postgresql  psql -U docker -f src/postgresql/transaction/ch104lock/dead/tx2.sql -d docker
SELECT pg_sleep(2); -- t=2 tx1がトランザクションを開始するのを待つ
BEGIN;
SELECT pg_sleep(4); -- t=6 tx1が1回目のFOR UPDATEを実行するのを待つ


-- tx2 がtbl2をロック
SELECT * FROM tbl2 WHERE id = 1 FOR UPDATE;
SELECT pg_sleep(4); -- t=10 tx1が2回目のFOR UPDATEを実行するのを待つ
-- tx2 がtbl1をロック
SELECT * FROM tbl1 WHERE id = 1 FOR UPDATE;

-- エラーになる以下メッセージが表示される
-- psql:src/postgresql/transaction/ch104lock/dead/tx2.sql:13: ERROR:  deadlock detected
-- DETAIL:  Process 45 waits for ShareLock on transaction 967; blocked by process 39.
-- Process 39 waits for ShareLock on transaction 968; blocked by process 45.
-- HINT:  See server log for query details.
-- CONTEXT:  while locking tuple (0,1) in relation "tbl1"