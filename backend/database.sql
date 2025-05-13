drop database if exists advanceddata;
create database advanceddata;
use advanceddata;

CREATE TABLE Games(
   game_id VARCHAR(50),
   game_name VARCHAR(100),
   publication_year INT,
   game_image TEXT,
   game_url TEXT,
   game_description TEXT,
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
   user_id INT auto_increment,
   user_mail VARCHAR(50),
   password VARCHAR(255),
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
   event_id INT AUTO_INCREMENT,
   event_name VARCHAR(50),
   event_description TEXT,
   nb_participants INT,
   max_participants INT NOT NULL,
   min_participants INT,
   game_id VARCHAR(50) NOT NULL,
   event_date DATE,
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

INSERT INTO Games
  (game_id, game_name, publication_year, game_image, game_url, game_description)
VALUES
  ('30549', 'Pandemic',       2008,
    'https://cf.geekdo-images.com/S3ybV1LAp-8SnHIXLLjVqA__micro/img/S4tXI3Yo7BtqmBoKINLLVUFsaJ0=/fit-in/64x64/filters:strip_icc()/pic1534148.jpg',
    '/boardgame/30549/pandemic',
    'In Pandemic, several virulent diseases have broken out simultaneously all over the world; you and your team must race to discover cures before mankind is overwhelmed.'),

  ('822',   'Carcassonne',     2000,
    'https://cf.geekdo-images.com/okM0dq_bEXnbyQTOvHfwRA__micro/img/VfLoKzfk3xj26ArmDu55qZ4sysw=/fit-in/64x64/filters:strip_icc()/pic6544250.png',
    '/boardgame/822/carcassonne',
    'Carcassonne is a tile-placement game in which the players draw and place a tile with a piece of southern French landscape on it.'),

  ('13',    'Catan',           1995,
    'https://cf.geekdo-images.com/W3Bsga_uLP9kO91gZ7H8yw__micro/img/LA4OvGfQ_TXQ-2mhaIFZp2ITWpc=/fit-in/64x64/filters:strip_icc()/pic2419375.jpg',
    '/boardgame/13/catan',
    'In CATAN (formerly The Settlers of Catan), players try to be the dominant force on the island of Catan by building settlements, cities, and roads.'),

  ('68448', '7 Wonders',      2010,
    'https://cf.geekdo-images.com/RvFVTEpnbb4NM7k0IF8V7A__micro/img/9glsOs7zoTbkVpfDt5SHWJm-kRA=/fit-in/64x64/filters:strip_icc()/pic860217.jpg',
    '/boardgame/68448/7-wonders',
    'You are the leader of one of the 7 great cities of the Ancient World. Gather resources, develop your city, and out-score your neighbors.'),

  ('36218', 'Dominion',        2008,
    'https://cf.geekdo-images.com/j6iQpZ4XkemZP07HNCODBA__micro/img/PVxqHWOLTb3n-4xe62LJadr_M0I=/fit-in/64x64/filters:strip_icc()/pic394356.jpg',
    '/boardgame/36218/dominion',
    'You are a monarch, like your parents before you, a ruler of a small pleasant kingdom. Build your deck of cards to gain treasure, victory, and power.'),
    ('167791', 'Terraforming Mars', 2016,
    'https://cf.geekdo-images.com/wg9oOLcsKvDesSUdZQ4rxw__micro/img/LUkXZhd1TO80eCiXMD3-KfnzA6k=/fit-in/64x64/filters:strip_icc()/pic3536616.jpg',
    '/boardgame/167791/terraforming-mars',
    'In the 2400s, mankind begins to terraform the planet Mars. Giant corporations compete to raise oxygen, temperature, and ocean levels, building infrastructure and collecting victory points.'),

  ('230802', 'Azul', 2017,
    'https://cf.geekdo-images.com/tz19PfklMdAdjxV9WArraA__micro/img/N7xRslgynWzB3aObMBI9F1yKfQ8=/fit-in/64x64/filters:strip_icc()/pic3718275.jpg',
    '/boardgame/230802/azul',
    'Introduced by the Moors, azulejos (originally white and blue ceramic tiles) were used to decorate the walls and floors of the Royal Palace of Évora. Players draft tiles to decorate their palace walls.'),

  ('266192', 'Wingspan', 2019,
    'https://cf.geekdo-images.com/yLZJCVLlIx4c7eJEWUNJ7w__micro/img/5ZaRePVhfelfofF7T_OC1e0gUCw=/fit-in/64x64/filters:strip_icc()/pic4458123.jpg',
    '/boardgame/266192/wingspan',
    'Wingspan is a competitive, medium-weight, card-driven, engine-building board game about attracting birds to your wildlife preserves.'),

  ('9209', 'Ticket to Ride', 2004,
    'https://cf.geekdo-images.com/ZWJg0dCdrWHxVnc0eFXK8w__micro/img/79tvkijvf1wFKrKz-FWt77XdIbw=/fit-in/64x64/filters:strip_icc()/pic38668.jpg',
    '/boardgame/9209/ticket_to_ride',
    'With elegantly simple gameplay, Ticket to Ride can be learned in under 15 minutes. Collect cards, claim routes, and connect cities.'),

  ('148228', 'Splendor', 2014,
    'https://cf.geekdo-images.com/rwOMxx4q5yuElIvo-1-OFw__micro/img/VaWkmRffgWdhbynm-GUM4anrlic=/fit-in/64x64/filters:strip_icc()/pic1904079.jpg',
    '/boardgame/148228/splendor',
    'Splendor is a game of chip-collecting and card development. Players are merchants of the Renaissance, acquiring mines and trading to earn prestige.'),
    ('178900', 'Codenames', 2015,
    'https://cf.geekdo-images.com/F_KDEu0GjdClml8N7c8Imw__micro/img/w38Q9MZMQK80Att5GcODbCGufDk=/fit-in/64x64/filters:strip_icc()/pic2582929.jpg',
    '/boardgame/178900/codenames',
    'Codenames is an easy party game to solve puzzles. The game is divided into red and blue teams; each team’s spymaster gives one-word clues.'),

  ('174430', 'Gloomhaven', 2017,
    'https://cf.geekdo-images.com/sZYp_3BTDGjh2unaZfZmuA__micro/img/sQyh47ClBO3d5sxPm73hMvM-JV4=/fit-in/64x64/filters:strip_icc()/pic2437871.jpg',
    '/boardgame/174430/gloomhaven',
    'Gloomhaven is a game of Euro-inspired tactical combat in a persistent world of shifting motives. Players explore, fight, and level up their characters.'),

  ('161936', 'Pandemic Legacy: Season 1', 2015,
    'https://cf.geekdo-images.com/-Qer2BBPG7qGGDu6KcVDIw__micro/img/n6-sXYD6XXZoqIxq4P6AG7VPCuA=/fit-in/64x64/filters:strip_icc()/pic2452831.png',
    '/boardgame/161936/pandemic-legacy-season-1',
    'Pandemic Legacy is a co-operative campaign game, with an overarching story-arc played over multiple sessions. Your decisions affect future games.'),

  ('204680', 'Burrows and Badgers: A Skirmish Game of Anthropomorphic', 2016,
    'https://cf.geekdo-images.com/98A9G4dHHxZYHsjE5Z11Dw__micro/img/BF8Z7b2FTiR8tfQotF0MQ7WiXHI=/fit-in/64x64/filters:strip_icc()/pic4273355.jpg',
    '/boardgame/204680/burrows-and-badgers-skirmish-game-anthropomorphic',
    'A fast-paced tabletop miniatures skirmish game. Set in the ancient kingdom of Noquear, factions battle for control.'),

  ('237182', 'Root', 2018,
    'https://cf.geekdo-images.com/JUAUWaVUzeBgzirhZNmHHw__micro/img/tdHLiMYfi-KTy89sGBGZVeE9ts0=/fit-in/64x64/filters:strip_icc()/pic4254509.jpg',
    '/boardgame/237182/root',
    'Root is a game of adventure and war in which 2 to 4 (1 to 6 with the Riverfolk Expansion) players compete for control of a vast wilderness.');
    
INSERT INTO Users (user_id, user_mail, password) VALUES
  (1, 'alice@example.com', 'password123'),
  (2, 'bob@example.com',   'securepass'),
  (3, 'carol@example.com', 'qwerty!@#');

INSERT INTO Mechanics (mechanic_id, mechanic_name) VALUES
  (1, 'Card Drafting'),
  (2, 'Dice Rolling'),
  (3, 'Worker Placement'),
  (4, 'Area Control'),
  (5, 'Set Collection');

INSERT INTO Categories (category_id, category_name, category_description) VALUES
  (1, 'Strategy',  'Games involving strategic decision-making.'),
  (2, 'Family',    'Lightweight games for all ages.'),
  (3, 'Adventure', 'Games with exploration and quests.'),
  (4, 'Economic',  'Focus on money and resource management.'),
  (5, 'Thematic',  'Heavily story- or theme-driven games.');

INSERT INTO Designers (designer_id, designer_name) VALUES
  (1, 'Reiner Knizia'),
  (2, 'Uwe Rosenberg'),
  (3, 'Elizabeth Hargrave');

INSERT INTO Publishers (publisher_id, publisher_name) VALUES
  (1, 'Days of Wonder'),
  (2, 'Z-Man Games'),
  (3, 'Fantasy Flight Games');

INSERT INTO Artists (artist_id, artist_name) VALUES
  (1, 'Michael Menzel'),
  (2, 'Vincent Dutrait'),
  (3, 'Naomi Robinson');

INSERT INTO Has (game_id, mechanic_id) VALUES
  ('30549', 1), ('30549', 4),
  ('822',   5), ('822',   3),
  ('13',    2), ('13',    3),
  ('68448', 5), ('68448', 3),
  ('36218', 4), ('36218', 2),
  ('167791', 3), ('167791', 5),
  ('230802', 5),
  ('266192', 5),
  ('9209',   2),
  ('148228', 5),
  ('178900', 5), ('178900', 1),
  ('174430', 3),
  ('161936', 4),
  ('204680', 2),
  ('237182', 4);

INSERT INTO Has3 (game_id, category_id) VALUES
  ('30549', 2),  ('30549', 1),
  ('822',    2),  ('822',    3),
  ('13',     1),  ('13',     2),
  ('68448',  3),  ('68448',  1),
  ('36218',  4),  ('36218',  2),
  ('167791', 1),
  ('230802', 2),
  ('266192', 5),
  ('9209',   2),
  ('148228', 4),
  ('178900', 2),
  ('174430', 1),
  ('161936', 5),
  ('204680', 3),
  ('237182', 1);

INSERT INTO WorksOn (game_id, designer_id) VALUES
  ('30549', 3),
  ('822',   2),
  ('13',    1),
  ('68448', 1),
  ('36218', 1),
  ('167791',2),
  ('230802',1),
  ('266192',3),
  ('9209',   1),
  ('148228',2),
  ('178900',1),
  ('174430',2),
  ('161936',3),
  ('204680',1),
  ('237182',2);

INSERT INTO WorksOn2 (game_id, publisher_id) VALUES
  ('30549', 2),
  ('822',   2),
  ('13',    3),
  ('68448', 2),
  ('36218', 3),
  ('167791',2),
  ('230802',1),
  ('266192',2),
  ('9209',   1),
  ('148228',3),
  ('178900',2),
  ('174430',3),
  ('161936',2),
  ('204680',3),
  ('237182',1);

INSERT INTO WorksOn3 (game_id, artist_id) VALUES
  ('30549', 1),
  ('822',   3),
  ('13',    3),
  ('68448', 2),
  ('36218', 2),
  ('167791',1),
  ('230802',2),
  ('266192',3),
  ('9209',   3),
  ('148228',1),
  ('178900',3),
  ('174430',1),
  ('161936',2),
  ('204680',3),
  ('237182',1);

INSERT INTO Expansions (expansion_id, expansion_name, expansion_description, game_id) VALUES
  (101, 'Expansion 1',               'Expansion description 1',                        '30549'),
  (102, 'Expansion 2',               'Expansion description 2',                        '822'),
  (103, 'Expansion 3',               'Expansion description 3',                        '13'),
  (104, 'Expansion 4',               'Expansion description 4',                        '68448'),
  (105, 'Expansion 5',               'Expansion description 5',                        '36218'),
  (106, 'Prelude',                   'Ajoute des cartes Prelude pour un démarrage plus rapide.',          '167791'),
  (107, 'Stained Glass of Sintra',   'Nouvelles tuiles pour varier les motifs.',                        '230802'),
  (108, 'European Expansion',        'Comprend de nouveaux plateaux paysagers et oiseaux européens.',    '266192'),
  (109, '1910 Expansion',            'Ajoute des cartes destination et locomotives supplémentaires.',    '9209'),
  (110, 'Cities of Splendor',        'Apporte de nouveaux plateaux de ville et objectifs.',             '148228'),
  (111, 'Codenames: Duet',           'Variante coopérative à 2 joueurs.',                              '178900'),
  (112, 'Gloomhaven: Forgotten Circles', 'Campagne additionnelle avec nouvelles quêtes.',                  '174430'),
  (113, 'Pandemic Legacy: Season 2', 'Suite de la campagne pour prolonger l’expérience.',               '161936'),
  (114, 'Burrows & Badgers: Home Turf','Ajout de nouveaux scénarios et cartes.',                       '204680'),
  (115, 'Root: The Riverfolk Expansion','Nouvel ordre des Riverfolk et module de commerce.',            '237182');

INSERT INTO Events (event_id, event_name, event_description, nb_participants, max_participants, min_participants, game_id, event_date) VALUES
  (201, 'Event 1', 'Description for event 1', 11, 21, '2', '30549', '2025-05-25'),
  (202, 'Event 2', 'Description for event 2', 12, 22, '2', '822', '2025-05-30'),
  (203, 'Event 3', 'Description for event 3', 13, 23, '2', '13', '2025-06-24'),
  (204, 'Event 4', 'Description for event 4', 14, 24, '2', '68448', '2025-08-12'),
  (205, 'Event 5', 'Description for event 5', 15, 25, '2', '36218', '2025-09-27');

INSERT INTO Participates (user_id, user_mail, event_id) VALUES
  (1, 'alice@example.com', 201), (2, 'bob@example.com', 201), (3, 'carol@example.com', 201),
  (1, 'alice@example.com', 202), (2, 'bob@example.com', 202), (3, 'carol@example.com', 202),
  (1, 'alice@example.com', 203), (2, 'bob@example.com', 203), (3, 'carol@example.com', 203),
  (1, 'alice@example.com', 204), (2, 'bob@example.com', 204), (3, 'carol@example.com', 204),
  (1, 'alice@example.com', 205), (2, 'bob@example.com', 205), (3, 'carol@example.com', 205);



CREATE INDEX idx_games_publication_year ON Games(publication_year);
CREATE INDEX idx_rates_game_id ON Rates(game_id);
CREATE INDEX idx_events_game_id ON Events(game_id);
CREATE INDEX idx_has_mechanic_id ON Has(mechanic_id);
CREATE INDEX idx_workson_designer_id ON WorksOn(designer_id);
CREATE INDEX idx_categories_category_name ON Categories(category_name);


CREATE VIEW UserRatingHistory AS
SELECT 
    u.user_mail,
    g.game_id,
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
    e.event_id,
    COUNT(p.event_id) AS current_participants,
    e.max_participants, 
    e.event_date, 
    g.game_id,
    g.game_name,
    g.game_image
FROM Events e
LEFT JOIN Participates p ON e.event_id = p.event_id
LEFT JOIN Games g ON e.game_id = g.game_id
WHERE e.event_date BETWEEN CURDATE() AND DATE_ADD(CURDATE(), INTERVAL 1 MONTH)
GROUP BY e.event_id, e.event_name, e.event_description, e.event_date, e.max_participants, g.game_id, g.game_name, g.game_image;

CREATE VIEW GameDetails AS
SELECT 
	g.avg_rate,
	g.game_image,
	g.game_id,
    g.game_name,
    g.publication_year,
    g.game_description,
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
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Failed to add rating';
    END;
    START TRANSACTION;
    INSERT INTO Rates (Rate, Comments, game_id, user_id, user_mail)
    VALUES (p_rate, p_comments, p_game_id, p_user_id, p_user_mail);
    COMMIT;
END$$
DELIMITER ;


DELIMITER $$

CREATE PROCEDURE CreateEvent(
    IN p_event_name VARCHAR(50),
    IN p_event_description TEXT,
    IN p_nb_participants INT,
    IN p_max_participants INT,
    IN p_min_participants INT,
    IN p_game_id VARCHAR(50),
    IN p_event_date DATE
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Failed to create event';
    END;

    START TRANSACTION;

    INSERT INTO Events (
        event_name, event_description, nb_participants,
        max_participants, min_participants, game_id, event_date
    )
    VALUES (
        p_event_name, p_event_description, p_nb_participants,
        p_max_participants, p_min_participants, p_game_id, p_event_date
    );

    COMMIT;
END$$

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

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Failed to join event';
    END;

    START TRANSACTION;

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
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Event is full';
    END IF;

    COMMIT;
END$$

DELIMITER ;


DELIMITER $$
CREATE PROCEDURE GetGameRatings(IN p_game_id VARCHAR(50))
BEGIN
    SELECT user_mail, game_name, Rate, Comments, id_rate
    FROM UserRatingHistory
    WHERE game_id = p_game_id;
END $$
DELIMITER ;



DELIMITER $$

CREATE PROCEDURE LeaveEvent(
    IN p_event_id INT,
    IN p_user_id INT,
    IN p_user_mail VARCHAR(255)
)
BEGIN
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Failed to leave event';
    END;

    START TRANSACTION;

    DELETE FROM Participates
    WHERE event_id = p_event_id
      AND user_id = p_user_id
      AND user_mail = p_user_mail;

    UPDATE Events
    SET nb_participants = GREATEST(nb_participants - 1, 0)
    WHERE event_id = p_event_id;

    COMMIT;
END$$

DELIMITER ;


delimiter //
create trigger update_avg_rate after insert on Rates
for each row
begin
	update Games
    set avg_rate = GetAverageRating(NEW.game_id)
    where game_id = NEW.game_id;
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

INSERT INTO Rates (game_id, user_id, user_mail, Comments, Rate) VALUES

  ('30549', 1, 'alice@example.com', 'User 1 enjoyed game 30549', 6.5),
  ('30549', 2, 'bob@example.com',   'User 2 enjoyed game 30549', 7.0),
  ('30549', 3, 'carol@example.com', 'User 3 enjoyed game 30549', 7.5),
  ('822',   1, 'alice@example.com', 'User 1 enjoyed game 822',   6.5),
  ('822',   2, 'bob@example.com',   'User 2 enjoyed game 822',   7.0),
  ('822',   3, 'carol@example.com', 'User 3 enjoyed game 822',   7.5),
  ('13',    1, 'alice@example.com', 'User 1 enjoyed game 13',    6.5),
  ('13',    2, 'bob@example.com',   'User 2 enjoyed game 13',    7.0),
  ('13',    3, 'carol@example.com', 'User 3 enjoyed game 13',    7.5),
  ('68448', 1, 'alice@example.com', 'User 1 enjoyed game 68448', 6.5),
  ('68448', 2, 'bob@example.com',   'User 2 enjoyed game 68448', 7.0),
  ('68448', 3, 'carol@example.com', 'User 3 enjoyed game 68448', 7.5),
  ('36218', 1, 'alice@example.com', 'User 1 enjoyed game 36218', 6.5),
  ('36218', 2, 'bob@example.com',   'User 2 enjoyed game 36218', 7.0),
  ('36218', 3, 'carol@example.com', 'User 3 enjoyed game 36218', 7.5),

  ('167791', 1, 'alice@example.com', 'Stratégie très riche, un de mes préférés.',             8.20),
  ('167791', 2, 'bob@example.com',   'Parties un peu longues mais super theme.',            8.50),
  ('167791', 3, 'carol@example.com', 'Très immersif, cartes variées. À jouer souvent.',     8.00),
  ('230802', 1, 'alice@example.com', 'Belle réflexion, facile à expliquer aux débutants.',   7.80),
  ('230802', 2, 'bob@example.com',   'Design et matériel top, rejouabilité moyenne.',      8.00),
  ('230802', 3, 'carol@example.com', 'Jeu familial parfait pour 2-4 joueurs.',              7.50),
  ('266192', 1, 'alice@example.com', 'Mécanique fluide, super thème nature.',                8.40),
  ('266192', 2, 'bob@example.com',   'Cartes magnifiques, règles claires.',                 8.70),
  ('266192', 3, 'carol@example.com', 'Un peu cher mais vaut le coup.',                      8.20),
  ('9209',   1, 'alice@example.com', 'Classique indémodable, parties rapides.',              7.20),
  ('9209',   2, 'bob@example.com',   'Toujours fun même après 100 parties.',                7.50),
  ('9209',   3, 'carol@example.com', 'Parfait pour débuter en hobby.',                      7.00),
  ('148228', 1, 'alice@example.com', 'Mécanique d’achat simple et efficace.',               7.60),
  ('148228', 2, 'bob@example.com',   'Très bon jeu de collecte de ressources.',             7.80),
  ('148228', 3, 'carol@example.com', 'Idéal en famille, rapide à installer.',               7.40),

  ('178900', 1, 'alice@example.com', 'Super jeu d’ambiance, idéal en groupe.',           7.90),
  ('178900', 2, 'bob@example.com',   'Mécanique originale, très amusant.',               8.10),
  ('178900', 3, 'carol@example.com', 'Facile à expliquer, parties rapides.',             7.80),
  ('174430', 1, 'alice@example.com', 'Campagne épique, rejouabilité énorme.',           8.50),
  ('174430', 2, 'bob@example.com',   'Complexe mais gratifiant.',                       8.70),
  ('174430', 3, 'carol@example.com', 'Règles denses mais très immersif.',              8.40),
  ('161936', 1, 'alice@example.com', 'Meilleure campagne coopérative que j’ai jouée.',   8.60),
  ('161936', 2, 'bob@example.com',   'Émotions fortes, très narratif.',                  8.80),
  ('161936', 3, 'carol@example.com', 'Un peu cher mais extraordinaire.',               8.50),
  ('204680', 1, 'alice@example.com', 'Mécanique asymétrique très fun.',                  7.70),
  ('204680', 2, 'bob@example.com',   'Jeu de plateau original, simple à prendre en main.',7.60),
  ('204680', 3, 'carol@example.com', 'Variantes puissantes, bon theme.',                  7.80),
  ('237182', 1, 'alice@example.com', 'Asymétrie parfaite, top design.',                 8.30),
  ('237182', 2, 'bob@example.com',   'Très bon équilibre des factions.',                 8.50),
  ('237182', 3, 'carol@example.com', 'Parties tendues et stratégiques.',                8.20);
  
