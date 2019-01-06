psql -U dev -f ./noteful-app.1.sql -d noteful-app;

DROP TABLE if EXISTS notes_tags;
DROP TABLE IF EXISTS notes;
DROP TABLE if EXISTS folders;
DROP TABLE if EXISTS tags;


CREATE TABLE folders (
    id serial PRIMARY KEY,
    name text NOT NULL
);

ALTER SEQUENCE folders_id_seq RESTART WITH 100;

INSERT INTO folders (name) VALUES
    ('Archive'),
    ('Drafts'),
    ('Personal'),
    ('Work');



CREATE TABLE notes(
id serial PRIMARY KEY,
title text NOT NULL,
content text NOT NULL,
created TIMESTAMP DEFAULT current_timestamp,
folder_id int REFERENCES folders(id) ON DELETE SET NULL
);

ALTER SEQUENCE notes_id_seq RESTART WITH 1000;

INSERT INTO notes
(title, content, folder_id)
VALUES 
('5 life lessons learned from cats', '1) Have Fun 2) Spook 3) Always find the yarn 4) Bigger is better 5) No dogs', 100),
('What the government doesn''t want you to know about cats', 'The government hates cats!',100),
('The most boring article about ham you''ll ever read', 'Ham is in fact meat beans', 101),
('You''l never guess how man cats Vageta has', 'Over 9000', 102),
('10 ways cats can help you live to 100', 'They can''t, they''re trying to kill you.', 101),
('3 reasons you can blame the recession on dogs', '1) they are not feline 2) they are dumb 3) They eat ham but not beans', 102),
('Bacon or beans', 'More beans more problems, I always say!', 103),
('Why you should forget everything you learned about cats', 'They are an enigma, do not try and define them.', 103)
;

CREATE TABLE tags(
    id serial PRIMARY KEY,
    name text UNIQUE NOT NULL
);

ALTER SEQUENCE tags_id_seq RESTART WITH 170;

INSERT INTO tags
(name)
VALUES 
('news'), 
('lifestyle'), 
('facts');

CREATE TABLE notes_tags (
    note_id INTEGER NOT NULL REFERENCES notes ON DELETE CASCADE,
    tag_id INTEGER NOT NULL REFERENCES tags ON DELETE CASCADE,
    PRIMARY KEY (note_id, tag_id)
);

INSERT INTO notes_tags
(note_id, tag_id)
VALUES 
(1000, 171),
(1000, 172),
(1001, 170),
(1002, 172),
(1002, 170),
(1003, 171),
(1004, 172),
(1005, 171),
(1006, 172),
(1007, 171),
(1008, 170),
(1008, 171);
