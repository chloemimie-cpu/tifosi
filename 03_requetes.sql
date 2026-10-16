-- Fichier : 03_requetes.sql
USE tifosi;
SET NAMES utf8mb4;

-- ============================================================
-- Requête 1 : liste des noms des foccacias par ordre alphabétique croissant
-- ============================================================
-- Résultat attendu : 8 lignes : Américaine, Emmentalaccia, Gorgonzollaccia,
--                    Hawaienne, Mozaccia, Paysanne, Raclaccia, Tradizione
-- Résultat obtenu  : 8 lignes : Américaine, Emmentalaccia, Gorgonzollaccia,
--                    Hawaienne, Mozaccia, Paysanne, Raclaccia, Tradizione
-- Commentaire      : pas d'écart.
SELECT nom
FROM foccacia
ORDER BY nom ASC;

-- ============================================================
-- Requête 2 : nombre total d'ingrédients
-- ============================================================
-- Résultat attendu : 25
-- Résultat obtenu  : 25
-- Commentaire      : pas d'écart.
SELECT COUNT(*) AS nombre_ingredients
FROM ingredient;

-- ============================================================
-- Requête 3 : prix moyen des foccacias
-- ============================================================
-- Résultat attendu : 83,00 / 8 = 10,375
-- Résultat obtenu  : 10.38
-- Commentaire      : 10,375 est arrondi à 10,38 par ROUND(..., 2).
SELECT ROUND(AVG(prix), 2) AS prix_moyen
FROM foccacia;

-- ============================================================
-- Requête 4 : liste des boissons avec leur marque, triée par nom de boisson
-- ============================================================
-- Résultat attendu : 12 lignes, de « Capri-sun | Coca-cola »
--                    à « Pepsi Max Zéro | Pepsico »
-- Résultat obtenu  : 12 lignes : Capri-sun | Coca-cola,
--                    Coca-cola original | Coca-cola, Coca-cola zéro | Coca-cola,
--                    Eau de source | Cristalline, Fanta citron | Coca-cola,
--                    Fanta orange | Coca-cola, Lipton Peach | Pepsico,
--                    Lipton zéro citron | Pepsico,
--                    Monster energy ultra blue | Monster,
--                    Monster energy ultra gold | Monster, Pepsi | Pepsico,
--                    Pepsi Max Zéro | Pepsico
-- Commentaire      : pas d'écart.
SELECT b.nom AS boisson, m.nom AS marque
FROM boisson b
JOIN marque m ON m.id_marque = b.id_marque
ORDER BY b.nom;

-- ============================================================
-- Requête 5 : liste des ingrédients de la Raclaccia
-- ============================================================
-- Résultat attendu : 7 lignes : Ail, Base Tomate, Champignon, Cresson,
--                    Parmesan, Poivre, Raclette
-- Résultat obtenu  : 7 lignes : Ail, Base Tomate, Champignon, Cresson,
--                    Parmesan, Poivre, Raclette
-- Commentaire      : pas d'écart.
SELECT i.nom AS ingredient
FROM comprend c
JOIN foccacia f ON f.id_foccacia = c.id_foccacia
JOIN ingredient i ON i.id_ingredient = c.id_ingredient
WHERE f.nom = 'Raclaccia'
ORDER BY i.nom;

-- ============================================================
-- Requête 6 : nom et nombre d'ingrédients pour chaque foccacia
-- ============================================================
-- Résultat attendu : Américaine 8, Emmentalaccia 7, Gorgonzollaccia 8,
--                    Hawaienne 9, Mozaccia 10, Paysanne 12, Raclaccia 7,
--                    Tradizione 9
-- Résultat obtenu  : Américaine 8, Emmentalaccia 7, Gorgonzollaccia 8,
--                    Hawaienne 9, Mozaccia 10, Paysanne 12, Raclaccia 7,
--                    Tradizione 9
-- Commentaire      : pas d'écart.
SELECT f.nom AS foccacia, COUNT(c.id_ingredient) AS nombre_ingredients
FROM foccacia f
JOIN comprend c ON c.id_foccacia = f.id_foccacia
GROUP BY f.id_foccacia, f.nom
ORDER BY f.nom;

-- ============================================================
-- Requête 7 : nom de la foccacia qui a le plus d'ingrédients
-- ============================================================
-- Résultat attendu : Paysanne (12 ingrédients)
-- Résultat obtenu  : Paysanne | 12
-- Commentaire      : pas d'écart. Aucune égalité pour la première place,
--                    donc LIMIT 1 suffit.
SELECT f.nom AS foccacia, COUNT(c.id_ingredient) AS nombre_ingredients
FROM foccacia f
JOIN comprend c ON c.id_foccacia = f.id_foccacia
GROUP BY f.id_foccacia, f.nom
ORDER BY nombre_ingredients DESC
LIMIT 1;

-- ============================================================
-- Requête 8 : liste des foccacias qui contiennent de l'ail
-- ============================================================
-- Résultat attendu : 4 foccacias : Gorgonzollaccia, Mozaccia, Paysanne,
--                    Raclaccia
-- Résultat obtenu  : 4 foccacias : Gorgonzollaccia, Mozaccia, Paysanne,
--                    Raclaccia
-- Commentaire      : pas d'écart.
SELECT f.nom AS foccacia
FROM foccacia f
JOIN comprend c ON c.id_foccacia = f.id_foccacia
JOIN ingredient i ON i.id_ingredient = c.id_ingredient
WHERE i.nom = 'Ail'
ORDER BY f.nom;

-- ============================================================
-- Requête 9 : liste des ingrédients inutilisés
-- ============================================================
-- Résultat attendu : Salami et Tomate cerise (aucune foccacia ne les contient)
-- Résultat obtenu  : Salami, Tomate cerise
-- Commentaire      : pas d'écart.
SELECT i.nom AS ingredient
FROM ingredient i
LEFT JOIN comprend c ON c.id_ingredient = i.id_ingredient
WHERE c.id_foccacia IS NULL;

-- ============================================================
-- Requête 10 : liste des foccacias qui n'ont pas de champignon
-- ============================================================
-- Résultat attendu : Américaine et Hawaienne (aucune des deux ne contient
--                    de champignon)
-- Résultat obtenu  : Américaine, Hawaienne
-- Commentaire      : pas d'écart.
SELECT nom
FROM foccacia
WHERE id_foccacia NOT IN (
  SELECT c.id_foccacia
  FROM comprend c
  JOIN ingredient i ON i.id_ingredient = c.id_ingredient
  WHERE i.nom = 'Champignon'
);