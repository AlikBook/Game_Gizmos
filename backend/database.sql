drop database if exists advanceddata;
create database advanceddata;
use advanceddata;

CREATE TABLE Games(
   game_id VARCHAR(50),
   game_name VARCHAR(50),
   publication_year INT,
   game_image TEXT,
   game_url TEXT,
   avg_rate decimal(3, 2),
   PRIMARY KEY(game_id)
);

CREATE TABLE Categories(
   category_id INT,
   category_name VARCHAR(50),
   category_description TEXT,
   PRIMARY KEY(category_id)
);

CREATE TABLE Users(
   user_id INT,
   user_mail VARCHAR(50),
   password VARCHAR(50),
   PRIMARY KEY(user_id, user_mail)
);

CREATE TABLE Mechanics(
   mechanic_id INT,
   mechanic_name VARCHAR(50),
   PRIMARY KEY(mechanic_id)
);

CREATE TABLE Expansions(
   expansion_id INT,
   expansion_name VARCHAR(50),
   expansion_description TEXT,
   game_id VARCHAR(50) NOT NULL,
   PRIMARY KEY(expansion_id),
   FOREIGN KEY(game_id) REFERENCES Games(game_id)
);

CREATE TABLE Artists(
   artist_id INT,
   artist_name VARCHAR(50),
   PRIMARY KEY(artist_id)
);

CREATE TABLE Designers(
   designer_id INT,
   designer_name VARCHAR(50),
   PRIMARY KEY(designer_id)
);

CREATE TABLE Publishers(
   publisher_id INT,
   publisher_name VARCHAR(50),
   PRIMARY KEY(publisher_id)
);

CREATE TABLE Events(
   event_id INT,
   event_name VARCHAR(50),
   event_description TEXT,
   nb_participants INT,
   max_participants INT,
   min_participants VARCHAR(50),
   game_id VARCHAR(50) NOT NULL,
   PRIMARY KEY(event_id),
   FOREIGN KEY(game_id) REFERENCES Games(game_id)
);

CREATE TABLE Rates(
   game_id VARCHAR(50),
   user_id INT,
   user_mail VARCHAR(50),
   Comments TEXT,
   Rate DECIMAL(15,2),
   PRIMARY KEY(game_id, user_id, user_mail),
   FOREIGN KEY(game_id) REFERENCES Games(game_id),
   FOREIGN KEY(user_id, user_mail) REFERENCES Users(user_id, user_mail)
);

CREATE TABLE Participates(
   user_id INT,
   user_mail VARCHAR(50),
   event_id INT,
   PRIMARY KEY(user_id, user_mail, event_id),
   FOREIGN KEY(user_id, user_mail) REFERENCES Users(user_id, user_mail),
   FOREIGN KEY(event_id) REFERENCES Events(event_id)
);

CREATE TABLE Has(
   game_id VARCHAR(50),
   mechanic_id INT,
   PRIMARY KEY(game_id, mechanic_id),
   FOREIGN KEY(game_id) REFERENCES Games(game_id),
   FOREIGN KEY(mechanic_id) REFERENCES Mechanics(mechanic_id)
);

CREATE TABLE Has3(
   game_id VARCHAR(50),
   category_id INT,
   PRIMARY KEY(game_id, category_id),
   FOREIGN KEY(game_id) REFERENCES Games(game_id),
   FOREIGN KEY(category_id) REFERENCES Categories(category_id)
);

CREATE TABLE WorksOn(
   game_id VARCHAR(50),
   designer_id INT,
   PRIMARY KEY(game_id, designer_id),
   FOREIGN KEY(game_id) REFERENCES Games(game_id),
   FOREIGN KEY(designer_id) REFERENCES Designers(designer_id)
);

CREATE TABLE WorksOn2(
   game_id VARCHAR(50),
   publisher_id INT,
   PRIMARY KEY(game_id, publisher_id),
   FOREIGN KEY(game_id) REFERENCES Games(game_id),
   FOREIGN KEY(publisher_id) REFERENCES Publishers(publisher_id)
);

