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
    INSERT INTO Earning (quantity, ticketId) VALUES (@Earned, new.id);
END IF;
IF new.type LIKE 'rent' THEN
    SET @Earned = (SELECT rentPrice FROM Movie WHERE new.movieId = Movie.id);
    INSERT INTO Earning (quantity, ticketId) VALUES (@Earned, new.id);
END IF;
END;