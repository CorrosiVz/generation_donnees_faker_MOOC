-- Cours, Le prix d'un cours doit être supérieur ou égal à 0 (donc peut être gratuit)
ALTER TABLE cours
ADD CONSTRAINT prix_cours_check_gratuit
CHECK (prix_cours >= 0);

-- Examen, le score minium doit être compris entre 40 et 100
ALTER TABLE examen
ADD CONSTRAINT scoreMin_exam_check
CHECK (scoreMin_exam >= 40 AND scoreMin_exam <= 100);

-- Tentative, le score doit être compris entre 0 et 100
ALTER TABLE tentative
ADD CONSTRAINT score_tentative_check
CHECK (scoreObt_tent >= 0 AND scoreObt_tent <= 100);

-- Utilisateur

-- Note de satisfaction, la note de satisfaction laissée par un utilisateur peut être soit 1, 2, 3, 4 ou 5
ALTER TABLE note_satisfaction
ADD CONSTRAINT note_satisfaction_check
CHECK (noteSat IS NULL OR (noteSat>=1 AND noteSat<=5));

-- Session, la date de début doit être inférieure à la date de fin; il ne peut pas avoir de placemax négatives
ALTER TABLE session
ADD CONSTRAINT date_session_check
CHECK (dateDebut_session < dateFin_session);

ALTER TABLE session
ADD CONSTRAINT placemax_session_check
CHECK (placeMax_session IS NULL OR placeMax_session >= 0);