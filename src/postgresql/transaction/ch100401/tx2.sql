BEGIN;

SELECT item_id,stock FROM item WHERE item_id=1;
UPDATE item SET stock=stock-1 WHERE item_id=1;

