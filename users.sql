CREATE USER 'client'@'localhost' IDENTIFIED BY 'password';
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'password';

-- client permissions

GRANT SELECT, INSERT, DELETE ON cineclub . Card TO 'client'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON cineclub . User TO 'client'@'localhost';
GRANT SELECT, INSERT, DELETE ON cineclub . Ticket TO 'client'@'localhost';
GRANT SELECT, INSERT ON cineclub . Review TO 'client'@'localhost';
GRANT SELECT, INSERT, DELETE ON cineclub . Bookmark TO 'client'@'localhost';
FLUSH PRIVILEGES;

-- admin permissions

GRANT SELECT, INSERT, UPDATE, DELETE ON cineclub . Movie TO 'admin'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON cineclub . Actor TO 'admin'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON cineclub . Director TO 'admin'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON cineclub . Category TO 'admin'@'localhost';
GRANT SELECT, INSERT ON cineclub . AdminLog TO 'admin'@'localhost';
GRANT SELECT, INSERT ON cineclub . Earning TO 'admin'@'localhost';
FLUSH PRIVILEGES;

-- root permissions

GRANT ALL PRIVILEGES ON cineclub . * TO 'root'@'localhost';
FLUSH PRIVILEGES;