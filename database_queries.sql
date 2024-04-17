-- 1. Afficher les cours par ordre de popularité --
-- a. Par nombre d’utilisateurs inscrits

SELECT c.num_cours, c.intitule_cours, COUNT(i.utilisateur_num_ut) AS nombre_inscriptions
FROM cours c
LEFT JOIN inscription i ON c.num_cours = i.cours_num_cours
GROUP BY c.num_cours
ORDER BY COUNT(i.utilisateur_num_ut) DESC;

-- b. Par meilleurs évaluation (notes sur 5 données par les utilisateurs d’un cours)
SELECT c.num_cours, c.intitule_cours, AVG(ns.noteSat) AS moyenne_evaluation
FROM cours c
LEFT JOIN note_satisfaction ns ON c.num_cours = ns.cours_num_cours
GROUP BY c.num_cours
ORDER BY AVG(ns.noteSat) DESC;

-- 2. Pour un cours donné, afficher la liste des utilisateurs --
-- a. Qui ont terminé le cours (toutes les parties ont été marquées comme validées)

SELECT DISTINCT u.num_ut, u.nom_ut, u.prenom_ut
FROM utilisateur u
JOIN progression p ON u.num_ut = p.utilisateur_num_ut
WHERE p.partieFinie_prog = 1
AND p.parties_num_part IN (SELECT num_part FROM parties WHERE chapitres_num_chap
IN (SELECT num_chap FROM chapitres WHERE cours_num_cours = 1));
-- On peut remplacer 1 par l'ID d'un autre cours, mais lors de cette génération de données, seulement 1 et 6 fonctionnent

-- b. Qui ont tenté au moins une fois tous les examens du cours

SELECT u.num_ut, u.nom_ut, u.prenom_ut
FROM utilisateur u
JOIN tentative t ON u.num_ut = t.utilisateur_num_ut
JOIN examen e ON t.examen_num_exam = e.num_exam
JOIN parties p ON e.parties_num_part = p.num_part
JOIN chapitres ch ON p.chapitres_num_chap = ch.num_chap
JOIN cours c ON ch.cours_num_cours = c.num_cours
WHERE c.num_cours = 1
GROUP BY u.num_ut
HAVING COUNT(DISTINCT e.num_exam) = (SELECT COUNT(*) FROM examen e2
   JOIN parties p2 ON e2.parties_num_part = p2.num_part
   JOIN chapitres ch2 ON p2.chapitres_num_chap = ch2.num_chap
   WHERE ch2.cours_num_cours = 1);
-- Remplacer 1 par l'ID du cours souhaité (c.num_cours et ch2.cours_num_cours)
-- Ici 1 fonctionne car l'utilisateur 3 a fait au moins une tentative pour chaque examen de chaque partie du cours 1

-- c. Qui ont validés le cours (réussi tous les examens)
SELECT u.num_ut, u.nom_ut, u.prenom_ut
FROM utilisateur u
JOIN tentative t ON u.num_ut = t.utilisateur_num_ut
JOIN examen e ON t.examen_num_exam = e.num_exam
JOIN parties p ON e.parties_num_part = p.num_part
JOIN chapitres ch ON p.chapitres_num_chap = ch.num_chap
JOIN cours c ON ch.cours_num_cours = c.num_cours
WHERE c.num_cours = 1
AND t.scoreObt_tent >= e.scoreMin_exam
GROUP BY u.num_ut
HAVING COUNT(DISTINCT e.num_exam) = (SELECT COUNT(*) FROM examen e2
   JOIN parties p2 ON e2.parties_num_part = p2.num_part
   JOIN chapitres ch2 ON p2.chapitres_num_chap = ch2.num_chap
   WHERE ch2.cours_num_cours = 1);
-- Remplacer 1 par l'ID du cours souhaité (c.num_cours et ch2.cours_num_cours)
-- Ici 1 fonctionne car l'utilisateur 3 a réussi tous les examens de chaque partie du cours 1


-- 3. Afficher la liste des utilisateurs par ordre de dépenses (les utilisateurs qui ont
--    dépensé le plus d’argent en achetant des cours payants. On doit voir le montant dépensé dans
--    le résultat de la requête) --

SELECT u.num_ut, u.nom_ut, u.prenom_ut, SUM(p.montant_paie) AS montant_depense
FROM utilisateur u
JOIN paiement p ON u.num_ut = p.utilisateur_num_ut
GROUP BY u.num_ut
ORDER BY SUM(p.montant_paie) DESC;

-- 4. Afficher les parties d’un cours, ordonnées par chapitres et ordre dans les chapitres --

SELECT p.num_part, p.titre_part, p.contenu_part, p.chapitres_num_chap
FROM parties p
JOIN chapitres c ON p.chapitres_num_chap = c.num_chap
WHERE c.cours_num_cours = 1
ORDER BY c.num_chap, p.num_part;
-- Si on veut afficher les parties d'un autre cours, on peut remplacer 1 par l'ID du cours souhaité (c.cours_num_cours)

-- 5. Afficher tous les cours ainsi que les créateurs de cours et formateurs qui y sont rattachés --

SELECT c.num_cours, c.intitule_cours, u.num_ut, u.nom_ut, u.prenom_ut, r.nom_role
FROM cours c
JOIN creation cr ON c.num_cours = cr.cours_num_cours
JOIN utilisateur u ON cr.utilisateur_num_ut = u.num_ut
JOIN utilisateur_role ur ON u.num_ut = ur.utilisateur_num_ut
JOIN role r ON ur.role_id_role = r.id_role
WHERE r.nom_role IN ('createur', 'formateur', 'administrateur')
ORDER BY c.num_cours;

-- 6. Pour un utilisateur donné, affiché les cours auxquels il est inscrit, ainsi que son pourcentage
--    de progression de chaque cours (nombre de parties marquées comme terminées par rapport au nombre
--    de parties totales du cours) --

SELECT u.num_ut, u.nom_ut, u.prenom_ut, i.cours_num_cours, c.intitule_cours,
  COUNT(DISTINCT p.num_part) AS parties_totales,
  SUM(CASE WHEN pr.partieFinie_prog = 1 THEN 1 ELSE 0 END) AS parties_terminees,
  (SUM(CASE WHEN pr.partieFinie_prog = 1 THEN 1 ELSE 0 END) / COUNT(DISTINCT p.num_part)) * 100 AS pourcentage_progression
FROM utilisateur u
JOIN inscription i ON u.num_ut = i.utilisateur_num_ut
JOIN cours c ON i.cours_num_cours = c.num_cours
JOIN chapitres ch ON c.num_cours = ch.cours_num_cours
JOIN parties p ON ch.num_chap = p.chapitres_num_chap
LEFT JOIN progression pr ON u.num_ut = pr.utilisateur_num_ut AND p.num_part = pr.parties_num_part
WHERE u.num_ut = 3
GROUP BY u.num_ut, i.cours_num_cours
ORDER BY c.num_cours;
-- Remplacer 3 par l'ID d'un autre utilisateur pour voir ses cours et sa progression
-- Cela fonctionne avec 2 mais cet utilisateur n'a pas de progression dans les parties
-- Pour le reste ce sont des données aléatoires donc les réusltats sont vides car pas forcémment liés à une partie elle même liée à un chapitre, à un cours, etc.


