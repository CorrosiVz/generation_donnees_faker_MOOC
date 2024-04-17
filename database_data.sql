-- Il est important de respecter l'ordre d'insertion suivant pour l'insertion des données dans les tables :
-- 1. role
-- 2. session
-- 3. utilisateur
-- 4. utilisateur_role
-- 5. cours
-- 6. chapitres
-- 7. parties
-- 8. examen
-- 9. inscription
-- 10. paiement
-- 11. creation
-- 12. progression
-- 13. tentative
-- 14. note_satisfaction

-- Insertion de la table role
INSERT INTO mooc_ayla_anthony.`role` (nom_role,desc_role) VALUES
	 ('etudiant','Un étudiant suit des cours et passe des examens pour valider ses acquis. Il peut s''inscrire à des sessions de formation, et payer pour suivre des cours.'),
	 ('formateur','Un formateur dispense des cours et crée des examens pour évaluer les étudiants. Il peut suivre la progression des étudiants, et leur attribuer des notes.'),
	 ('createur','Un créateur de cours crée des cours et des parties de cours pour les étudiants. Il peut suivre la progression des étudiants, et créer des examens.'),
	 ('administrateur','Un administrateur gère les utilisateurs, les rôles, les cours, les sessions, les inscriptions, les paiements, les créations, les progressions, les tentatives, et les notes de satisfaction.'),
	 ('perso_admin','Un personnel administratif gère les utilisateurs, il s''assure que les inscriptions et les paiements sont traités correctement, et que les cours sont créés et suivis correctement.');

-- Insertion de la table session
INSERT INTO mooc_ayla_anthony.`session` (presentiel_session,dateDebut_session,dateFin_session,placeMax_session) VALUES
	 (0,'2023-06-22 19:46:11','2024-04-27 10:57:29',NULL),
	 (1,'2023-08-08 04:50:48','2024-09-17 19:05:56',NULL),
	 (0,'2024-01-23 20:32:30','2024-04-20 06:42:18',71),
	 (1,'2023-06-19 18:20:15','2024-05-27 10:48:11',1),
	 (1,'2023-04-22 10:11:08','2024-06-03 23:19:02',NULL),
	 (1,'2023-04-21 17:49:41','2024-08-18 02:30:36',NULL),
	 (0,'2023-05-11 05:43:01','2024-10-19 10:03:57',NULL),
	 (1,'2024-02-19 20:57:15','2025-01-06 00:52:01',19),
	 (1,'2023-05-05 20:34:58','2024-10-20 10:53:36',16),
	 (0,'2023-07-11 14:04:05','2024-10-02 05:32:43',NULL);

-- Insertion de la table utilisateur
INSERT INTO mooc_ayla_anthony.utilisateur (nom_ut,prenom_ut,mail_ut,session_num_session) VALUES
	 ('Berthelot','Mathilde','zpotier@example.net',1),
	 ('Delmas','Pauline','awagner@example.com',NULL),
	 ('Alves','Georges','simon.elise@example.org',NULL),
	 ('Legendre','Lorraine','emarion@example.net',NULL),
	 ('Vallee','Margaret','suzanne.rodrigues@example.org',8),
	 ('Marechal','Andrée','qcolas@example.net',NULL),
	 ('Evrard','Valentine','william.leclerc@example.org',8),
	 ('Gilbert','Marguerite','bertrand.daniel@example.org',5),
	 ('Pires','Christiane','lecomte.arnaude@example.net',6),
	 ('Besson','Michel','benjamin.andre@example.net',NULL);
INSERT INTO mooc_ayla_anthony.utilisateur (nom_ut,prenom_ut,mail_ut,session_num_session) VALUES
	 ('Meyer','Honoré','nguillon@example.com',7),
	 ('Legrand','Caroline','monique.lombard@example.net',9),
	 ('Bonnin','Jacqueline','francois.rossi@example.com',1),
	 ('Bruneau','Alex','emaury@example.com',NULL),
	 ('Samson','Maurice','xbourgeois@example.net',7),
	 ('Goncalves','Paul','fournier.augustin@example.org',2),
	 ('Launay','Jacqueline','dominique46@example.org',NULL),
	 ('Julien','Dominique','arthur16@example.org',NULL),
	 ('Guilbert','Andrée','thibault24@example.org',5),
	 ('Lagarde','Hugues','franck.parent@example.org',8);