CREATE TABLE WorksOn3(
   game_id VARCHAR(50),
   artist_id INT,
   PRIMARY KEY(game_id, artist_id),
   FOREIGN KEY(game_id) REFERENCES Games(game_id),
   FOREIGN KEY(artist_id) REFERENCES Artists(artist_id)
);

INSERT INTO Games(game_id, game_name, publication_year, game_image, game_url)
VALUES ('30549', 'Pandemic', 2008, 'https://cf.geekdo-images.com/S3ybV1LAp-8SnHIXLLjVqA__micro/img/S4tXI3Yo7BtqmBoKINLLVUFsaJ0=/fit-in/64x64/filters:strip_icc()/pic1534148.jpg', '/boardgame/30549/pandemic');
INSERT INTO Games(game_id, game_name, publication_year, game_image, game_url)
VALUES ('822', 'Carcassonne', 2000, 'https://cf.geekdo-images.com/okM0dq_bEXnbyQTOvHfwRA__micro/img/VfLoKzfk3xj26ArmDu55qZ4sysw=/fit-in/64x64/filters:strip_icc()/pic6544250.png', '/boardgame/822/carcassonne');
INSERT INTO Games(game_id, game_name, publication_year, game_image, game_url)
VALUES ('13', 'Catan', 1995, 'https://cf.geekdo-images.com/W3Bsga_uLP9kO91gZ7H8yw__micro/img/LA4OvGfQ_TXQ-2mhaIFZp2ITWpc=/fit-in/64x64/filters:strip_icc()/pic2419375.jpg', '/boardgame/13/catan');
INSERT INTO Games(game_id, game_name, publication_year, game_image, game_url)
VALUES ('68448', '7 Wonders', 2010, 'https://cf.geekdo-images.com/RvFVTEpnbb4NM7k0IF8V7A__micro/img/9glsOs7zoTbkVpfDt5SHWJm-kRA=/fit-in/64x64/filters:strip_icc()/pic860217.jpg', '/boardgame/68448/7-wonders');
INSERT INTO Games(game_id, game_name, publication_year, game_image, game_url)
VALUES ('36218', 'Dominion', 2008, 'https://cf.geekdo-images.com/j6iQpZ4XkemZP07HNCODBA__micro/img/PVxqHWOLTb3n-4xe62LJadr_M0I=/fit-in/64x64/filters:strip_icc()/pic394356.jpg', '/boardgame/36218/dominion');
INSERT INTO Users(user_id, user_mail, password)
VALUES (1, 'alice@example.com', 'password123');
INSERT INTO Users(user_id, user_mail, password)
VALUES (2, 'bob@example.com', 'securepass');
INSERT INTO Users(user_id, user_mail, password)
VALUES (3, 'carol@example.com', 'qwerty!@#');
INSERT INTO Rates(game_id, user_id, user_mail, Comments, Rate)
VALUES ('30549', 1, 'alice@example.com', 'User 1 enjoyed game 30549', 6.5);
INSERT INTO Rates(game_id, user_id, user_mail, Comments, Rate)
VALUES ('30549', 2, 'bob@example.com', 'User 2 enjoyed game 30549', 7.0);
INSERT INTO Rates(game_id, user_id, user_mail, Comments, Rate)
VALUES ('30549', 3, 'carol@example.com', 'User 3 enjoyed game 30549', 7.5);
INSERT INTO Rates(game_id, user_id, user_mail, Comments, Rate)
VALUES ('822', 1, 'alice@example.com', 'User 1 enjoyed game 822', 6.5);
INSERT INTO Rates(game_id, user_id, user_mail, Comments, Rate)
VALUES ('822', 2, 'bob@example.com', 'User 2 enjoyed game 822', 7.0);
INSERT INTO Rates(game_id, user_id, user_mail, Comments, Rate)
VALUES ('822', 3, 'carol@example.com', 'User 3 enjoyed game 822', 7.5);
INSERT INTO Rates(game_id, user_id, user_mail, Comments, Rate)
VALUES ('13', 1, 'alice@example.com', 'User 1 enjoyed game 13', 6.5);
INSERT INTO Rates(game_id, user_id, user_mail, Comments, Rate)
VALUES ('13', 2, 'bob@example.com', 'User 2 enjoyed game 13', 7.0);
INSERT INTO Rates(game_id, user_id, user_mail, Comments, Rate)
VALUES ('13', 3, 'carol@example.com', 'User 3 enjoyed game 13', 7.5);
INSERT INTO Rates(game_id, user_id, user_mail, Comments, Rate)
VALUES ('68448', 1, 'alice@example.com', 'User 1 enjoyed game 68448', 6.5);
INSERT INTO Rates(game_id, user_id, user_mail, Comments, Rate)
VALUES ('68448', 2, 'bob@example.com', 'User 2 enjoyed game 68448', 7.0);
INSERT INTO Rates(game_id, user_id, user_mail, Comments, Rate)
VALUES ('68448', 3, 'carol@example.com', 'User 3 enjoyed game 68448', 7.5);
INSERT INTO Rates(game_id, user_id, user_mail, Comments, Rate)
VALUES ('36218', 1, 'alice@example.com', 'User 1 enjoyed game 36218', 6.5);
INSERT INTO Rates(game_id, user_id, user_mail, Comments, Rate)
VALUES ('36218', 2, 'bob@example.com', 'User 2 enjoyed game 36218', 7.0);
INSERT INTO Rates(game_id, user_id, user_mail, Comments, Rate)
VALUES ('36218', 3, 'carol@example.com', 'User 3 enjoyed game 36218', 7.5);
INSERT INTO Mechanics(mechanic_id, mechanic_name) VALUES (1, 'Card Drafting');
INSERT INTO Mechanics(mechanic_id, mechanic_name) VALUES (2, 'Dice Rolling');
INSERT INTO Mechanics(mechanic_id, mechanic_name) VALUES (3, 'Worker Placement');
INSERT INTO Mechanics(mechanic_id, mechanic_name) VALUES (4, 'Area Control');
INSERT INTO Mechanics(mechanic_id, mechanic_name) VALUES (5, 'Set Collection');
INSERT INTO Categories(category_id, category_name, category_description) VALUES (1, 'Strategy', 'Games involving strategic decision-making.');
INSERT INTO Categories(category_id, category_name, category_description) VALUES (2, 'Family', 'Lightweight games for all ages.');
INSERT INTO Categories(category_id, category_name, category_description) VALUES (3, 'Adventure', 'Games with exploration and quests.');
INSERT INTO Categories(category_id, category_name, category_description) VALUES (4, 'Economic', 'Focus on money and resource management.');
INSERT INTO Categories(category_id, category_name, category_description) VALUES (5, 'Thematic', 'Heavily story- or theme-driven games.');
INSERT INTO Designers(designer_id, designer_name) VALUES (1, 'Reiner Knizia');
INSERT INTO Designers(designer_id, designer_name) VALUES (2, 'Uwe Rosenberg');
INSERT INTO Designers(designer_id, designer_name) VALUES (3, 'Elizabeth Hargrave');
INSERT INTO Publishers(publisher_id, publisher_name) VALUES (1, 'Days of Wonder');
INSERT INTO Publishers(publisher_id, publisher_name) VALUES (2, 'Z-Man Games');
INSERT INTO Publishers(publisher_id, publisher_name) VALUES (3, 'Fantasy Flight Games');
INSERT INTO Artists(artist_id, artist_name) VALUES (1, 'Michael Menzel');
INSERT INTO Artists(artist_id, artist_name) VALUES (2, 'Vincent Dutrait');
INSERT INTO Artists(artist_id, artist_name) VALUES (3, 'Naomi Robinson');
INSERT INTO Has(game_id, mechanic_id) VALUES ('30549', 1);
INSERT INTO Has(game_id, mechanic_id) VALUES ('30549', 4);
INSERT INTO Has(game_id, mechanic_id) VALUES ('822', 5);
INSERT INTO Has(game_id, mechanic_id) VALUES ('822', 3);
INSERT INTO Has(game_id, mechanic_id) VALUES ('13', 2);
INSERT INTO Has(game_id, mechanic_id) VALUES ('13', 3);
INSERT INTO Has(game_id, mechanic_id) VALUES ('68448', 5);
INSERT INTO Has(game_id, mechanic_id) VALUES ('68448', 3);
INSERT INTO Has(game_id, mechanic_id) VALUES ('36218', 4);
INSERT INTO Has(game_id, mechanic_id) VALUES ('36218', 2);
INSERT INTO Has3(game_id, category_id) VALUES ('30549', 2);
INSERT INTO Has3(game_id, category_id) VALUES ('30549', 1);
INSERT INTO Has3(game_id, category_id) VALUES ('822', 2);
INSERT INTO Has3(game_id, category_id) VALUES ('822', 3);
INSERT INTO Has3(game_id, category_id) VALUES ('13', 1);
INSERT INTO Has3(game_id, category_id) VALUES ('13', 2);
INSERT INTO Has3(game_id, category_id) VALUES ('68448', 3);
INSERT INTO Has3(game_id, category_id) VALUES ('68448', 1);
INSERT INTO Has3(game_id, category_id) VALUES ('36218', 4);
INSERT INTO Has3(game_id, category_id) VALUES ('36218', 2);
INSERT INTO WorksOn(game_id, designer_id) VALUES ('30549', 3);
INSERT INTO WorksOn(game_id, designer_id) VALUES ('822', 2);
INSERT INTO WorksOn(game_id, designer_id) VALUES ('13', 1);
INSERT INTO WorksOn(game_id, designer_id) VALUES ('68448', 1);
INSERT INTO WorksOn(game_id, designer_id) VALUES ('36218', 1);
INSERT INTO WorksOn2(game_id, publisher_id) VALUES ('30549', 2);
INSERT INTO WorksOn2(game_id, publisher_id) VALUES ('822', 2);
INSERT INTO WorksOn2(game_id, publisher_id) VALUES ('13', 3);
INSERT INTO WorksOn2(game_id, publisher_id) VALUES ('68448', 2);
INSERT INTO WorksOn2(game_id, publisher_id) VALUES ('36218', 3);
INSERT INTO WorksOn3(game_id, artist_id) VALUES ('30549', 1);
INSERT INTO WorksOn3(game_id, artist_id) VALUES ('822', 3);
INSERT INTO WorksOn3(game_id, artist_id) VALUES ('13', 3);
INSERT INTO WorksOn3(game_id, artist_id) VALUES ('68448', 2);
INSERT INTO WorksOn3(game_id, artist_id) VALUES ('36218', 2);
INSERT INTO Expansions(expansion_id, expansion_name, expansion_description, game_id) VALUES (101, 'Expansion 1', 'Expansion description 1', '30549');
INSERT INTO Expansions(expansion_id, expansion_name, expansion_description, game_id) VALUES (102, 'Expansion 2', 'Expansion description 2', '822');
INSERT INTO Expansions(expansion_id, expansion_name, expansion_description, game_id) VALUES (103, 'Expansion 3', 'Expansion description 3', '13');
INSERT INTO Expansions(expansion_id, expansion_name, expansion_description, game_id) VALUES (104, 'Expansion 4', 'Expansion description 4', '68448');
INSERT INTO Expansions(expansion_id, expansion_name, expansion_description, game_id) VALUES (105, 'Expansion 5', 'Expansion description 5', '36218');
INSERT INTO Events(event_id, event_name, event_description, nb_participants, max_participants, min_participants, game_id)
VALUES (201, 'Event 1', 'Description for event 1', 11, 21, '2', '30549');
INSERT INTO Events(event_id, event_name, event_description, nb_participants, max_participants, min_participants, game_id)
VALUES (202, 'Event 2', 'Description for event 2', 12, 22, '2', '822');
INSERT INTO Events(event_id, event_name, event_description, nb_participants, max_participants, min_participants, game_id)
VALUES (203, 'Event 3', 'Description for event 3', 13, 23, '2', '13');
INSERT INTO Events(event_id, event_name, event_description, nb_participants, max_participants, min_participants, game_id)
VALUES (204, 'Event 4', 'Description for event 4', 14, 24, '2', '68448');
INSERT INTO Events(event_id, event_name, event_description, nb_participants, max_participants, min_participants, game_id)
VALUES (205, 'Event 5', 'Description for event 5', 15, 25, '2', '36218');
INSERT INTO Participates(user_id, user_mail, event_id)
VALUES (1, 'alice@example.com', 201);
INSERT INTO Participates(user_id, user_mail, event_id)
VALUES (2, 'bob@example.com', 201);
INSERT INTO Participates(user_id, user_mail, event_id)
VALUES (3, 'carol@example.com', 201);
INSERT INTO Participates(user_id, user_mail, event_id)
VALUES (1, 'alice@example.com', 202);
INSERT INTO Participates(user_id, user_mail, event_id)
VALUES (2, 'bob@example.com', 202);
INSERT INTO Participates(user_id, user_mail, event_id)
VALUES (3, 'carol@example.com', 202);
INSERT INTO Participates(user_id, user_mail, event_id)
VALUES (1, 'alice@example.com', 203);
INSERT INTO Participates(user_id, user_mail, event_id)
VALUES (2, 'bob@example.com', 203);
INSERT INTO Participates(user_id, user_mail, event_id)
VALUES (3, 'carol@example.com', 203);
INSERT INTO Participates(user_id, user_mail, event_id)
VALUES (1, 'alice@example.com', 204);
INSERT INTO Participates(user_id, user_mail, event_id)
VALUES (2, 'bob@example.com', 204);
INSERT INTO Participates(user_id, user_mail, event_id)
VALUES (3, 'carol@example.com', 204);
INSERT INTO Participates(user_id, user_mail, event_id)
VALUES (1, 'alice@example.com', 205);
INSERT INTO Participates(user_id, user_mail, event_id)
VALUES (2, 'bob@example.com', 205);
INSERT INTO Participates(user_id, user_mail, event_id)
VALUES (3, 'carol@example.com', 205);


