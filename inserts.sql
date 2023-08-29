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