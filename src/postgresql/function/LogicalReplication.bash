# ロジカルレプリケーション
# 前準備　コンテナとVolumeを削除して初期化しておく
# docker-compose build
# docker-compose up -d
# source src/postgresql/function/LogicalReplication.bash

docker exec --user postgres  postgresql  bash      -c "echo \"-----------wal_levelを変更する-----------\""
docker exec --user  postgres  postgresql  bash     -c "sed -i -e \"s/replica/logical/g\" /var/lib/postgresql/data/postgresql.conf"
docker exec --user  postgres  postgresql  bash     -c "sed -i -e \"s/#wal_level/wal_level/g\" /var/lib/postgresql/data/postgresql.conf"
docker exec --user postgres  postgresql  bash      -c "grep -E wal_level /var/lib/postgresql/data/postgresql.conf"
docker exec --user postgres  postgresql  bash      -c "echo \"----------テーブルを作成して、レコードを一件追加する。-----------\""
docker exec --user postgres  postgresql  bash      -c "pg_ctl restart -D /var/lib/postgresql/data"
sleep 7
docker-compose up -d
docker exec --user postgres  postgresql  bash      -c "echo \"----------テーブルを作成して、レコードを一件追加する。-----------\""
docker exec --user postgres  postgresql  bash      -c "createdb pub"
docker exec -it postgresql  psql -U docker         -c "DROP TABLE IF EXISTS tbl CASCADE;"
docker exec -it postgresql  psql -U docker -d pub  -c "CREATE TABLE tbl(id int);"
docker exec -it postgresql  psql -U docker -d pub  -c "INSERT INTO tbl VALUES(1),(2);"
docker exec -it postgresql  psql -U docker -d pub  -c "CREATE PUBLICATION publication FOR TABLE tbl;"


docker exec -it postgresql  psql -U docker -d pub         -c "CREATE PUBLICATION publication FOR TABLE tbl;"
docker exec --user postgres  postgresql  bash      -c "mkdir /var/lib/postgresql/pgdata3"
docker exec --user postgres  postgresql  bash      -c "initdb --encoding=UTF8 --no-locale /var/lib/postgresql/pgdata3"


docker exec --user postgres  postgresql  bash      -c "chmod u=rwx -R /var/lib/postgresql/pgdata3"
docker exec --user postgres  postgresql  bash      -c "chmod g=rx -R /var/lib/postgresql/pgdata3"
docker exec --user postgres  postgresql  bash      -c "chmod 700 /var/lib/postgresql/pgdata3"
docker exec --user postgres  postgresql  bash      -c "echo \"-----------サブスクライバーのポート番号変更とgrepで確認-----------\""
docker exec --user  postgres  postgresql  bash     -c "sed -i -e \"s/5432/5433/g\" /var/lib/postgresql/pgdata3/postgresql.conf"
docker exec --user  postgres  postgresql  bash     -c "sed -i -e \"s/#port/port/g\" /var/lib/postgresql/pgdata3/postgresql.conf"
docker exec --user postgres  postgresql  bash      -c "grep -E 5433 /var/lib/postgresql/pgdata3/postgresql.conf"

docker exec --user postgres  postgresql  bash      -c "pg_ctl start -D /var/lib/postgresql/pgdata3"
sleep 5

docker exec --user postgres  postgresql  bash      -c "createdb -p 5433 sub"

docker exec -it postgresql  psql -U postgres -p 5433 -c "CREATE TABLE tbl(id int);"

docker exec -it postgresql  psql -U postgres -p 5433 -c "CREATE SUBSCRIPTION subscription
                                                       CONNECTION 'host=localhost port=5432 dbname=pub'
                                                       PUBLICATION publication;"

docker exec -it postgresql  psql -U postgres -p 5433 -c "SELECT id FROM tbl;"
docker exec -it postgresql  psql -U postgres -p 5433 -c "INSERT INTO tbl VALUES(3);"


