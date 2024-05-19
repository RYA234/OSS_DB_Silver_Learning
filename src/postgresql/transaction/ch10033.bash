# 分離性の振る舞い Readcommited
# 前準備　コンテナとVolumeを削除して初期化しておく
# docker-compose build
# docker-compose up -d
# source src/postgresql/transaction/ch10033.bash

## ReadCommited　の場合↓


# 下準備
docker exec -it postgresql  psql -U docker            -c "DROP TABLE IF EXISTS tbl CASCADE;"
docker exec -it postgresql  psql -U docker            -c "CREATE TABLE tbl(id int,value int);"
docker exec -it postgresql  psql -U docker            -c "GRANT ALL ON tbl TO tx2;"
docker exec -it postgresql  psql -U tx2 -d docker     -c "\dt;"
docker exec -it postgresql  psql -U docker            -c "INSERT INTO tbl VALUES(1,100),(2,150),(3,200);"
docker exec -it postgresql  psql -U docker            -c "SELECT * FROM tbl;"
# 開始
docker exec -it postgresql  psql -U docker            -c "BEGIN;"
docker exec -it postgresql  psql -U docker            -c "SET TRANSACTION ISOLATION LEVEL READ COMMITTED;"
docker exec -it postgresql  psql -U docker            -c "SHOW default_transaction_isolation;"
docker exec -it postgresql  psql -U tx2 -d docker     -c "BEGIN;"
docker exec -it postgresql  psql -U tx2 -d docker     -c "SET TRANSACTION ISOLATION LEVEL READ COMMITTED;"
docker exec -it postgresql  psql -U tx2 -d docker     -c "SHOW default_transaction_isolation;"
docker exec -it postgresql  psql -U docker            -c "UPDATE tbl SET value=150 WHERE id=1;"
docker exec -it postgresql  psql -U docker            -c "SELECT * FROM tbl ORDER BY id;"
# 更新結果を確認できない
docker exec --user postgres  postgresql  bash         -c "echo \"----------tx2結果hが反映されない-----------\""
docker exec -it postgresql  psql -U tx2 -d docker     -c "SELECT * FROM tbl ORDER BY id;"
docker exec -it postgresql  psql -U docker            -c "COMMIT;"
# 更新結果を確認できる
docker exec -it postgresql  psql -U tx2 -d docker     -c "SELECT * FROM tbl ORDER BY id;"
docker exec -it postgresql  psql -U tx2 -d docker     -c "COMMIT;"

## ReadCommited　の場合↑


# 下準備
# docker exec -it postgresql  psql -U docker         -c "DROP TABLE IF EXISTS tbl CASCADE;"
# docker exec -it postgresql  psql -U docker         -c "CREATE TABLE tbl(id int,value int);"
# docker exec -it postgresql  psql -U docker -       -c "INSERT INTO tbl VALUES(1,100),(2,150),(3,200);"
# docker exec -it postgresql  psql -U docker -       -c "SELECT * FROM tbl;"
