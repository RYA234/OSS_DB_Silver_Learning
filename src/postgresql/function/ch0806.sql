-- docker-compose  exec -it postgresql  psql -U docker -f src/postgresql/function/ch0806.sql -d docker
DROP SEQUENCE IF EXISTS seq CASCADE ;
CREATE SEQUENCE seq;
SELECT nextval('seq');
SELECT currval('seq');
SELECT nextval('seq');

DROP SEQUENCE IF EXISTS seq10 CASCADE ;
CREATE SEQUENCE seq10 START 100 INCREMENT 10;
SELECT nextval('seq10');

SELECT nextval('seq10');

SELECT setval('seq',100);

SELECT currval('seq')