INSERT INTO mooc_ayla_anthony.utilisateur (nom_ut,prenom_ut,mail_ut,session_num_session) VALUES
	 ('Blanchet','Jacques','chantal.vasseur@example.com',10),
	 ('Teixeira','Benjamin','ybriand@example.com',NULL),
	 ('Alves','Marc','theophile16@example.net',7),
	 ('Blanchard','Grégoire','alix78@example.com',NULL),
	 ('Rodriguez','Tristan','zlucas@example.net',NULL),
	 ('Joly','Juliette','coulon.nathalie@example.net',NULL),
	 ('Diallo','Aimé','martine.guilbert@example.com',8),
	 ('Legendre','Alice','tmartinez@example.net',2),
	 ('Olivier','Louis','frolland@example.net',2),
	 ('Mace','Suzanne','blanc.rene@example.org',NULL);
INSERT INTO mooc_ayla_anthony.utilisateur (nom_ut,prenom_ut,mail_ut,session_num_session) VALUES
	 ('Duhamel','Louis','guillou.marie@example.com',6),
	 ('Perret','Gérard','henri82@example.org',5),
	 ('Boucher','Patrick','hgirard@example.org',1),
	 ('Voisin','Alix','richard14@example.net',6),
	 ('Dos Santos','Laurent','frederic34@example.net',NULL);

-- Insertion de la table utilisateur_role
INSERT INTO mooc_ayla_anthony.utilisateur_role (utilisateur_num_ut,role_id_role) VALUES
	 (1,4),
	 (2,1),
	 (3,1),
	 (4,1),
	 (5,1),
	 (6,1),
	 (7,1),
	 (8,1),
	 (9,1),
	 (10,1);
INSERT INTO mooc_ayla_anthony.utilisateur_role (utilisateur_num_ut,role_id_role) VALUES
	 (11,1),
	 (12,1),
	 (13,1),
	 (14,1),
	 (15,1),
	 (16,1),
	 (17,1),
	 (18,1),
	 (19,1),
	 (20,1);
INSERT INTO mooc_ayla_anthony.utilisateur_role (utilisateur_num_ut,role_id_role) VALUES
	 (21,1),
	 (22,3),
	 (23,3),
	 (24,2),
	 (25,2),
	 (26,2),
	 (27,5),
	 (28,5),
	 (29,1),
	 (30,1);
INSERT INTO mooc_ayla_anthony.utilisateur_role (utilisateur_num_ut,role_id_role) VALUES
	 (31,1),
	 (32,1),
	 (33,2),
	 (34,2),
	 (35,1);

-- Insertion de la table cours
INSERT INTO mooc_ayla_anthony.cours (intitule_cours,desc_cours,prerequis_cours,prix_cours,dateDebut_cours,dateFin_cours,noteSatGlob_cours,session_num_session) VALUES
	 ('Écriture musicale','Cours d''harmonie, apprentissage des règles de composition musicale. Accords de 5tes Maj et Min, accords de 7tes de dominante et de sensible, cadences tonales et modulation.','Savoir lire la clé de Sol et de Fa, commencer à l''apprentissage de la clé d''Ut 3ème ligne',0,NULL,NULL,4.5,2),
	 ('Base de données','Les systèmes de gestion de base de données (SGBD), conception et modélisation de bases de données, langage SQL, requêtes, intégrité référentielle, transactions, procédures stockées, triggers, vues','Connaître les bases de l''algèbre relationnelle, et les formes de normalisation des bases de données',0,'2024-03-30 08:18:21','2024-09-23 07:57:54',5.0,NULL),
	 ('Badminton','Cours de badminton, apprentissage des règles du jeu, des techniques de frappe, des déplacements sur le terrain, des stratégies de jeu, des tactiques de match','Avoir sa propre raquette, des chaussures et une tenue de sport adaptées',20,NULL,NULL,4.8,NULL),
	 ('Naissance du médicament','Cours sur la naissance du médicament, découverte des molécules, des principes actifs, des excipients, des formes galéniques, des voies d''administration, des effets secondaires. Introduction à la pharmacologie, et à la pharmacovigilance','Aucun prérequis nécessaire',5,'2023-04-20 23:41:43','2024-09-24 16:20:42',3.2,NULL),
	 ('Civilisation italienne','Cours sur la civilisation italienne, histoire, géographie, culture, langue, littérature, arts, politique, économie, société, gastronomie, mode, cinéma, musique, architecture, design, sport, religion, traditions, fêtes, célébrités, tourisme','Niveau B1 en italien, ou avoir suivi le cours d''italien de niveau A2',0,'2024-03-17 08:29:14','2025-03-22 15:10:22',2.3,NULL),
	 ('Sociologie','Consequatur ea nam non voluptatibus itaque. Et reprehenderit fugit et et autem porro amet. Aut porro quaerat libero neque voluptas sunt ullam. Ea dignissimos et quia nam dolorem.','Iste perspiciatis vel voluptatem et quia perferendis.',28,'2023-05-05 11:46:23','2024-12-27 11:06:43',NULL,6),
	 ('Philosophie','Sequi sint eum et quaerat. Ea et et vel doloribus id vero. Quia beatae quia voluptatem culpa est maxime. Qui quae quo et excepturi delectus at.','Unde perspiciatis ut corporis qui earum ullam.',16,NULL,NULL,NULL,NULL),
	 ('Cinéma','Id sint minus quasi quis iusto. Fuga repudiandae sunt hic qui. Id in odit velit omnis sapiente enim. Consequatur magnam porro optio eos et illo.','Enim dolorem quidem autem velit.',60,NULL,NULL,NULL,1),
	 ('Programmation','Sit occaecati placeat magnam. Dolorum et magnam aliquam cumque explicabo aut. Excepturi quasi blanditiis illum aut.','Quod odit architecto et et.',28,NULL,NULL,NULL,NULL),
	 ('Escalade','Ut officiis fugiat magnam assumenda reprehenderit non. Et ad voluptas vel ducimus et quos. Dolorem quod id incidunt ut.','Temporibus animi repudiandae quidem quas.',49,'2024-02-08 04:58:04','2024-11-22 11:43:55',NULL,NULL);
