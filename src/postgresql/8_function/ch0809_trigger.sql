-- docker-compose  exec -it postgresql  psql -U docker -f src/postgresql/function/ch0809_trigger.sql -d docker
-- 下準備
DROP TABLE IF EXISTS tbl CASCADE;

DROP FUNCTION  IF EXISTS  trg_f1;
DROP FUNCTION  IF EXISTS  trg_f2;

CREATE TABLE tbl(c1 int,c2 text,c3 text);

DROP TRIGGER IF EXISTS trg_1 ON tbl;
DROP TRIGGER IF EXISTS trg_2 ON tbl;



-- trg_1で実行する関数を定義
CREATE OR REPLACE FUNCTION trg_f1()
RETURNS TRIGGER AS $$
BEGIN
    SELECT CURRENT_USER;
    RETURN NEW; -- トリガー関数はトリガーイベントが起こった後に呼ばれるため、NEWを返す必要があります
END;
$$ LANGUAGE plpgsql;

-- トリガーtrg_1を作成
CREATE TRIGGER trg_1 After UPDATE OR INSERT ON tbl FOR EACH ROW -- tblに対してUpdate,Insertが実行されるとトリガを作成
EXECUTE Function  trg_f1();  -- トリガを実行

-- trg_2で実行する関数を定義
CREATE OR REPLACE FUNCTION trg_f2()
RETURNS TRIGGER AS $$
BEGIN
    SELECT version();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

--トリガーtrg_02を作成
CREATE TRIGGER trg_2 AFTER UPDATE OF c1 ON tbl FOR EACH ROW
WHEN(OLD.c1 IS DISTINCT FROM  NEW.c1)
EXECUTE FUNCTION trg_f2();

-- trg_1の動作確認 現在のユーザーが追加される
INSERT INTO tbl VALUES(1,'test','test');
