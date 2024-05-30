-- --ユーザーの作成
CREATE USER docker;
-- --DBの作成
CREATE DATABASE docker;
-- --ユーザーにDBの権限をまとめて付与
GRANT ALL PRIVILEGES ON DATABASE docker TO docker;
CREATE USER tx2;
GRANT ALL PRIVILEGES ON DATABASE docker TO tx2;

GRANT ALL PRIVILEGES ON DATABASE docker TO postgres;
--ユーザーを切り替え
\c docker
--テーブルにデータを挿入

