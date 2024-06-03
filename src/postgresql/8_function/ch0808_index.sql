-- indexの操作
--
-- docker-compose  exec -it postgresql  psql -U docker -f src/postgresql/function/ch0808_index.sql -d docker
DROP TABLE IF EXISTS tbl CASCADE;
CREATE TABLE tbl(c1 int,c2 text[],c3 point);
CREATE INDEX tbl_c1_idx ON tbl (c1);

CREATE INDEX tbl_c2 idx ON tbl USING gist(c3);


-- マルチカラムインデックス
-- 複数の列に対して作成できる。
DROP TABLE IF EXISTS tbl CASCADE;
CREATE TABLE tbl(c1 int,c2 int,c3 text);
CREATE INDEX m_idx ON tbl(c1,c2,c3);

-- 関数インデックス
DROP TABLE IF EXISTS tbl CASCADE;
CREATE TABLE tbl(c1 text, c2 text);
CREATE INDEX tbl_idx ON tbl((c1 || '-' || c2));
CREATE INDEX tbl_idx2 ON tbl(upper(c1));

-- 部分インデックス
DROP TABLE IF EXISTS tbl CASCADE;
CREATE TABLE tbl(c1 int,c2 text);
CREATE INDEX tbl_idx ON tbl(c1) WHERE c1 < 100;
