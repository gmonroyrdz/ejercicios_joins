DROP database library;
CREATE database library;
USE library;
CREATE TABLE author(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT, 
    first_name VARCHAR(100),
    last_name VARCHAR(100)
);

CREATE TABLE editor(
    id INT PRIMARY KEY NOT NULL  AUTO_INCREMENT,
    first_name VARCHAR(100),
    last_name VARCHAR(100)
);

CREATE TABLE traslator(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(100),
    last_name VARCHAR(100)
);
CREATE TABLE book(
    id INT PRIMARY KEY NOT NULL AUTO_INCREMENT,
    title VARCHAR(100),
    type VARCHAR(40),
    author_id INT,
    editor_id INT,
    traslator_id INT,
    FOREIGN KEY (author_id) REFERENCES author(id) ON DELETE CASCADE,
    FOREIGN KEY (editor_id) REFERENCES editor(id) ON DELETE CASCADE,
    FOREIGN KEY (traslator_id) REFERENCES traslator(id) ON DELETE CASCADE
);