INSERT INTO mooc_ayla_anthony.cours (intitule_cours,desc_cours,prerequis_cours,prix_cours,dateDebut_cours,dateFin_cours,noteSatGlob_cours,session_num_session) VALUES
	 ('Russe','Facilis et quasi sequi ducimus. Quam fugit voluptas est in. Possimus voluptatem quibusdam ab corporis facilis similique id. Accusamus possimus in in nam dolore culpa quod non.','Hic aut qui occaecati quos reiciendis.',26,NULL,NULL,NULL,NULL),
	 ('Natation','Dolores fugit totam hic iusto voluptatem. Iure commodi quod quo culpa et. Quibusdam ut distinctio similique architecto.','Sed dolorem mollitia et repellat cumque corporis.',41,'2023-08-22 02:15:42','2025-01-05 16:19:54',3.32,9),
	 ('Interactions homme-machine','Sit sunt non voluptatibus vel alias. Expedita alias eius molestiae et enim tenetur. Explicabo voluptas sit illo accusamus veritatis mollitia distinctio. Ut praesentium sunt nostrum minima animi et aut.','Sunt deleniti delectus vel vitae id quae totam.',90,'2023-08-14 07:31:47','2024-10-05 15:14:36',NULL,1),
	 ('Développement d''applications mobiles','Vero voluptatem omnis nulla ex neque ipsam fugit. Ducimus nesciunt sed tempore eius et autem.','Vitae voluptas minima vitae sed eligendi est in ex.',69,NULL,NULL,4.64,NULL),
	 ('Physiologie','Atque perspiciatis quis sit quod eum ut doloremque. Error est et quia maxime alias esse.','Ut repellendus illo quis facere blanditiis.',82,'2023-05-03 17:48:23','2025-02-20 09:27:19',0.8,NULL),
	 ('Introduction à la programmation web','Aut doloremque libero in numquam ipsum. Enim dignissimos repellat molestiae reprehenderit placeat commodi qui est. Facilis sed similique distinctio necessitatibus voluptas vel labore.','Dolorem molestiae enim et et possimus.',95,NULL,NULL,NULL,NULL),
	 ('Langue des signes','Iusto perspiciatis dolorem eum sit numquam vel id. Autem minus alias voluptas ullam. Aut harum commodi voluptas et est velit.','Quia aperiam vero perferendis reprehenderit accusamus.',28,'2023-06-27 16:06:14','2025-03-16 11:09:12',3.76,NULL),
	 ('Archéométrie','Laudantium earum praesentium at culpa magnam accusantium. Et cum aliquid ea omnis quasi hic. Dolorem quam laborum aut mollitia hic ullam. Vel praesentium fugiat labore vero quasi.','Quis praesentium ex fugit numquam voluptatibus et sint voluptas.',17,NULL,NULL,1.39,NULL),
	 ('Histoire de la musique de la Renaissance','Aliquid voluptatem et provident nesciunt non. Sint placeat ea ut iure impedit quo. Eum assumenda et eum explicabo porro expedita.','Ex dolores est eum et molestiae facilis dolor.',15,'2023-05-29 23:22:16','2024-05-12 07:39:15',0.07,NULL),
	 ('La recherche comme éclairage sur la posture professionnelle','Eius quia architecto adipisci mollitia officia. Fuga at omnis iste dolor. Et delectus voluptatem sunt libero placeat repellat. Reprehenderit reiciendis dolores cum ratione id accusantium dolor.','Eligendi repellat harum repellat laudantium aut vero doloremque.',20,NULL,NULL,NULL,9);