CREATE INDEX idx_games_publication_year ON Games(publication_year);
CREATE INDEX idx_rates_game_id ON Rates(game_id);
CREATE INDEX idx_events_game_id ON Events(game_id);
CREATE INDEX idx_has_mechanic_id ON Has(mechanic_id);
CREATE INDEX idx_workson_designer_id ON WorksOn(designer_id);
CREATE INDEX idx_categories_category_name ON Categories(category_name);

CREATE VIEW AvailableGames AS
SELECT 
    g.game_id,
    g.game_name,
    g.publication_year,
    c.category_name AS category,
    g.game_image,
    g.game_url
FROM Games g
JOIN Has3 h ON g.game_id = h.game_id
JOIN Categories c ON h.category_id = c.category_id;

CREATE VIEW UserRatingHistory AS
SELECT 
    u.user_mail,
    g.game_name,
    r.Rate,
    r.Comments,
    CONCAT(r.user_id, '_', r.game_id) AS id_rate
FROM Rates r
JOIN Games g ON r.game_id = g.game_id
JOIN Users u ON r.user_id = u.user_id AND r.user_mail = u.user_mail;

CREATE VIEW UpcomingEvents AS
SELECT 
    e.event_name,
    e.event_description,
    COUNT(p.event_id) AS current_participants,
    e.max_participants
