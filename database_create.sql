-- Created by Vertabelo (http://vertabelo.com)
-- Last modification date: 2024-04-13 17:55:47.628

-- tables
-- Table: chapitres
CREATE TABLE chapitres (
    num_chap int  NOT NULL AUTO_INCREMENT COMMENT 'Numéro identifiant un chapitre.',
    titre_chap Text  NOT NULL,
    cours_num_cours int  NOT NULL COMMENT 'Numéro permettant d''''identifier un cours.',
    CONSTRAINT chapitres_pk PRIMARY KEY (num_chap)
) COMMENT 'Les chapitres peuvent organiser des cours et ils peuvent contenir des parties de cours.';

-- Table: cours
CREATE TABLE cours (
    num_cours int  NOT NULL AUTO_INCREMENT COMMENT 'Numéro permettant d''''identifier un cours.',
    intitule_cours Text  NOT NULL COMMENT 'Intitulé d''''un cours de la plateforme MOOC',
    desc_cours Text  NOT NULL COMMENT 'Description du cours',
    prerequis_cours Text  NOT NULL COMMENT 'Pré-requis d''''un cours',
    prix_cours int  NOT NULL COMMENT 'Prix d''''un cours (les cours peuvent être gratuits).
Si un utilisateur n''''a pas payé le prix d''''un cours, alors il ne peut pas s''''inscrire.',
    dateDebut_cours datetime  NULL COMMENT 'Date de début d''''un cours. La date est optionnelle, si il y a une date indiquée, alors le cours sera visible ou non.',
    dateFin_cours datetime  NULL,
    noteSatGlob_cours float  NULL COMMENT 'Note de satisfaction globale d''''un cours. La note doit être comprise entre 1 et 5.',
    session_num_session int  NOT NULL COMMENT 'Numéro identifiant de la session de cours.',
    CONSTRAINT cours_pk PRIMARY KEY (num_cours)
) COMMENT 'Cours de la plateforme MOOC';

-- Table: creation
CREATE TABLE creation (
    id_crea int  NOT NULL AUTO_INCREMENT COMMENT 'Numéro identifiant d''''une création d''''un cours par un utilisateur créateur de cours ou un éditeur',
    date_crea datetime  NOT NULL COMMENT 'Date et heure de création d''''un cours',
    detailsModif_crea Text  NOT NULL COMMENT 'Détails de la modification d''''un cours',
    cours_num_cours int  NOT NULL COMMENT 'Numéro permettant d''''identifier un cours.',
    utilisateur_num_ut int  NOT NULL COMMENT 'Numéro identifiant d''''un utilisateur inscrit à la MOOC',
    CONSTRAINT creation_pk PRIMARY KEY (id_crea)
) COMMENT 'Création et modification d''''un cours par un utilisateur créateur de cours ou un éditeur';

-- Table: examen
CREATE TABLE examen (
    num_exam int  NOT NULL AUTO_INCREMENT COMMENT 'Numéro identifiant un examen.',
    titre_exam Text  NOT NULL COMMENT 'Titre d''''un examen',
    contenu_exam Text  NOT NULL COMMENT 'Contenu d''''un examen (en format texte)',
    scoreMin_exam int  NOT NULL COMMENT 'Score minimum qu''''un utilisateur étudiant doit obtenir afin de valider un examen. Le score minimum doit être compris entre 40 et 100.',
    parties_num_part int  NOT NULL COMMENT 'Numéro identifiant une partie.',
    CONSTRAINT examen_pk PRIMARY KEY (num_exam)
) COMMENT 'Examen permettant d''''évaluer une partie d''''un cours, dont un utilisateur étudiant peut accéder afin d''''effectuer des tentatives.';

-- Table: inscription
CREATE TABLE inscription (
    num_in int  NOT NULL AUTO_INCREMENT COMMENT 'Numéro identifiant une inscription d''''un utilisateur à un cours.',
    date_in datetime  NOT NULL COMMENT 'Date à laquelle un utilisateur a été inscrit à un cours.',
    utilisateur_num_ut int  NOT NULL COMMENT 'Numéro identifiant d''''un utilisateur inscrit à la MOOC',
    cours_num_cours int  NOT NULL COMMENT 'Numéro permettant d''''identifier un cours.',
    CONSTRAINT inscription_pk PRIMARY KEY (num_in)
) COMMENT 'Inscription des utilisateurs à un cours.';