-- Insertion de la table chapitres
INSERT INTO mooc_ayla_anthony.chapitres (titre_chap,cours_num_cours) VALUES
	 ('Accords de 3 sons Majeurs et Mineurs',1),
	 ('Accords de 4 sons : 7ème de dominante',1),
	 ('Accords de 4 sons : 7ème de sensible',1),
	 ('Conclusions',7),
	 ('Cas pratiques',2),
	 ('Principes fondamentaux',15),
	 ('Synthèse',4),
	 ('Synthèse',6),
	 ('Glossaire',14),
	 ('Exercices',5);
INSERT INTO mooc_ayla_anthony.chapitres (titre_chap,cours_num_cours) VALUES
	 ('Études de cas',6),
	 ('Méthodologie',9),
	 ('Webographie',8);

-- Insertion de la table parties
INSERT INTO mooc_ayla_anthony.parties (titre_part,contenu_part,chapitres_num_chap) VALUES
	 ('La tierce Majeure et la tierce mineure','Est quibusdam hic illo non. Doloribus sit et necessitatibus delectus. Quam a est tenetur dolor atque molestias. Et temporibus cumque sunt alias nostrum architecto.',1),
	 ('La quinte juste','Ad ea quis ut voluptatem recusandae. Sunt omnis consequatur excepturi est tenetur totam dolor. Placeat eos et dolor et vero dolores. Nihil minus non sit consequatur.',1),
	 ('La 7ème de dominante','Rerum aliquid autem non a aperiam consequuntur. In rem veniam dolorem culpa. Velit aut reprehenderit nemo illo ad. Ex ex voluptates perferendis expedita.',2),
	 ('Modulation en utilisant la 7ème de dominante','Ut saepe et dignissimos dicta in non vel. Aperiam et similique omnis adipisci quia temporibus laborum. Debitis animi facilis eum cum. Animi ipsa soluta qui aut. Quidem ad nihil consequatur molestiae voluptatem.',2),
	 ('La 7ème de sensible et la 5te diminuée','Recusandae repellendus ut tenetur nobis et unde fugit. Cumque sit assumenda iure animi aspernatur. Debitis laboriosam ullam nulla et.',3),
	 ('Les 3 accords de sensibles','Doloribus velit aut omnis beatae voluptates. Quo eaque omnis nam quis et voluptas est. Et est provident laudantium in omnis illum.',3),
	 ('Partie 3','Repellat nemo dicta ratione et esse sit tenetur. Et est consequatur quas ratione. Sapiente iusto quam commodi unde qui aut. Nobis adipisci odio consequatur tempore est numquam aut.',NULL),
	 ('Partie 6','Ducimus quia adipisci illo. Dolor ipsum dignissimos eum adipisci ea animi. Fuga beatae voluptatum error pariatur enim.',4),
	 ('Partie V','Possimus quia quo molestiae beatae pariatur sunt. Et fuga adipisci cum natus eum nihil aliquid nulla. Aspernatur itaque sed et. Nesciunt illo quisquam accusamus labore ad.',NULL),
	 ('Partie IX','Doloremque voluptatum dolorem qui. Qui in adipisci in qui. Eum dolor dolorem mollitia ullam. Amet perspiciatis accusamus aut reprehenderit ut suscipit harum ut.',NULL);
