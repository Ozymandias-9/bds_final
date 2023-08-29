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