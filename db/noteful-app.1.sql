-- psql -U dev -f ./noteful-app.1.sql -d noteful-app;

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
VALUES ('5 life lessons learned from cats', 'Find the Yarn. Bigger is better. No dogs. Spook! Naps on Naps.',100),
('The most boring article about cats you''ll ever read', 'there is no such thing as a boring cat.', 101),
('You will never guess how many cats Vageta owns!', 'over 9000', 100),
('The most incredible article about meat you''ll ever read', 'Beans are Ham, but smaller.', 102),
('10 ways dogs can help you live to 100', 'Bark. woof. growl. beg. eat. play. smell. warsh. chase. sleep.', 101),
('9 reasons you can blame the recession on cats', 'Iz cheezburger', 102),
('Ham or beans?', 'Yes.', 103),
('Why you should forget everything you learned about cats', 'They are an enigma that cannot be defined.', 103)
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
(1001, 172),
(1002, 172),
(1003, 171),
(1004, 172),
(1005, 171),
(1006, 172),
(1007, 171),
(1007, 170);
