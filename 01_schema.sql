-- Fichier : 01_schema.sql
USE tifosi;

-- 1. Suppressions : enfants d'abord, parents ensuite
DROP TABLE IF EXISTS comprend;
DROP TABLE IF EXISTS achete;
DROP TABLE IF EXISTS contient;
DROP TABLE IF EXISTS menu;
DROP TABLE IF EXISTS boisson;
DROP TABLE IF EXISTS marque;
DROP TABLE IF EXISTS ingredient;
DROP TABLE IF EXISTS client;
DROP TABLE IF EXISTS foccacia;


-- 2. Créations : parents d'abord, enfants ensuite
CREATE TABLE ingredient (
  id_ingredient INT AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE marque (
  id_marque INT AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE client (
  id_client INT AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(50) NOT NULL,
  email VARCHAR(150) NOT NULL UNIQUE,
  code_postal INT NOT NULL
);

CREATE TABLE boisson (
  id_boisson INT AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(50) NOT NULL UNIQUE,
  id_marque INT NOT NULL,
  FOREIGN KEY (id_marque) REFERENCES marque(id_marque)
);
CREATE TABLE foccacia (
  id_foccacia INT AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(50) NOT NULL UNIQUE,
  prix DECIMAL(5,2) NOT NULL,
  CHECK (prix >= 0)
);

CREATE TABLE menu (
  id_menu INT AUTO_INCREMENT PRIMARY KEY,
  nom VARCHAR(50) NOT NULL UNIQUE,
  prix DECIMAL(5,2) NOT NULL,
  id_foccacia INT NOT NULL,
  FOREIGN KEY (id_foccacia) REFERENCES foccacia(id_foccacia),
  CHECK (prix >= 0)
);

CREATE TABLE comprend (
  id_foccacia INT NOT NULL,
  id_ingredient INT NOT NULL,
  quantite INT NOT NULL,
  PRIMARY KEY (id_foccacia, id_ingredient),
  FOREIGN KEY (id_foccacia) REFERENCES foccacia(id_foccacia),
  FOREIGN KEY (id_ingredient) REFERENCES ingredient(id_ingredient),
  CHECK (quantite > 0)
);

CREATE TABLE achete (
  id_client INT NOT NULL,
  id_menu INT NOT NULL,
  date_achat DATE NOT NULL,
  PRIMARY KEY (id_client, id_menu, date_achat),
  FOREIGN KEY (id_client) REFERENCES client(id_client), 
    FOREIGN KEY (id_menu) REFERENCES menu(id_menu)
);

CREATE TABLE contient (
    id_menu INT NOT NULL,
    id_boisson INT NOT NULL,
    PRIMARY KEY (id_menu, id_boisson),
    FOREIGN KEY (id_menu) REFERENCES menu(id_menu),
    FOREIGN KEY (id_boisson) REFERENCES boisson(id_boisson)
);