-- Table: note_satisfaction
CREATE TABLE note_satisfaction (
    id_note int  NOT NULL AUTO_INCREMENT COMMENT 'Numéro identifiant une note de satisfaction laissée par un utilisateur à un cours.',
    utilisateur_num_ut int  NOT NULL COMMENT 'Numéro identifiant d''''un utilisateur inscrit à la MOOC',
    cours_num_cours int  NOT NULL COMMENT 'Numéro permettant d''''identifier un cours.',
    noteSat int  NULL COMMENT 'Note de satisfaction laissée par un utilisateur à un cours d''''une MOOC. La note est optionnelle et doit être comprise entre 1 et 5.',
    commentaire Text  NULL COMMENT 'Commentaire de satisfaction laissé par un utilisateur à un cours d''''une MOOC. Le commentaire est optionnel.',
    CONSTRAINT note_satisfaction_pk PRIMARY KEY (id_note)
) COMMENT 'Note et commentaire de satisfaction laissé par un utilisateur pour un cours.';

-- Table: paiement
CREATE TABLE paiement (
    id_paie int  NOT NULL AUTO_INCREMENT COMMENT 'Numéro identifiant un paiement d''''un utilisateur étudiant',
    montant_paie int  NOT NULL COMMENT 'Montant du paiement effectué par un utilisateur étudiant',
    date_paie datetime  NOT NULL COMMENT 'Date et heure du paiement effectué par un utilisateur étudiant',
    statut_paie Text  NOT NULL COMMENT 'Si le paiement est confirmé, en attente, ou annulé',
    cours_num_cours int  NOT NULL COMMENT 'Numéro permettant d''''identifier un cours.',
    utilisateur_num_ut int  NOT NULL COMMENT 'Numéro identifiant d''''un utilisateur inscrit à la MOOC',
    CONSTRAINT paiement_pk PRIMARY KEY (id_paie)
) COMMENT 'Table des paiements effectués par un utilisateur étudiant pour accéder à un cours';

-- Table: parties
CREATE TABLE parties (
    num_part int  NOT NULL AUTO_INCREMENT COMMENT 'Numéro identifiant une partie.',
    titre_part Text  NOT NULL COMMENT 'Titre d''''une partie de cours',
    contenu_part Text  NOT NULL COMMENT 'Contenu d''''une partie d''''un cours (HTML stocké en format texte)',
    chapitres_num_chap int  NOT NULL COMMENT 'Numéro identifiant un chapitre.',
    CONSTRAINT parties_pk PRIMARY KEY (num_part)
) COMMENT 'Parties d''''un cours de la plateforme MOOC';

-- Table: progression
CREATE TABLE progression (
    num_prog int  NOT NULL AUTO_INCREMENT COMMENT 'Numéro identifiant une progression d''''un utilisateur à une partie de cours.',
    partieFinie_prog boolean  NOT NULL COMMENT 'Indicateur montrant la progression de l''''utilisateur.
Quand c''''est 0 : Utilisateur n''''a pas progressé
Quand c''''est 1 : Utilisateur a progressé',
    date_prog datetime  NOT NULL COMMENT 'Date de la progression d''''une partie d''''un cours',
    utilisateur_num_ut int  NOT NULL COMMENT 'Numéro identifiant d''''un utilisateur inscrit à la MOOC',
    parties_num_part int  NOT NULL COMMENT 'Numéro identifiant une partie.',
    CONSTRAINT progression_pk PRIMARY KEY (num_prog)
) COMMENT 'Table de la progression d''''une partie d''''un cours d''''un utilisateur étudiant.';

-- Table: role
CREATE TABLE role (
    id_role int  NOT NULL AUTO_INCREMENT,
    nom_role Text  NOT NULL,
    desc_role Text  NOT NULL,
    CONSTRAINT role_pk PRIMARY KEY (id_role)
) COMMENT 'chaque utilisateur a un ou plusieurs rôles (étudiant, formateur, administrateur)';

