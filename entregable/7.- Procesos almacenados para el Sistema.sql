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