FROM Events e
LEFT JOIN Participates p ON e.event_id = p.event_id
GROUP BY e.event_id, e.event_name, e.event_description, e.max_participants;

CREATE VIEW GameDetails AS
SELECT 
    g.game_name,
    g.publication_year,
    a.artist_name,
    d.designer_name,
    p.publisher_name
FROM Games g
JOIN WorksOn3 w3 ON g.game_id = w3.game_id
JOIN Artists a ON w3.artist_id = a.artist_id
JOIN WorksOn w ON g.game_id = w.game_id
JOIN Designers d ON w.designer_id = d.designer_id
JOIN WorksOn2 w2 ON g.game_id = w2.game_id
JOIN Publishers p ON w2.publisher_id = p.publisher_id;

DELIMITER $$
CREATE FUNCTION GetAverageRating(gameId VARCHAR(50))
RETURNS FLOAT
DETERMINISTIC
BEGIN
	DECLARE avgRating FLOAT;
	SELECT AVG(Rate) INTO avgRating FROM Rates WHERE game_id = gameId;
	RETURN avgRating;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE AddRating(
	IN p_rate DECIMAL(15,2),
	IN p_comments TEXT,
	IN p_game_id VARCHAR(50),
	IN p_user_id INT,
	IN p_user_mail VARCHAR(50)
)
BEGIN
	INSERT INTO Rates (Rate, Comments, game_id, user_id, user_mail)
	VALUES (p_rate, p_comments, p_game_id, p_user_id, p_user_mail);
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE CreateEvent(
	IN p_event_id INT,
	IN p_event_name VARCHAR(50),
	IN p_event_description TEXT,
	IN p_nb_participants INT,
	IN p_max_participants INT,
	IN p_min_participants VARCHAR(50),
	IN p_game_id VARCHAR(50)
)
BEGIN
	INSERT INTO Events (event_id, event_name, event_description, nb_participants, max_participants, min_participants, game_id)
	VALUES (p_event_id, p_event_name, p_event_description, p_nb_participants, p_max_participants, p_min_participants, p_game_id);
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE JoinEvent(
	IN p_event_id INT,
	IN p_user_id INT,
	IN p_user_mail VARCHAR(50)
)
BEGIN
	DECLARE current_count INT;
	DECLARE max_count INT;

	SELECT COUNT(*) INTO current_count FROM Participates
	WHERE event_id = p_event_id;

	SELECT max_participants INTO max_count FROM Events
	WHERE event_id = p_event_id;

	IF current_count < max_count THEN
    	INSERT INTO Participates (event_id, user_id, user_mail)
    	VALUES (p_event_id, p_user_id, p_user_mail);

    	UPDATE Events
    	SET nb_participants = nb_participants + 1
    	WHERE event_id = p_event_id;
	ELSE
    	SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Event is full';
	END IF;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE GetGameRatings(IN p_game_id VARCHAR(50))
