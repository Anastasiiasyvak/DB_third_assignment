USE ASSIGNMENT3;


CREATE USER 'client_reader'@'localhost' IDENTIFIED BY '123456Aa@';
GRANT SELECT ON ASSIGNMENT3.CLIENTS TO 'client_reader'@'localhost';
SHOW GRANTS FOR 'client_reader'@'localhost';


CREATE USER 'tour_inserter'@'localhost' IDENTIFIED BY '123457Aa@';
GRANT INSERT ON ASSIGNMENT3.TOURS TO 'tour_inserter'@'localhost';
SHOW GRANTS FOR 'tour_inserter'@'localhost';


CREATE USER 'order_deleter'@'localhost' IDENTIFIED BY '123458Aa@';
GRANT DELETE ON ASSIGNMENT3.ORDERS TO 'order_deleter'@'localhost';
SHOW GRANTS FOR 'order_deleter'@'localhost';


