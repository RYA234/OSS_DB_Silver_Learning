-- デッドロック　再現する
-- tx2.sqlと同時に以下コマンドを実行する
-- docker-compose  exec -it postgresql  psql -U docker -f src/postgresql/transaction/ch104lock/dead/tx1.sql -d docker
-- t=0のときの処理　テーブルの準備 トランザクション開始
DROP TABLE IF EXISTS tbl1 CASCADE;
CREATE TABLE tbl1(id int,value int);
GRANT ALL ON tbl1 TO tx2;
INSERT INTO tbl1 VALUES(1,10),(2,3);


-- tbl2
DROP TABLE IF EXISTS tbl2 CASCADE;
CREATE TABLE tbl2(id int,value int);
GRANT ALL ON tbl2 TO tx2;
INSERT INTO tbl2 VALUES(1,10),(2,3);

BEGIN;
SELECT pg_sleep(4); --t=4 tx2がトランザクションを開始するのを待つ

-- tx1 がtbl1をロック
SELECT * FROM tbl1 WHERE id = 1 FOR UPDATE;

SELECT pg_sleep(4); --t=8 tx2がトランザクションを開始するのを待つ

-- tx1 がtbl1をロック
SELECT * FROM tbl2 WHERE id = 1 FOR UPDATE;

COMMIT;


