DROP DATABASE IF EXISTS demo;
CREATE DATABASE demo;
USE demo;

CREATE TABLE users (
	id INT UNSIGNED AUTO_INCREMENT PRIMARY KEY,
	name VARCHAR(120) NOT NULL,
	last_name VARCHAR(120) NOT NULL,
	age INT UNSIGNED NOT NULL,
	email VARCHAR(220) NOT NULL,
	country VARCHAR(120) NOT NULL,
	city VARCHAR(120) NOT NULL
);

INSERT INTO users VALUES(1, 'Pablo', 'Sánchez', 25, 'correo_01@example.com', 'España', 'Almería');
INSERT INTO users VALUES(2, 'José', 'Benito', 35, 'correo_02@example.com', 'España', 'Madrid');
INSERT INTO users VALUES(3, 'María', 'Cruz', 38, 'correo_03@example.com', 'España', 'Barcelona');
INSERT INTO users VALUES(4, 'Antonio', 'Díaz', 28, 'correo_04@example.com', 'España', 'Almería');
INSERT INTO users VALUES(5, 'Pilar', 'Ruiz', 30, 'correo_05@example.com', 'España', 'Málaga');