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

use cineclub;

-- CreateTable
CREATE TABLE `User` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `username` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `lastname` VARCHAR(191) NOT NULL,
    `email` VARCHAR(191) NOT NULL,
    `phone` VARCHAR(191) NOT NULL,
    `password` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `User_username_key`(`username`),
    UNIQUE INDEX `User_email_key`(`email`),
    UNIQUE INDEX `User_phone_key`(`phone`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Admin` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `username` VARCHAR(191) NOT NULL,
    `name` VARCHAR(191) NOT NULL,
    `lastname` VARCHAR(191) NOT NULL,
    `email` VARCHAR(191) NOT NULL,
    `phone` VARCHAR(191) NOT NULL,
    `password` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `Admin_username_key`(`username`),
    UNIQUE INDEX `Admin_email_key`(`email`),
    UNIQUE INDEX `Admin_phone_key`(`phone`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Card` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `cardNumber` VARCHAR(191) NOT NULL,
    `fullname` VARCHAR(191) NOT NULL,
    `cvc` VARCHAR(191) NOT NULL,
    `expirationTime` VARCHAR(191) NOT NULL,
    `userId` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Category` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` VARCHAR(191) NOT NULL,

    UNIQUE INDEX `Category_name_key`(`name`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Movie` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `categoryId` INTEGER NOT NULL,
    `photo` VARCHAR(191) NOT NULL,
    `title` VARCHAR(191) NOT NULL,
    `premiereDate` INTEGER NOT NULL,
    `classification` VARCHAR(191) NOT NULL,
    `duration` VARCHAR(191) NOT NULL,
    `buyPrice` DOUBLE NOT NULL,
    `rentPrice` DOUBLE NOT NULL,
    `directorId` INTEGER NOT NULL,
    `synopsis` LONGTEXT NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Director` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `fullname` VARCHAR(191) NOT NULL,
    `photo` VARCHAR(191) NOT NULL,
    `birthdate` DATETIME(3) NOT NULL,
    `birthplace` VARCHAR(191) NOT NULL,
    `biography` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Actor` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `fullname` VARCHAR(191) NOT NULL,
    `photo` VARCHAR(191) NOT NULL,
    `birthdate` DATETIME(3) NOT NULL,
    `birthplace` VARCHAR(191) NOT NULL,
    `biography` VARCHAR(191) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Ticket` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `type` VARCHAR(191) NOT NULL,
    `movieId` INTEGER NULL,
    `userId` INTEGER NOT NULL,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `expirationDate` DATETIME(3) NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Review` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `grade` INTEGER NOT NULL,
    `movieId` INTEGER NOT NULL,
    `userId` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `AdminLog` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `subject` VARCHAR(191) NOT NULL,
    `change` VARCHAR(191) NOT NULL,
    `subjectId` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Earning` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `createdAt` DATETIME(3) NOT NULL DEFAULT CURRENT_TIMESTAMP(3),
    `quantity` DOUBLE NOT NULL,
    `ticketId` INTEGER NOT NULL,

    UNIQUE INDEX `Earning_ticketId_key`(`ticketId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Bookmark` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `movieId` INTEGER NULL,
    `userId` INTEGER NOT NULL,

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `_ActorToMovie` (
    `A` INTEGER NOT NULL,
    `B` INTEGER NOT NULL,

    UNIQUE INDEX `_ActorToMovie_AB_unique`(`A`, `B`),
    INDEX `_ActorToMovie_B_index`(`B`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `Card` ADD CONSTRAINT `Card_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Movie` ADD CONSTRAINT `Movie_categoryId_fkey` FOREIGN KEY (`categoryId`) REFERENCES `Category`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Movie` ADD CONSTRAINT `Movie_directorId_fkey` FOREIGN KEY (`directorId`) REFERENCES `Director`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Ticket` ADD CONSTRAINT `Ticket_movieId_fkey` FOREIGN KEY (`movieId`) REFERENCES `Movie`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Ticket` ADD CONSTRAINT `Ticket_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Review` ADD CONSTRAINT `Review_movieId_fkey` FOREIGN KEY (`movieId`) REFERENCES `Movie`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Review` ADD CONSTRAINT `Review_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Earning` ADD CONSTRAINT `Earning_ticketId_fkey` FOREIGN KEY (`ticketId`) REFERENCES `Ticket`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Bookmark` ADD CONSTRAINT `Bookmark_movieId_fkey` FOREIGN KEY (`movieId`) REFERENCES `Movie`(`id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `Bookmark` ADD CONSTRAINT `Bookmark_userId_fkey` FOREIGN KEY (`userId`) REFERENCES `User`(`id`) ON DELETE RESTRICT ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_ActorToMovie` ADD CONSTRAINT `_ActorToMovie_A_fkey` FOREIGN KEY (`A`) REFERENCES `Actor`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `_ActorToMovie` ADD CONSTRAINT `_ActorToMovie_B_fkey` FOREIGN KEY (`B`) REFERENCES `Movie`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- inserts de usuarios
INSERT INTO User (name, lastname, username, email, phone, password) VALUES ('Oscar', 'Melchor', 'ozymandias', 'oz@email.com', '4423746798', '$2b$12$vPWTH1ZabHG9L4yOyHwZbecseEG10EsfyfBpQHlZJTnvof.gooGYW');
INSERT INTO User (name, lastname, username, email, phone, password) VALUES ('Miguel', 'Ramirez', 'ExuLnx', 'migay@email.com', '4422070087', '$2b$12$vPWTH1ZabHG9L4yOyHwZbecseEG10EsfyfBpQHlZJTnvof.gooGYW');
INSERT INTO User (name, lastname, username, email, phone, password) VALUES ('Alberto', 'Guerrero', 'Katu069', 'btito@email.com', '4428798732', '$2b$12$vPWTH1ZabHG9L4yOyHwZbecseEG10EsfyfBpQHlZJTnvof.gooGYW');
INSERT INTO User (name, lastname, username, email, phone, password) VALUES ('Cesar', 'Noriega', 'Trucoc04', 'chisa@email.com', '4151696554', '$2b$12$vPWTH1ZabHG9L4yOyHwZbecseEG10EsfyfBpQHlZJTnvof.gooGYW');
INSERT INTO User (name, lastname, username, email, phone, password) VALUES ('Diego', 'Macías', 'diciastonto', 'dicias@email.com', '4420568358', '$2b$12$vPWTH1ZabHG9L4yOyHwZbecseEG10EsfyfBpQHlZJTnvof.gooGYW');



-- inserts de tarjetas
INSERT INTO Card (fullname, cardNumber, cvc, expirationTime, userId) VALUES ('Oscar Elí Melchor Hernández', '4152 3134 4567 4892', '456', '01/25', 1);
INSERT INTO Card (fullname, cardNumber, cvc, expirationTime, userId) VALUES ('Miguel Angel Ramirez Cruz', '4152 3136 7895 5214', '569', '01/24', 2);
INSERT INTO Card (fullname, cardNumber, cvc, expirationTime, userId) VALUES ('Luis Alberto De La Cruz Guerrero', '4152 3136 0108 3806', '479', '05/24', 3);
INSERT INTO Card (fullname, cardNumber, cvc, expirationTime, userId) VALUES ('Cesar Eduardo Gonzalez Noriega', '4152 3136 9590 5575', '546', '01/29', 4);
INSERT INTO Card (fullname, cardNumber, cvc, expirationTime, userId) VALUES ('Diego Alejandro Macías Espejel', '4741 7429 0193 6453', '712', '04/28', 5);



--inserts de admins
INSERT INTO Admin (name, lastname, username, email, phone, password) VALUES ('Admin', 'Supremo', 'admin', 'admin@email.com', '4461117033', '$2b$12$vPWTH1ZabHG9L4yOyHwZbecseEG10EsfyfBpQHlZJTnvof.gooGYW');



-- inserts de categorías
INSERT INTO Category (name) VALUES ('Acción');
INSERT INTO Category (name) VALUES ('Ciencia Ficción');
INSERT INTO Category (name) VALUES ('Comedia');
INSERT INTO Category (name) VALUES ('Drama');
INSERT INTO Category (name) VALUES ('Musical');
INSERT INTO Category (name) VALUES ('Romance');
INSERT INTO Category (name) VALUES ('Superhéroes');
INSERT INTO Category (name) VALUES ('Terror');



-- inserts de actores
INSERT INTO Actor (fullname, photo, birthdate, birthplace, biography) VALUES ('Brad Pitt', 'https://images.mubicdn.net/images/cast_member/2552/cache-207-1524922850/image-w856.jpg', '1963-12-18 06:00:00.000', 'Oklahoma, EEUU.', 'William Bradley Pitt, más conocido como Brad Pitt, es un actor, modelo y productor de cine estadounidense.');
INSERT INTO Actor (fullname, photo, birthdate, birthplace, biography) VALUES ('Ryan Gosling', 'https://es.web.img2.acsta.net/pictures/16/05/17/17/28/208580.jpg', '1980-11-12 06:00:00.000', 'London, Canadá.', 'Ryan Thomas Gosling es un actor canadiense. Destacado en el cine independiente, también ha trabajado en éxitos de taquilla.');
INSERT INTO Actor (fullname, photo, birthdate, birthplace, biography) VALUES ('Timothée Chalamet', 'https://e00-telva.uecdn.es/assets/multimedia/imagenes/2021/09/16/16317870417608.jpg', '1995-12-27 06:00:00.000', 'Nueva York, EEUU.', 'Timothée Hal Chalamet es un actor estadounidense.​.');
INSERT INTO Actor (fullname, photo, birthdate, birthplace, biography) VALUES ('Michelle Yeoh', 'https://es.web.img2.acsta.net/pictures/17/09/20/10/22/2250952.jpg', '1962-08-06 06:00:00.000', 'Ipoh, Malasia.', 'Michelle Yeoh Choo-Khenges una actriz, modelo y bailarina malaya de origen chino. Aprendió inglés, malayo y posteriormente chino');
INSERT INTO Actor (fullname, photo, birthdate, birthplace, biography) VALUES ('Jonathan Ke Quan', 'https://es.web.img3.acsta.net/pictures/22/04/07/12/12/3497861.jpg', '1971-08-20 06:00:00.000', 'Ho Chi Minh, Vietnam.', 'Actor y coreógrafo estadounidense nacido en vietnam.');
INSERT INTO Actor (fullname, photo, birthdate, birthplace, biography) VALUES ('Stephanie Hsu', 'https://deadline.com/wp-content/uploads/2021/08/Stephanie-Hsu-Headshot-e1629417225251.jpg', '1962-08-06 06:00:00.000', 'California, EEUU.', 'Stephanie Ann Hsu es una actriz estadounidense de cine, teatro y televisión.');
INSERT INTO Actor (fullname, photo, birthdate, birthplace, biography) VALUES ('Daniel Day-Lewis', 'https://m.media-amazon.com/images/M/MV5BMjE2NDY2NDc1Ml5BMl5BanBnXkFtZTcwNjAyMjkwOQ@@._V1_.jpg', '1957-04-29 06:00:00.000', 'Londres, Reino Unido.', 'Daniel Day-Lewis es un actor retirado británico nacionalizado irlandés.​');
INSERT INTO Actor (fullname, photo, birthdate, birthplace, biography) VALUES ('Paul Dano', 'https://m.media-amazon.com/images/M/MV5BMjMwMzE1OTc0OF5BMl5BanBnXkFtZTcwMDU2NTg0Nw@@._V1_.jpg', '1984-06-19 06:00:00.000', 'Nueva York, EEUU.', 'Paul Franklin Dano es un actor, guionista y director estadounidense.');



-- inserts de directores
INSERT INTO Director (fullname, photo, birthdate, birthplace, biography) VALUES ('Denis Villeneuve', 'https://www.themoviedb.org/t/p/w500/zdDx9Xs93UIrJFWYApYR28J8M6b.jpg', '1967-10-03 06:00:00.000', 'Quebec, Canadá.', 'Denis Villeneuve es un guionista y director de cine canadiense.');
INSERT INTO Director (fullname, photo, birthdate, birthplace, biography) VALUES ('David Fincher', 'https://images.mubicdn.net/images/cast_member/1469/cache-103636-1599486038/image-w856.jpg', '1962-08-28 06:00:00.000', 'Colorado, EEUU.', 'David Andrew Leo Fincher​​, conocido como David Fincher, es un director y productor estadounidense de cine, televisión y vídeos musicales.');
INSERT INTO Director (fullname, photo, birthdate, birthplace, biography) VALUES ('Dan Kwan', 'https://m.media-amazon.com/images/M/MV5BMjJiZjk1YzAtNGI1Ny00MWE5LWFkMGMtOGRmY2FlNDg4Zjg2XkEyXkFqcGdeQXVyMTExNDQ2MTI@._V1_.jpg', '1988-10-02 06:00:00.000', 'Massachusetts, EEUU.', 'Director de Cine');
INSERT INTO Director (fullname, photo, birthdate, birthplace, biography) VALUES ('Paul Thomas Anderson', 'https://indiehoy.com/wp-content/uploads/2022/12/paul-thomas-anderson.jpg', '1970-06-26 06:00:00.000', 'California EEUU', 'Paul Thomas Anderson es un director, guionista y productor de cine estadounidense.');



-- inserts de películas
INSERT INTO Movie (title, premiereDate, photo, classification, duration, buyPrice, rentPrice, categoryId, synopsis, directorId) VALUES ('Blade Runner 2049', 2017, 'https://fotografias.flooxernow.com/clipping/cmsimages01/2017/10/03/731B1AAD-0130-44BA-ADD0-1D221A75D367/69.jpg', 'B', '139 mins', 150, 50, 2, "Han pasado 30 años desde los acontecimientos ocurridos en Blade Runner (1982). El agente K (Ryan Gosling), un 'blade runner' caza-Replicantes del Departamento de Policía de Los Ángeles, descubre un secreto que ha estado enterrado durante mucho tiempo y que tiene el potencial de llevar a la sociedad al caos. Su investigación le conducirá a la búsqueda del legendario Rick Deckard (Harrison Ford), un antiguo blade runner en paradero desconocido, que lleva desaparecido 30 años.", 1);
INSERT INTO Movie (title, premiereDate, photo, classification, duration, buyPrice, rentPrice, categoryId, synopsis, directorId) VALUES ('Duna', 2020, 'https://media.thegospelcoalition.org/wp-content/uploads/sites/4/2021/11/25123704/Duna-pelicula.jpeg', 'B', '139 mins', 150, 50, 2, "Arrakis, también denominado 'Dune', se ha convertido en el planeta más importante del universo. A su alrededor comienza una gigantesca lucha por el poder que culmina en una guerra interestelar.", 1);
INSERT INTO Movie (title, premiereDate, photo, classification, duration, buyPrice, rentPrice, categoryId, synopsis, directorId) VALUES ('El Club de la Pelea', 1999, 'https://i0.wp.com/blog.rebelionantigua.com/wp-content/uploads/2007/12/El-club-de-la-pelea-y-el-significado-de-la-vida.png', 'C', '139 mins', 150, 50, 1, "Un empleado de oficina insomne, harto de su vida, se cruza con un vendedor peculiar. Ambos crean un club de lucha clandestino como forma de terapia y, poco a poco, la organización crece y sus objetivos toman otro rumbo.", 2);
INSERT INTO Movie (title, premiereDate, photo, classification, duration, buyPrice, rentPrice, categoryId, synopsis, directorId) VALUES ('Todo En Todas Partes Al Mismo Tiempo', 2022, 'https://static.cinepolis.com/resources/mx/movies/posters/414x603/39349-815954-20220512044043.jpg', 'B', '139 mins', 150, 50, 5, "Una heroína inesperada debe usar sus nuevos poderes para luchar contra los desconcertantes peligros del multiverso y así lograr salvar su mundo.", 3);
INSERT INTO Movie (title, premiereDate, photo, classification, duration, buyPrice, rentPrice, categoryId, synopsis, directorId) VALUES ('Petróleo sangrientoo', 2007, 'https://assets.nflxext.com/us/boxshots/hd1080/70075473.jpg', 'B-15', '158 mins', 150, 50, 4, "La historia de un buscador de petróleo de Texas y los problemas que enfrenta en el negocio al comienzo del nuevo siglo.", 2);



-- inserts de actores a tabla de actores y películas
INSERT INTO _ActorToMovie (a, b) VALUES (2, 1);
INSERT INTO _ActorToMovie (a, b) VALUES (3, 2);
INSERT INTO _ActorToMovie (a, b) VALUES (1, 3);
INSERT INTO _ActorToMovie (a, b) VALUES (4, 4);
INSERT INTO _ActorToMovie (a, b) VALUES (5, 4);
INSERT INTO _ActorToMovie (a, b) VALUES (6, 4);
INSERT INTO _ActorToMovie (a, b) VALUES (7, 4);
INSERT INTO _ActorToMovie (a, b) VALUES (8, 4);



-- Vista para traer las mejores películas
CREATE VIEW BestMovies AS
SELECT M.*, AVG(grade) FROM Review
JOIN Movie M on M.id = Review.movieId
GROUP BY movieId
HAVING AVG(grade) > 4.5;



-- Vista para traer las películas de la categoría acción
CREATE VIEW ActionMovies AS
SELECT * FROM Movie
WHERE categoryId = 1;



-- Vista para traer las películas de la categoría ciencia ficción
CREATE VIEW ScienceFictionMovies AS
SELECT * FROM Movie
WHERE categoryId = 2;



-- Vista para traer las películas de la categoría comedia
CREATE VIEW ComedyMovies AS
SELECT * FROM Movie
WHERE categoryId = 3;



-- Vista para traer las películas de la categoría drama
CREATE VIEW DramaMovies AS
SELECT * FROM Movie
WHERE categoryId = 4;



-- Vista para traer las películas de la categoría musical
CREATE VIEW MusicalMovies AS
SELECT * FROM Movie
WHERE categoryId = 5;



-- Vista para traer las películas de la categoría romance
CREATE VIEW RomanceMovies AS
SELECT * FROM Movie
WHERE categoryId = 6;



-- Vista para traer las películas de la categoría superhéroes
CREATE VIEW SupeheroMovies AS
SELECT * FROM Movie
WHERE categoryId = 7;



-- Vista para traer las películas de la categoría terror
CREATE VIEW HorrorMovies AS
SELECT * FROM Movie
WHERE categoryId = 8;



-- Vista para traer todas las categorías
CREATE VIEW AllCategories AS
SELECT * FROM Category;



-- Vista para traer todas las categorías
CREATE VIEW AllUsers AS
SELECT * FROM User;



-- Vista para traer todas las categorías
CREATE VIEW TotalUsers AS
SELECT COUNT(*) FROM User;



-- Vista para traer todas las categorías
CREATE VIEW TotalMovies AS
SELECT COUNT(*) FROM Movie;

CREATE TRIGGER adminLogAddedActor
BEFORE INSERT
ON _ActorToMovie FOR EACH ROW
BEGIN
INSERT INTO AdminLog (subject, `change`,  subjectId) VALUES ('Movie', 'Actor added to Movie.', new.b);
INSERT INTO AdminLog (subject, `change`, subjectId) VALUES ('Actor', 'Actor added to Movie.', new.a);
END;

CREATE TRIGGER adminLogRemovedActor
BEFORE DELETE
ON _ActorToMovie FOR EACH ROW
BEGIN
INSERT INTO AdminLog (subject, `change`,  subjectId) VALUES ('Movie', 'Actor removed from Movie.', old.b);
INSERT INTO AdminLog (subject, `change`, subjectId) VALUES ('Actor', 'Actor removed from Movie.', old.a);
END;

CREATE TRIGGER adminLogCreatedMovie
BEFORE INSERT
ON Movie FOR EACH ROW
BEGIN
INSERT INTO AdminLog (subject, `change`,  subjectId) VALUES ('Movie', 'Movie created.', new.id);
INSERT INTO AdminLog (subject, `change`, subjectId) VALUES ('Director', 'Director added to movie.', new.directorId);
END;

CREATE TRIGGER adminLogUpdatedMovie
BEFORE UPDATE
ON Movie FOR EACH ROW
BEGIN
INSERT INTO AdminLog (subject, `change`,  subjectId) VALUES ('Movie', 'Movie updated.', new.id);
IF old.directorId != new.directorId THEN
    INSERT INTO AdminLog (subject, `change`,  subjectId) VALUES ('Director', 'Director removed from movie.', old.directorId);
    INSERT INTO AdminLog (subject, `change`,  subjectId) VALUES ('Director', 'Director added from movie.', new.directorId);
END IF;
END;

CREATE TRIGGER adminLogCreatedActor
BEFORE INSERT
ON Actor FOR EACH ROW
BEGIN
INSERT INTO AdminLog (subject, `change`,  subjectId) VALUES ('Actor', 'Actor created.', new.id);
END;

CREATE TRIGGER adminLogUpdatedActor
BEFORE UPDATE
ON Actor FOR EACH ROW
BEGIN
INSERT INTO AdminLog (subject, `change`,  subjectId) VALUES ('Actor', 'Actor updated.', new.id);
END;

CREATE TRIGGER adminLogCreatedDirector
BEFORE INSERT
ON Director FOR EACH ROW
BEGIN
INSERT INTO AdminLog (subject, `change`,  subjectId) VALUES ('Director', 'Director created.', new.id);
END;

CREATE TRIGGER adminLogUpdatedDirector
BEFORE UPDATE
ON Director FOR EACH ROW
BEGIN
INSERT INTO AdminLog (subject, `change`,  subjectId) VALUES ('Director', 'Director updated.', new.id);
END;

CREATE TRIGGER setNewEarning
AFTER INSERT
ON Ticket FOR EACH ROW
BEGIN
IF new.type LIKE 'buy' THEN
    SET @Earned = (SELECT buyPrice FROM Movie WHERE new.movieId = Movie.id);
    INSERT INTO Earnings (quantity, ticketId) VALUES (@Earned, new.id);
END IF;
IF new.type LIKE 'rent' THEN
    SET @Earned = (SELECT rentPrice FROM Movie WHERE new.movieId = Movie.id);
    INSERT INTO Earnings (quantity, ticketId) VALUES (@Earned, new.id);
END IF;
END;

-- Procedimiento para traer las películas del usuario
CREATE PROCEDURE getMyMovies(IN USER_ID int)
BEGIN
SELECT * FROM Ticket
JOIN Movie M on M.id = Ticket.movieId
WHERE userId = USER_ID AND NOT(ISNULL(movieId));
END;



-- Procedimiento para traer las películas guardadas del usuario
CREATE PROCEDURE getMyBookmarkedMovies(IN USER_ID int)
BEGIN
SELECT * FROM Bookmark
JOIN Movie M on M.id = Bookmark.movieId
WHERE userId = USER_ID AND NOT(ISNULL(movieId));
END;



-- Procedimiento para traer las películas con los tickets del usuario
CREATE PROCEDURE getMovieWithUserTickets(IN USER_ID int)
BEGIN
SELECT * FROM Movie
JOIN Ticket T on Movie.id = T.movieId
WHERE T.userId = USER_ID;
END;



-- Procedimiento para traer el promedio de calificaciones de una película
CREATE PROCEDURE getMovieAverageRating(IN MOVIE_ID int)
BEGIN
SELECT M.id, AVG(grade) FROM Review
JOIN Movie M on M.id = Review.movieId
WHERE movieId = MOVIE_ID
GROUP BY movieId;
END;



-- Procedimiento para traer las tarjetas de un usuario
CREATE PROCEDURE getUserCards(IN USER_ID int)
BEGIN
SELECT * FROM Card
JOIN User U on U.id = Card.userId
WHERE userId = USER_ID;
END;


-- Procedimiento para crear un usuario
CREATE PROCEDURE createUser(IN $username varchar(255), IN $name varchar(255), IN $lastname varchar(255), IN $email varchar(255), IN $phone varchar(10), IN $password varchar(255))
BEGIN
INSERT INTO User (username, name, lastname, email, phone, password)
VALUES ($username, $name, $lastname, $email, $phone, $password);
END;



-- Procedimiento para crear una tarjeta
CREATE PROCEDURE createCard(IN $cardNumber varchar(255), IN $fullname varchar(255), IN $cvc varchar(3), IN $expirationTime varchar(5), IN $userId int)
BEGIN
INSERT INTO Card (cardNumber, fullname, cvc, expirationTime, userId)
VALUES ($cardNumber, $fullname, $cvc, $expirationTime, $userId);
END;



-- Procedimiento para crear un admin
CREATE PROCEDURE createAdmin(IN $username varchar(255), IN $name varchar(255), IN $lastname varchar(255), IN $email varchar(255), IN $phone varchar(10), IN $password varchar(255))
BEGIN
INSERT INTO Admin (username, name, lastname, email, phone, password)
VALUES ($username, $name, $lastname, $email, $phone, $password);
END;



-- Procedimiento para crear un actor
CREATE PROCEDURE createActor(IN $fullname varchar(255), IN $photo varchar(255), IN $birthdate varchar(255), IN $birthplace varchar(255), IN $biography varchar(255))
BEGIN
INSERT INTO Actor (fullname, photo, birthdate, birthplace, biography)
VALUES ($fullname, $photo, $birthdate, $birthplace, $biography);
END;



-- Procedimiento para crear un director
CREATE PROCEDURE createDirector(IN $fullname varchar(255), IN $photo varchar(255), IN $birthdate varchar(255), IN $birthplace varchar(255), IN $biography varchar(255))
BEGIN
INSERT INTO Director (fullname, photo, birthdate, birthplace, biography)
VALUES ($fullname, $photo, $birthdate, $birthplace, $biography);
END;



-- Procedimiento para crear una película
CREATE PROCEDURE createMovie(IN $categoryId varchar(255), IN $photo varchar(255), IN $title varchar(255), IN $premiereDate int, IN $classification varchar(255), IN $duration varchar(255), IN $buyPrice double, IN $rentPrice double, IN $directorId int, IN $synopsis longtext)
BEGIN
INSERT INTO Movie (categoryId, photo, title, premiereDate, classification, duration, buyPrice, rentPrice, directorId, synopsis)
VALUES ($categoryId, $photo, $title, $premiereDate, $classification, $duration, $buyPrice, $rentPrice, $directorId, $synopsis);
END;



-- Procedimiento para crear una reseña
CREATE PROCEDURE createReview(IN $grade int, IN $movieId int, IN $userId int)
BEGIN
INSERT INTO Review (grade, movieId, userId)
VALUES ($grade, $movieId, $userId);
END;



-- Procedimiento para crear un ticket
CREATE PROCEDURE createTicket(IN $type varchar(255), IN $movieId int, IN $userId int, IN $createdAt date, IN $expirationDate date)
BEGIN
INSERT INTO Ticket (type, movieId, userId, createdAt, expirationDate)
VALUES ($type, $movieId, $userId, $createdAt, $expirationDate);
END;



-- Procedimiento para crear un guardado
CREATE PROCEDURE createBookmark(IN $movieId int, IN $userId int)
BEGIN
INSERT INTO Bookmark (movieId, userId)
VALUES ($movieId, $userId);
END;



-- Procedimiento para actualizar un usuario
CREATE PROCEDURE updateUser(IN USER_ID int, IN $username varchar(255), IN $name varchar(255), IN $lastname varchar(255), IN $email varchar(255), IN $phone varchar(10), IN $password varchar(255))
BEGIN
UPDATE User SET username = $username, name = $name, lastname = $lastname, email = $email, phone = $phone, password = $password
WHERE id = USER_ID;
END;



-- Procedimiento para actualizar un admin
CREATE PROCEDURE updateAdmin(IN ADMIN_ID int, IN $username varchar(255), IN $name varchar(255), IN $lastname varchar(255), IN $email varchar(255), IN $phone varchar(10), IN $password varchar(255))
BEGIN
UPDATE Admin SET username = $username, name = $name, lastname = $lastname, email = $email, phone = $phone, password = $password
WHERE id = ADMIN_ID;
END;



-- Procedimiento para actualizar un actor
CREATE PROCEDURE updateActor(IN ACTOR_ID int, IN $fullname varchar(255), IN $photo varchar(255), IN $birthdate varchar(255), IN $birthplace varchar(255), IN $biography varchar(255))
BEGIN
UPDATE Actor SET fullname = $fullname, photo = $photo, birthdate = $birthdate, birthplace = $birthplace, biography = $biography
WHERE id = ACTOR_ID;
END;



-- Procedimiento para actualizar un director
CREATE PROCEDURE updateDirector(IN DIRECTOR_ID int, IN $fullname varchar(255), IN $photo varchar(255), IN $birthdate varchar(255), IN $birthplace varchar(255), IN $biography varchar(255))
BEGIN
UPDATE Director SET fullname = $fullname, photo = $photo, birthdate = $birthdate, birthplace = $birthplace, biography = $biography
WHERE id = DIRECTOR_ID;
END;



-- Procedimiento para actualizar una película
CREATE PROCEDURE updateMovie(IN MOVIE_ID int, IN $categoryId varchar(255), IN $photo varchar(255), IN $title varchar(255), IN $premiereDate int, IN $classification varchar(255), IN $duration varchar(255), IN $buyPrice double, IN $rentPrice double, IN $directorId int, IN $synopsis longtext)
BEGIN
UPDATE Movie SET categoryId = $categoryId, photo = $photo, title = $title, premiereDate = $premiereDate, classification = $classification, duration = $duration, buyPrice = $buyPrice, rentPrice = $rentPrice, directorId = $directorId, synopsis = $synopsis
WHERE id = MOVIE_ID;
END;



-- Procedimiento para crear una reseña
CREATE PROCEDURE updateReview(IN REVIEW_ID int, IN $grade int, IN $movieId int, IN $userId int)
BEGIN
UPDATE Review SET grade = $grade, movieId = $movieId, userId = $userId
WHERE id = REVIEW_ID;
END;



-- Procedimiento para crear un ticket
CREATE PROCEDURE updateTicket(IN TICKET_ID int, IN $type varchar(255), IN $movieId int, IN $userId int, IN $createdAt date, IN $expirationDate date)
BEGIN
UPDATE Ticket SET type = $type, movieId = $movieId, userId = $userId, createdAt = $createdAt, expirationDate = $expirationDate
WHERE id = TICKET_ID;
END;



-- Procedimiento para crear un guardado
CREATE PROCEDURE updateBookmark(IN BOOKMARK_ID int, IN $type varchar(255), IN $movieId int, IN $userId int)
BEGIN
UPDATE Bookmark SET movieId = $movieId, userId = $userId
WHERE id = BOOKMARK_ID;
END;