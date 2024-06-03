-- docker-compose  exec -it postgresql  psql -U postgres -f src/postgresql/function/ch08113.sql -d docker
--  関数作成 P8-11-3
-- 条件分岐を学習

DROP TABLE IF EXISTS tbl CASCADE ;
CREATE TABLE tbl(c1 int, c2 timestamp);

CREATE OR REPLACE FUNCTION test_func(int, timestamp) RETURNS integer AS $$
DECLARE
    r timestamp;
    result int :=0;
BEGIN
    FOR r IN SELECT c2 FROM tbl WHERE c1 = $1
    LOOP
        IF r < $2
    THEN
        result := result + 1;
        END IF;
    END LOOP;
    RETURN result;
END
$$ LANGUAGE plpgsql;

INSERT INTO tbl VALUES(1, '2020-01-01 00:00:00');
INSERT INTO tbl VALUES(1, '2024-01-01 00:00:00');

SELECT test_func(1, '2023-01-01 00:00:00');
SELECT test_func(1, '2025-01-01 00:00:00');



-- 確認
SELECT * FROM tbl;