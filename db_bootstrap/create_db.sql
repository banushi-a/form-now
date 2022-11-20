CREATE DATABASE form_now_db;
CREATE USER 'webapp'@'%' IDENTIFIED BY 'abc123';
GRANT ALL PRIVILEGES ON cool_db.* TO 'webapp'@'%';
FLUSH PRIVILEGES;

USE form_now_db;

-- Initialize Database here :)