INSERT INTO mooc_ayla_anthony.parties (titre_part,contenu_part,chapitres_num_chap) VALUES
	 ('Partie I','Dolorem doloremque voluptatem qui cumque sint. Vel praesentium non sit velit amet. Ipsa occaecati qui rerum et optio dolor. Nemo sapiente rerum quos.',NULL),
	 ('Partie 1','Corporis impedit sunt quis et. Deserunt sed doloribus tempore quisquam rerum. Fugiat vel dolor dolores sed vero. Eligendi iste ipsa aut labore voluptatem.',NULL),
	 ('Exercices','Fugiat rerum totam atque. Nisi et qui voluptatem vel repudiandae excepturi odit voluptatem. Officiis exercitationem fuga sed veritatis. Doloribus doloremque aut saepe est doloribus adipisci ipsa alias.',NULL),
	 ('Partie 7','Est assumenda et perspiciatis sit id qui voluptatem. Libero itaque praesentium omnis recusandae. Vero sit sed nam ratione cupiditate ut aut. Vel molestias voluptatibus aut architecto natus.',NULL),
	 ('Partie VIII','Temporibus dolore ipsum fuga. Omnis sed omnis aut qui quo. Expedita earum doloremque vel aut dolor. Qui molestiae error vitae laudantium ut porro.',7),
	 ('Bibliographie','Maxime nostrum error expedita illum. Rerum eligendi culpa tempora. Enim eos nihil eligendi minima. Qui aut molestias ipsam autem.',NULL),
	 ('Bibliographie','Atque id dicta consequatur debitis et. Sint ipsa cumque ut. Quis est eius voluptates atque ratione. Reiciendis quae molestiae corrupti autem.',10),
	 ('Partie II','Non voluptas quibusdam distinctio recusandae. Aut rem praesentium similique earum inventore nesciunt repellendus. Sed est eligendi ipsa pariatur qui.',7),
	 ('Partie X','Minus dolores dolorem et soluta rem repellendus. Ipsum quae qui ipsa reprehenderit ut. Nisi et et omnis magni alias quia suscipit.',NULL),
	 ('Partie VI','Nihil exercitationem et sit reiciendis sed provident rerum. Eligendi provident est expedita. Sit minima harum quibusdam velit.',NULL);
INSERT INTO mooc_ayla_anthony.parties (titre_part,contenu_part,chapitres_num_chap) VALUES
	 ('Applications','Nulla quibusdam odio sunt quas harum et. Repellat suscipit quia voluptatem quis est et omnis pariatur. Consectetur aut tempora numquam.',11),
	 ('Définitions','Quod alias nobis aut est numquam quia. Ratione aut aut aliquam qui quis eius nostrum quaerat. Soluta sed nulla eum at et nesciunt qui modi. Veniam optio dolores fugiat et voluptas numquam quis.',NULL),
	 ('Partie IV','Vitae ut qui maiores. Est excepturi sed tempora nemo. Est recusandae sint quas cum quia et.',NULL);

-- Insertion de la table examen
INSERT INTO mooc_ayla_anthony.examen (titre_exam,contenu_exam,scoreMin_exam,parties_num_part) VALUES
	 ('Examen de travaux de stage','Qui odit consequatur id aut non perferendis nihil. Tenetur mollitia sed cupiditate architecto. Quia harum quia et facilis accusantium molestiae sed. Harum quod nostrum illo ea numquam consequatur. Nulla ipsum et autem aut.',70,1),
	 ('Examen final','Quo ipsum occaecati nulla velit iusto. Sunt illo minus qui. Iusto voluptatem vel similique vel delectus exercitationem consequatur suscipit.',67,2),
	 ('Examen de passage','Rerum quo voluptatem assumenda consequatur. Aut error ducimus enim ducimus aut commodi sed aut. Officia alias dolorem fuga ad eos esse quos. Voluptatem est placeat et ut.',71,3),
	 ('Examen de théorie','Eligendi nihil delectus aliquam quia saepe. Ut adipisci dolorem consequatur omnis. Nihil quisquam in sed. Quidem laboriosam et doloribus magni. Facere distinctio rerum corporis assumenda pariatur.',60,4),
	 ('Examen de validation','Eum minima maxime blanditiis sunt nulla. Ad velit et eaque aut vitae id tenetur beatae. Debitis cum voluptatem quia tempora qui. Enim officiis est rerum odit.',79,5),
	 ('Examen de connaissances','Perspiciatis nihil quia vitae quia aut. Aut velit necessitatibus laborum et voluptatibus omnis nulla doloremque. Aperiam aut amet minus ut eum repellendus. Temporibus maxime a consequatur eius non recusandae.',94,6),
	 ('Examen de travaux de recherche','In ut minima maxime omnis voluptatem sed commodi. Non consectetur quia dolor deserunt dolorum autem nemo. Quia sit harum perferendis ex possimus qui. Maiores velit officia nisi eveniet quisquam voluptatem.',74,9),
	 ('Examen de passage','Perspiciatis officia eaque ducimus animi est quam quaerat. Odio inventore mollitia fugit molestiae. Id aliquid recusandae est ea.',53,14),
	 ('Examen de travaux de groupe','Sequi ullam dignissimos modi a enim ipsam. Reprehenderit ut quo voluptatem incidunt possimus. Fuga mollitia in molestias aspernatur.',64,10),
	 ('Examen blanc','Facilis voluptatem non quia aut qui. Molestiae ut iusto aut neque ex. Dolor veritatis sed fugiat et dolorem dicta voluptatem.',71,18);