-- Table: session
CREATE TABLE session (
    num_session int  NOT NULL AUTO_INCREMENT COMMENT 'Numéro identifiant de la session de cours.',
    presentiel_session boolean  NOT NULL COMMENT 'Booléen indiquant si la session de cours est en présentiel ou en distanciel
Si la session est en présentiel booléen = 1
Si la session est en distanciel booléen = 0',
    dateDebut_session datetime  NOT NULL COMMENT 'Date de début d''''une session de cours',
    dateFin_session datetime  NOT NULL COMMENT 'Date de fin d''''une session de cours',
    placeMax_session int  NULL COMMENT 'Places maximum d''''une session de cours (nombre max d''''utilisateurs pouvant rejoindre une session). PlaceMax est optionnel.',
    CONSTRAINT session_pk PRIMARY KEY (num_session)
) COMMENT 'Sessions de cours dispensées par la plateforme MOOC';

-- Table: tentative
CREATE TABLE tentative (
    num_tent int  NOT NULL AUTO_INCREMENT COMMENT 'Numéro identifiant une tentative',
    scoreObt_tent int  NOT NULL COMMENT 'Score obtenu par un étudiant d''''une tentative corrigée par un formateur. Le score doit être compris entre 0 et 100.',
    date_tent datetime  NOT NULL COMMENT 'Date à laquelle un utilisateur étudiant a terminé une tentative',
    utilisateur_num_ut int  NOT NULL COMMENT 'Numéro identifiant d''''un utilisateur inscrit à la MOOC',
    examen_num_exam int  NOT NULL COMMENT 'Numéro identifiant un examen.',
    CONSTRAINT tentative_pk PRIMARY KEY (num_tent)
) COMMENT 'Tentatives d''''un utilisateur étudiant faites sur un examen';

-- Table: utilisateur
CREATE TABLE utilisateur (
    num_ut int  NOT NULL AUTO_INCREMENT COMMENT 'Numéro identifiant d''''un utilisateur inscrit à la MOOC',
    nom_ut Text  NOT NULL COMMENT 'Nom de l''''utilisateur inscrit',
    prenom_ut Text  NOT NULL COMMENT 'Prénom de l''''utilisateur inscrit',
    mail_ut Text  NOT NULL,
    session_num_session int  NOT NULL COMMENT 'Numéro identifiant de la session de cours.',
    CONSTRAINT utilisateur_pk PRIMARY KEY (num_ut)
) COMMENT 'Utilisateurs inscrits sur la plateforme MOOC';

