

# ストリーミングレプリケーション
# 前準備　コンテナとVolumeを削除して初期化しておく
# docker-compose build
# docker-compose up -d
# source src/postgresql/function/tableSpace.bash
docker exec -it postgresql  psql -U docker         -c "\d"
docker exec --user postgres  postgresql  bash      -c "chmod a+rwx -R /var/lib/postgresql/"
docker exec --user postgres  postgresql  bash      -c "echo \"-----------バックアップの開始-----------\""
docker exec --user postgres postgresql bash            -c "pg_basebackup -D /var/lib/postgresql/pgdata2 -R"
docker exec --user postgres  postgresql  bash      -c "echo \"-----------バックアップの終了-----------\""
docker exec --user postgres  postgresql  bash      -c "chmod a+rwx -R /var/lib/postgresql/"
docker exec --user postgres  postgresql  bash      -c "echo \"-----------サブスクライバーのポート番号変更とgrepで確認-----------\""
docker exec --user  postgres  postgresql  bash     -c "sed -i -e \"s/5432/5433/g\" /var/lib/postgresql/pgdata2/postgresql.conf"
docker exec --user  postgres  postgresql  bash     -c "sed -i -e \"s/#port/port/g\" /var/lib/postgresql/pgdata2/postgresql.conf"
docker exec --user postgres  postgresql  bash      -c "grep -E 5433 /var/lib/postgresql/pgdata2/postgresql.conf"
docker exec --user postgres  postgresql  bash      -c "chmod 700 /var/lib/postgresql/pgdata2"

docker exec --user postgres  postgresql  bash      -c "pg_ctl start -D /var/lib/postgresql/pgdata2"
docker exec --user postgres  postgresql  bash      -c "echo \"-----------プライマリにおいてtblテーブルが存在しないことを確認-----------\""
docker exec -it postgresql  psql -U docker         -c "\d"
docker exec --user postgres  postgresql  bash      -c "echo \"-----------サブスクライバーにおいてtblテーブルが存在しないことを確認-----------\""
docker exec -it postgresql  psql -U docker -p 5433 -c "\d"

docker exec -it postgresql  psql -U docker         -c "DROP TABLE IF EXISTS tbl CASCADE;"
docker exec -it postgresql  psql -U docker         -c "CREATE TABLE tbl(id int);"
docker exec --user postgres  postgresql  bash      -c "echo \"-----------プライマリにおいて追加と参照できる-----------\""
docker exec -it postgresql  psql -U docker         -c "INSERT INTO tbl VALUES(1),(2);"
docker exec -it postgresql  psql -U docker         -c "SELECT * FROM tbl;"

#サブスクライバーでは追加☓　参照◯
docker exec -it postgresql  psql -U docker -p 5433 -c "SELECT * FROM tbl;"
docker exec -it postgresql  psql -U docker -p 5433 -c "INSERT INTO tbl VALUES(1),(2);"