INSERT INTO mooc_ayla_anthony.examen (titre_exam,contenu_exam,scoreMin_exam,parties_num_part) VALUES
	 ('Examen de travaux de recherche','Omnis iste quo accusamus dolor deleniti aut. Earum officiis illum deserunt at. Qui incidunt laboriosam voluptatem sit necessitatibus. Voluptatem facilis laborum sit architecto eos voluptates.',81,15),
	 ('Examen de travaux de fin de formation','Vel non sit voluptates reiciendis sit dicta voluptas dolores. Et fugiat nemo nihil nihil aliquam unde et ullam. Et adipisci illo qui enim est. Omnis reiciendis vero molestias soluta nesciunt atque.',58,8),
	 ('Examen de travaux de mémoire','Fuga facilis magni voluptatem ipsam impedit. Perspiciatis sit sed error dolores qui impedit. Officia aliquam ullam maxime est provident earum.',57,8),
	 ('Examen de contrôle continu','Voluptatem sed voluptates sunt repudiandae et non. Voluptatem quam fuga rerum ea. Qui nobis mollitia mollitia totam rerum. Et sit nobis qui aut exercitationem cumque placeat.',50,20),
	 ('Examen de travaux pratiques','Occaecati a ea officiis. Maxime est atque delectus similique ab ut quia. Aut ipsa nisi laudantium magni quos minus.',55,15),
	 ('Examen de validation','Modi quo ducimus voluptate et. Omnis modi et non recusandae nobis vel reprehenderit. Error iusto impedit corrupti repellat excepturi ea.',85,21);

-- Insertion de la table inscription
INSERT INTO mooc_ayla_anthony.inscription (date_in,utilisateur_num_ut,cours_num_cours) VALUES
	 ('2024-04-13 16:27:16',2,2),
	 ('2024-02-03 12:03:23',2,3),
	 ('2024-03-17 01:55:29',2,4),
	 ('2024-01-17 09:43:01',2,5),
	 ('2024-01-06 17:20:30',2,7),
	 ('2024-02-16 08:02:14',2,9),
	 ('2024-02-22 02:18:47',2,10),
	 ('2024-02-15 18:34:12',2,11),
	 ('2024-03-09 03:30:17',2,14),
	 ('2024-02-02 13:31:45',2,15);
INSERT INTO mooc_ayla_anthony.inscription (date_in,utilisateur_num_ut,cours_num_cours) VALUES
	 ('2024-02-07 22:03:58',2,16),
	 ('2024-01-09 08:08:13',2,17),
	 ('2024-04-03 21:23:11',2,18),
	 ('2024-02-02 17:03:01',2,19),
	 ('2024-01-20 09:46:36',2,8),
	 ('2024-02-26 12:03:58',2,13),
	 ('2024-01-27 09:38:37',2,1),
	 ('2024-04-09 06:43:16',2,6),
	 ('2024-01-14 16:32:23',2,12),
	 ('2024-03-23 17:08:36',2,20);
INSERT INTO mooc_ayla_anthony.inscription (date_in,utilisateur_num_ut,cours_num_cours) VALUES
	 ('2024-02-15 15:43:46',3,1),
	 ('2024-02-19 15:15:16',4,2),
	 ('2024-04-14 08:43:57',18,17),
	 ('2024-04-05 07:03:44',30,20),
	 ('2024-02-15 21:05:36',23,5),
	 ('2024-03-08 14:46:46',29,14),
	 ('2024-01-02 02:22:56',4,11),
	 ('2024-03-18 11:01:27',21,17),
	 ('2024-01-09 08:08:18',32,12),
	 ('2024-02-15 03:00:26',35,13);
INSERT INTO mooc_ayla_anthony.inscription (date_in,utilisateur_num_ut,cours_num_cours) VALUES
	 ('2024-01-18 01:50:46',24,7),
	 ('2024-01-10 21:55:26',6,19);