-- Table: utilisateur_role
CREATE TABLE utilisateur_role (
    utilisateur_num_ut int  NOT NULL COMMENT 'Numéro identifiant d''''un utilisateur inscrit à la MOOC',
    role_id_role int  NOT NULL,
    CONSTRAINT utilisateur_role_pk PRIMARY KEY (utilisateur_num_ut,role_id_role)
) COMMENT 'Le rôle de l''''utilisateur';

-- foreign keys
-- Reference: chapitres_cours (table: chapitres)
ALTER TABLE chapitres ADD CONSTRAINT chapitres_cours FOREIGN KEY chapitres_cours (cours_num_cours)
    REFERENCES cours (num_cours);

-- Reference: cours_inscription (table: inscription)
ALTER TABLE inscription ADD CONSTRAINT cours_inscription FOREIGN KEY cours_inscription (cours_num_cours)
    REFERENCES cours (num_cours);

-- Reference: cours_note_satisfaction (table: note_satisfaction)
ALTER TABLE note_satisfaction ADD CONSTRAINT cours_note_satisfaction FOREIGN KEY cours_note_satisfaction (cours_num_cours)
    REFERENCES cours (num_cours);

-- Reference: cours_session (table: cours)
ALTER TABLE cours ADD CONSTRAINT cours_session FOREIGN KEY cours_session (session_num_session)
    REFERENCES session (num_session);

-- Reference: creation_cours (table: creation)
ALTER TABLE creation ADD CONSTRAINT creation_cours FOREIGN KEY creation_cours (cours_num_cours)
    REFERENCES cours (num_cours);

-- Reference: examen_parties (table: examen)
ALTER TABLE examen ADD CONSTRAINT examen_parties FOREIGN KEY examen_parties (parties_num_part)
    REFERENCES parties (num_part);

-- Reference: paiements_cours (table: paiement)
ALTER TABLE paiement ADD CONSTRAINT paiements_cours FOREIGN KEY paiements_cours (cours_num_cours)
    REFERENCES cours (num_cours);

-- Reference: parties_chapitres (table: parties)
ALTER TABLE parties ADD CONSTRAINT parties_chapitres FOREIGN KEY parties_chapitres (chapitres_num_chap)
    REFERENCES chapitres (num_chap);

-- Reference: progression_parties (table: progression)
ALTER TABLE progression ADD CONSTRAINT progression_parties FOREIGN KEY progression_parties (parties_num_part)
    REFERENCES parties (num_part);

-- Reference: progression_utilisateur (table: progression)
ALTER TABLE progression ADD CONSTRAINT progression_utilisateur FOREIGN KEY progression_utilisateur (utilisateur_num_ut)
    REFERENCES utilisateur (num_ut);

-- Reference: tentative_examen (table: tentative)
ALTER TABLE tentative ADD CONSTRAINT tentative_examen FOREIGN KEY tentative_examen (examen_num_exam)
    REFERENCES examen (num_exam);

-- Reference: tentative_utilisateur (table: tentative)
ALTER TABLE tentative ADD CONSTRAINT tentative_utilisateur FOREIGN KEY tentative_utilisateur (utilisateur_num_ut)
    REFERENCES utilisateur (num_ut);

-- Reference: utilisateur_creation (table: creation)
ALTER TABLE creation ADD CONSTRAINT utilisateur_creation FOREIGN KEY utilisateur_creation (utilisateur_num_ut)
    REFERENCES utilisateur (num_ut);

-- Reference: utilisateur_inscription (table: inscription)
ALTER TABLE inscription ADD CONSTRAINT utilisateur_inscription FOREIGN KEY utilisateur_inscription (utilisateur_num_ut)
    REFERENCES utilisateur (num_ut);

-- Reference: utilisateur_note_satisfaction (table: note_satisfaction)
ALTER TABLE note_satisfaction ADD CONSTRAINT utilisateur_note_satisfaction FOREIGN KEY utilisateur_note_satisfaction (utilisateur_num_ut)
    REFERENCES utilisateur (num_ut);

-- Reference: utilisateur_paiements (table: paiement)
ALTER TABLE paiement ADD CONSTRAINT utilisateur_paiements FOREIGN KEY utilisateur_paiements (utilisateur_num_ut)
    REFERENCES utilisateur (num_ut);

-- Reference: utilisateur_role_role (table: utilisateur_role)
ALTER TABLE utilisateur_role ADD CONSTRAINT utilisateur_role_role FOREIGN KEY utilisateur_role_role (role_id_role)
    REFERENCES role (id_role);

-- Reference: utilisateur_role_utilisateur (table: utilisateur_role)
ALTER TABLE utilisateur_role ADD CONSTRAINT utilisateur_role_utilisateur FOREIGN KEY utilisateur_role_utilisateur (utilisateur_num_ut)
    REFERENCES utilisateur (num_ut);

-- Reference: utilisateur_session (table: utilisateur)
ALTER TABLE utilisateur ADD CONSTRAINT utilisateur_session FOREIGN KEY utilisateur_session (session_num_session)
    REFERENCES session (num_session);

ALTER TABLE mooc_ayla_anthony.cours MODIFY COLUMN session_num_session int(11) NULL COMMENT 'Numéro identifiant de la session de cours.';
ALTER TABLE mooc_ayla_anthony.parties MODIFY COLUMN chapitres_num_chap int(11) NULL COMMENT 'Numéro identifiant un chapitre.';
ALTER TABLE mooc_ayla_anthony.utilisateur MODIFY COLUMN session_num_session int(11) NULL COMMENT 'Numéro identifiant de la session de cours.';

-- End of file.

