-- 行ロック　再現する
-- tx2.sqlと同時に以下コマンドを実行する
-- docker-compose  exec -it postgresql  psql -U docker -f src/postgresql/transaction/ch104lock/row/OK/tx1.sql -d docker
-- t=0のときの処理　テーブルの準備
DROP TABLE IF EXISTS tbl CASCADE;
CREATE TABLE tbl(id int,value int CHECK (value > -1));
GRANT ALL ON tbl TO tx2;
INSERT INTO tbl VALUES(1,10);


BEGIN;
SELECT pg_sleep(4); --t=4 tx2がトランザクションを開始するのを待つ

SELECT * FROM tbl;
UPDATE tbl SET value = value -10 WHERE id=1;
COMMIT;


