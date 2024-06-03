-- シーケンス
-- 自動で連番を追い出してくれるオブジェクト
-- docker-compose  exec -it postgresql  psql -U docker -f src/postgresql/function/ch0806_sequence.sql -d docker
-- https://www.postgresql.jp/document/7.3/user/functions-sequence.html

DROP SEQUENCE IF EXISTS seq CASCADE ;
-- この時点ではseq=0
CREATE SEQUENCE seq;

-- 新しい値の取り出し seq=1
SELECT nextval('seq');
-- 現在値の確認 seq=1
SELECT currval('seq');
-- 新しい値の取り出し seq=1
SELECT nextval('seq');


DROP SEQUENCE IF EXISTS seq10 CASCADE ;
-- 初期値100 増加量10のシーケンスを作成
CREATE SEQUENCE seq10 START 100 INCREMENT 10;
-- 新しい値の取り出し seq=20
SELECT nextval('seq10');
-- 新しい値の取り出し seq=30
SELECT nextval('seq10');
-- 新しい値に設定 seq =100
SELECT setval('seq',100);
-- 現在値の確認 seq=100
SELECT currval('seq')

--後処理
DROP SEQUENCE IF EXISTS seq CASCADE ;
DROP SEQUENCE IF EXISTS seq10 CASCADE ;