-- Insertion de la table paiement
INSERT INTO mooc_ayla_anthony.paiement (montant_paie,date_paie,statut_paie,cours_num_cours,utilisateur_num_ut) VALUES
	 (0,'2024-01-19 20:45:32','traité',1,2),
	 (0,'2024-03-17 07:48:42','traité',2,2),
	 (20,'2024-03-26 03:00:07','traité',3,2),
	 (5,'2024-02-06 20:24:19','traité',4,2),
	 (0,'2024-01-31 14:18:39','traité',5,2),
	 (28,'2024-01-07 21:54:18','traité',6,2),
	 (16,'2024-01-25 20:58:20','traité',7,2),
	 (60,'2024-02-21 23:52:45','traité',8,2),
	 (28,'2024-01-03 02:17:33','traité',9,2),
	 (49,'2024-02-12 15:26:26','traité',10,2);
INSERT INTO mooc_ayla_anthony.paiement (montant_paie,date_paie,statut_paie,cours_num_cours,utilisateur_num_ut) VALUES
	 (26,'2024-02-02 09:27:24','traité',11,2),
	 (41,'2024-01-02 21:31:22','traité',12,2),
	 (90,'2024-03-20 09:59:24','traité',13,2),
	 (69,'2024-02-02 16:01:51','traité',14,2),
	 (82,'2024-01-24 11:42:27','traité',15,2),
	 (95,'2024-01-16 09:15:57','traité',16,2),
	 (28,'2024-02-28 10:01:51','traité',17,2),
	 (17,'2024-03-08 07:20:47','traité',18,2),
	 (15,'2024-01-09 12:05:25','traité',19,2),
	 (20,'2024-04-07 17:39:17','traité',20,2);
INSERT INTO mooc_ayla_anthony.paiement (montant_paie,date_paie,statut_paie,cours_num_cours,utilisateur_num_ut) VALUES
	 (0,'2024-01-18 16:20:21','traité',1,3),
	 (0,'2024-03-31 18:11:09','traité',2,4),
	 (97,'2024-02-14 11:14:08','traité',2,14),
	 (71,'2024-03-13 07:47:53','echec',17,13),
	 (72,'2024-04-09 17:39:04','en cours',11,12),
	 (18,'2024-03-25 06:04:27','en cours',4,6),
	 (80,'2024-03-18 03:50:58','traité',2,32),
	 (66,'2024-02-22 00:36:52','traité',12,26),
	 (53,'2024-03-10 21:39:34','traité',3,22),
	 (8,'2024-04-01 05:17:11','echec',13,35);
INSERT INTO mooc_ayla_anthony.paiement (montant_paie,date_paie,statut_paie,cours_num_cours,utilisateur_num_ut) VALUES
	 (17,'2024-03-03 19:23:45','traité',6,26),
	 (54,'2024-03-30 21:09:48','echec',20,20);

-- Insertion de la table creation
INSERT INTO mooc_ayla_anthony.creation (date_crea,detailsModif_crea,cours_num_cours,utilisateur_num_ut) VALUES
	 ('2024-02-27 05:06:22','Reiciendis quo iste minima.',13,22),
	 ('2024-03-04 19:11:31','Et nam qui ipsa.',8,34),
	 ('2024-02-05 10:44:21','At vel consequatur repudiandae natus.',13,33),
	 ('2024-03-10 23:30:13','Veniam ut iure culpa incidunt architecto.',7,33),
	 ('2024-02-12 15:34:30','Enim veniam dolores assumenda perspiciatis voluptatum qui qui.',7,23),
	 ('2024-03-30 07:38:33','Ipsa nobis ex at.',1,24),
	 ('2024-04-06 06:53:16','Vel voluptatibus cum omnis minima quaerat commodi.',16,25),
	 ('2024-03-09 01:34:37','Quo repudiandae modi excepturi.',15,25),
	 ('2024-01-06 22:26:47','Et sed officiis ex eius.',2,23),
	 ('2024-03-01 06:57:30','Quia nulla perspiciatis fugit vitae voluptate.',19,26);
INSERT INTO mooc_ayla_anthony.creation (date_crea,detailsModif_crea,cours_num_cours,utilisateur_num_ut) VALUES
	 ('2024-01-09 15:53:16','Error ullam nemo aliquid et quia adipisci nihil.',2,23),
	 ('2024-01-09 12:51:15','Explicabo quos quod a.',13,24),
	 ('2024-04-12 08:37:50','Voluptas nobis consequatur quaerat numquam.',16,22),
	 ('2024-01-30 11:26:30','Provident animi rerum ea aspernatur impedit sit.',20,24),
	 ('2024-01-12 13:22:35','Atque possimus sed alias consequatur quis quisquam.',11,23),
	 ('2024-03-11 14:32:39','Asperiores non officia eum et velit.',1,24),
	 ('2024-03-24 13:07:06','Rerum maxime quisquam enim quam omnis qui.',8,24),
	 ('2024-02-12 14:43:20','Similique vel minima minus.',3,25),
	 ('2024-03-27 00:10:25','Accusamus nihil ex ducimus id.',2,33),
	 ('2024-03-07 07:37:07','Corporis sint quia rerum odit ea totam in.',6,26);

