-- 行ロック　再現する
-- tx1.sqlと同時に以下コマンドを実行する
-- docker-compose  exec -it postgresql  psql -U docker -f src/postgresql/transaction/ch104lock/row/OK/tx2.sql -d docker
SELECT pg_sleep(2); -- t=2 tx1がトランザクションを開始するのを待つ
BEGIN;
SELECT pg_sleep(4); -- t=6 tx1がvalue=0に更新し、COMMITするのを待つ
UPDATE tbl SET value = value -10 WHERE id=1; -- エラーになる