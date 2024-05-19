-- docker-compose  exec -it postgresql  psql -U docker -f src/postgresql/function/ch0808.sql -d docker
DROP TABLE IF EXISTS tbl CASCADE;
CREATE TABLE tbl(c1 int,c2 text,c3 text);

CREATE TRIGGER trg_1 After UPDATE OR INSERT ON tbl FOR EACH ROW
EXECUTE PROCEDURE  trg_f();

CREATE TRIGGER trg_2 AFTER UPDATE OF c1 ON tbl FOR EACH ROW
WHEN(OLD.c1 IS DISTINCT FROM  NEW.c1)
EXECUTE PROCEDURE trg_f();
