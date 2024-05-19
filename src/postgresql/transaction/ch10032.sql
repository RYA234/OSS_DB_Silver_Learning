-- 分離レベルの設定
SHOW default_transaction_isolation;

SET default_transaction_isolation TO 'serializable';

SHOW default_transaction_isolation;
BEGIN ISOLATION LEVEL read commited;

SHOW default_transaction_isolation;

-- 初期化
SET default_transaction_isolation TO 'read commited';
BEGIN ISOLATION LEVEL serializable;;