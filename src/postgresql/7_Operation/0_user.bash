#SQL文を使用しないで、を作成
# source src/postgresql/7_Operation/0_user.bash
# メタコマンド
# https://www.postgresql.jp/document/7.2/reference/app-psql.html


# ユーザーを追加
docker exec --user postgres  postgresql  bash      -c "createuser user1"
# 追加を確認
docker exec -it postgresql  psql -U docker         -c "\du"


# ユーザーの権限を変更
docker exec -it postgresql  psql -U postgres         -c "ALTER USER user1 WITH REPLICATION;"

# 権限が変更されていることを確認
docker exec -it postgresql  psql -U docker         -c "\du"

# ユーザーを削除
docker exec --user postgres  postgresql  bash      -c "dropuser user1"
# 削除を確認
docker exec -it postgresql  psql -U docker         -c "\du"