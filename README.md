# 概要
OSSDB　SilverのSQL文を試すためのリポジトリです。　

#  構成図

```mermaid
---
title: laravel構成図
---
flowchart

%% 図など
subgraph Windows[github CodeSpaces]
    subgraph Client[Docker-Postgresql]
        subgraph Linux[AlpineLinux]
            subgraph DB[postgresql 14.0]
                info3[ログイン情報</br> User名: user </br> password:pass ]
            end
        end
    end
end

User[開発者]
%% 接続部分
User --> Client
Windows --docker-compose_exec_-it_postgresql--> Client
```


# フォルダ、ファイル名
フォルダ名|説明|
----|----
 docker-compose.yml|ファイルの説明
 docker/postgres|DockerFile 最初に実行されるsqlが含まれている
 src|勉強で使うsql文


# コマンド

```bash
# dockerコンテナを構築
docker-compose build

# docker コンテナを起動
docker-compose up -d

##  確認作業
# ユーザー情報を確認
docker exec -it postgresql  psql -U docker -c "\du"
# テーブル情報を確認
docker exec -it postgresql  psql -U docker -c "\d"
# sample.sql実行する
docker-compose  exec -it postgresql  psql -U docker -f src/postgresql/sample.sql -d docker
```


# 確認結果

## ユーザー情報
```bash

```

## テーブル情報

```bash

```


# 参考

dockerコンテナの作成方法

https://amateur-engineer.com/docker-compose-postgresql/#toc5

sql文
OSS教科書　OSS-DB Silver Ver3.0対応
第８章　SQLとオブジェクト