-- Insertion de la table progression
INSERT INTO mooc_ayla_anthony.progression (partieFinie_prog,date_prog,utilisateur_num_ut,parties_num_part) VALUES
	 (1,'2024-03-15 15:33:21',3,1),
	 (1,'2024-01-15 15:20:17',3,2),
	 (1,'2024-02-24 09:44:19',3,3),
	 (1,'2024-01-27 15:55:02',3,4),
	 (1,'2024-03-27 15:56:54',3,5),
	 (1,'2024-02-27 13:57:40',3,6),
	 (0,'2024-02-03 01:48:32',33,21),
	 (0,'2024-03-10 20:57:34',31,4),
	 (1,'2024-02-21 21:56:58',26,7),
	 (0,'2024-03-18 14:41:30',35,16);
INSERT INTO mooc_ayla_anthony.progression (partieFinie_prog,date_prog,utilisateur_num_ut,parties_num_part) VALUES
	 (1,'2024-04-10 01:57:52',31,13),
	 (1,'2024-02-10 09:07:37',35,9),
	 (1,'2024-03-03 19:32:11',28,21),
	 (1,'2024-01-12 19:22:09',32,23),
	 (0,'2024-01-22 09:22:42',25,3);

-- Insertion de la table tentative
INSERT INTO mooc_ayla_anthony.tentative (scoreObt_tent,date_tent,utilisateur_num_ut,examen_num_exam) VALUES
	 (70,'2024-04-02 21:04:51',3,1),
	 (69,'2024-03-11 01:00:48',3,2),
	 (86,'2024-03-06 03:51:20',3,3),
	 (90,'2024-01-15 09:54:17',3,4),
	 (100,'2024-03-19 02:33:03',3,5),
	 (99,'2024-01-10 15:26:23',3,6),
	 (40,'2024-03-07 23:26:33',29,9),
	 (59,'2024-03-20 06:30:12',8,15),
	 (49,'2024-03-03 11:12:05',10,8),
	 (23,'2024-02-16 14:36:29',18,12);
INSERT INTO mooc_ayla_anthony.tentative (scoreObt_tent,date_tent,utilisateur_num_ut,examen_num_exam) VALUES
	 (50,'2024-01-24 01:09:21',21,15),
	 (30,'2024-04-12 20:28:35',22,9),
	 (96,'2024-04-13 09:16:59',16,14),
	 (79,'2024-04-06 23:35:23',7,7),
	 (71,'2024-02-17 16:59:38',34,6),
	 (49,'2024-02-18 00:59:38',25,14),
	 (45,'2024-03-22 16:19:13',20,10),
	 (45,'2024-01-26 06:43:23',33,13),
	 (78,'2024-01-08 12:12:02',10,10),
	 (59,'2024-01-07 18:35:38',6,3);
INSERT INTO mooc_ayla_anthony.tentative (scoreObt_tent,date_tent,utilisateur_num_ut,examen_num_exam) VALUES
	 (2,'2024-01-13 23:33:24',22,13);

-- Insertion de la table note_satisfaction
INSERT INTO mooc_ayla_anthony.note_satisfaction (utilisateur_num_ut,cours_num_cours,noteSat,commentaire) VALUES
	 (4,2,5,'Le prof est très beau'),
	 (16,14,5,'Formateur très pédagogue'),
	 (18,4,3,'Cours difficile'),
	 (30,15,2,'Cours trop chargé'),
	 (1,4,1,'Je n''ai pas aimé'),
	 (35,3,4,'Je suis fan'),
	 (2,11,5,'Merci beaucoup pour ce cours'),
	 (28,4,4,'Cours très enrichissant'),
	 (4,4,2,'Cours difficile'),
	 (29,2,4,'Je recommande');
INSERT INTO mooc_ayla_anthony.note_satisfaction (utilisateur_num_ut,cours_num_cours,noteSat,commentaire) VALUES
	 (27,11,1,'Cours difficile');