BEGIN
	SELECT r.Rate, r.Comments, u.user_mail
	FROM Rates r
	JOIN Users u
    	ON r.user_id = u.user_id AND r.user_mail = u.user_mail
	WHERE r.game_id = p_game_id;
END $$
DELIMITER ;

DELIMITER $$
CREATE PROCEDURE ListGameEvents(IN p_game_id VARCHAR(50))
BEGIN
	SELECT * FROM Events
	WHERE game_id = p_game_id
	ORDER BY event_name;
END $$
DELIMITER ;

delimiter //
create trigger update_avg_rate after insert on Rates
for each row
begin
	update Games
    set avg_rate = GetAverageRating(NEW.game_id)
    where id = NEW.game_id;
end;
//
delimiter ;

delimiter //
create trigger before_participating_insert before insert on Participates
for each row
begin 
	declare current_participants int;
    declare max_participants_allowed int;
    select nb_partipants into current_participants from Events where event_id = NEW.event_id;
    select max_participants into max_participants_allowed from Events where event_if = NEW.event_id;
    
    if current_participants = max_participant then 
		signal sqlstate '45000'
        set message_text = "Maximum number of participants already reached";
	end if;
end;
//
delimiter ;

delimiter //
create trigger update_number_participants after insert on Participates
for each row
begin
	update Events
    set nb_participants = nb_participants+1
    where event_id = NEW.event_id;
end;
//
delimiter ;

create table Events_log(
	log_id int auto_increment primary key, 
    event_id int, 
    event_name varchar(50), 
    log_date timestamp default current_timestamp
);
delimiter //
create trigger log_new_event after insert on Events
for each row
begin
	insert into Events_log(event_id, event_name) values (NEW.event_id, NEW.event_name);
end;
//
delimiter ;

delimiter //
create trigger before_user_insert before insert on Users
for each row
begin
	if char_length(NEW.password) < 8 then
		signal sqlstate '45000'
        set message_text = "The password must contain at least 8 characters";
	end if;
    
    if exists (select 1 from Users where user_mail = NEW.user_mail) then
		signal sqlstate '45000'
        set message_text = "An user with this email already exists";
    end if;
end;
//
delimiter ;

