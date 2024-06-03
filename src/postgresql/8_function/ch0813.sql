-- docker-compose  exec -it postgresql  psql -U docker -f src/postgresql/function/ch0813.sql -d docker
--  関数作成 P8-13

DROP TABLE IF EXISTS f_tbl CASCADE ;
CREATE TABLE f_tbl(c1 text,c2 text);
INSERT INTO f_tbl VALUES('AAA','2020-01-01 00:00:00');
INSERT INTO f_tbl VALUES('BBB','2020-01-01 00:00:00');

CREATE MATERIALIZED VIEW daily_report (name,message) AS SELECT * FROM f_tbl;

SELECT * from daily_report;

SELECT count(*) FROM daily_report WHERE name = 'AAA';

REFRESH MATERIALIZED VIEW daily_report;