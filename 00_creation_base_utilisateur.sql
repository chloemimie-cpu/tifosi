-- 1. Création de la base
CREATE DATABASE IF NOT EXISTS tifosi
  CHARACTER SET utf8mb4
  COLLATE utf8mb4_unicode_ci;

-- 2. Création de l'utilisateur
CREATE USER IF NOT EXISTS 'tifosi'@'localhost' IDENTIFIED BY 'tifosi';

-- 3. Droits sur la base tifosi uniquement
GRANT ALL PRIVILEGES ON tifosi.* TO 'tifosi'@'localhost';

-- 4. Application des droits
FLUSH PRIVILEGES;