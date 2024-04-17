<?php
require_once 'vendor/autoload.php';

$user = 'root';
$password = '';
$dbname = 'mooc_ayla_anthony';
$driver = 'mysql';

try {
    $conn = new PDO($driver . ':host=localhost;dbname=' . $dbname, $user, $password);
} catch (PDOException $e) {
    die("Connection failed: " . $e->getMessage());
}

$faker = Faker\Factory::create('fr_FR');

// Fonction pour inserer des données (Merci Yu CHEN) :
function insertFakeData($conn, $tableName, $data)
{
    $columns = implode(", ", array_keys($data));
    $params = implode(", ", array_map(function ($param) {
        return ":$param";
    }, array_keys($data)));

    $stmt = $conn->prepare("INSERT INTO $tableName ($columns) VALUES ($params)");

    foreach ($data as $key => &$value) {
        $stmt->bindParam(":$key", $value);
    }

    $stmt->execute();
}

// Fonction de suppression des données (avant de les insérer) :
function clearTable($conn, $tableName) {
    $query = $conn->query("SELECT COUNT(*) FROM $tableName");
    $count = $query->fetchColumn();

    if ($count > 0) {
        $conn->exec("DELETE FROM $tableName");
        $conn->exec("ALTER TABLE $tableName AUTO_INCREMENT = 1");
    }
}

function clearTableNoIncrement($conn, $tableName) {
    $query = $conn->query("SELECT COUNT(*) FROM $tableName");
    $count = $query->fetchColumn();

    if ($count > 0) {
        $conn->exec("DELETE FROM $tableName");
    }
}

/**
 * Ordre de génération puis d'insertion des données aléatoires :
 * 1. role
 * 2. session
 * 3. utilisateur
 * 4. utilisateur_role
 * 5. cours
 * 6. chapitres
 * 7. parties
 * 8. examen
 * 9. inscription
 * 10. paiement
 * 11. creation
 * 12. progression
 * 13. tentative
 * 14. note_satisfaction
 */

// ############################################ ROLE ######################################################
// Génération et insertion des données aléatoires pour la table role
$roles = [
    'etudiant' => 'Un étudiant suit des cours et passe des examens pour valider ses acquis. Il peut s\'inscrire à des sessions de formation, et payer pour suivre des cours.',
    'formateur' => 'Un formateur dispense des cours et crée des examens pour évaluer les étudiants. Il peut suivre la progression des étudiants, et leur attribuer des notes.',
    'createur' => 'Un créateur de cours crée des cours et des parties de cours pour les étudiants. Il peut suivre la progression des étudiants, et créer des examens.',
    'administrateur' => 'Un administrateur gère les utilisateurs, les rôles, les cours, les sessions, les inscriptions, les paiements, les créations, les progressions, les tentatives, et les notes de satisfaction.',
    'perso_admin' => 'Un personnel administratif gère les utilisateurs, il s\'assure que les inscriptions et les paiements sont traités correctement, et que les cours sont créés et suivis correctement.'
]; // Les roles avec leur description

$roleIds = [];

clearTableNoIncrement($conn, 'utilisateur_role');
clearTable($conn, 'role');

foreach ($roles as $role => $description) {
    insertFakeData($conn, 'ROLE', [
        'nom_role' => $role,
        'desc_role' => $description
    ]);
}

echo "ROLE inserted successfully" . "\n";

// ############################################ SESSION ######################################################
// Génération et insertion des données aléatoires pour la table session
clearTable($conn, 'note_satisfaction');
clearTable($conn, 'tentative');
clearTable($conn, 'progression');
clearTable($conn, 'creation');
clearTable($conn, 'paiement');
clearTable($conn, 'inscription');
// Suppression des examens avant de supprimer les parties
clearTable($conn, 'examen');
// Suppression des parties avant de supprimer les chapitres
clearTable($conn, 'parties');
// On vérifie si la table chapitres a des données avant de supprimer cours
clearTable($conn, 'chapitres');
// Vérification de la présence de données dans la table cours
clearTable($conn, 'cours');
// Vérification de la présence de données dans la table utilisateur
clearTable($conn, 'utilisateur');
// Vérification de la présence de données dans la table session
clearTable($conn, 'session');

// Nombre de sessions à générer :
$sessionCount = 10;

for ($i = 0; $i < $sessionCount; $i++) {
    $presentiel_session = $faker->boolean;
    $dateDebut_session = $faker->dateTimeBetween('-1 years', 'now')->format('Y-m-d H:i:s');
    $dateFin_session = $faker->dateTimeBetween('now', '+1 years')->format('Y-m-d H:i:s');
    $placeMax_session = $faker->optional()->numberBetween(1, 100);

    insertFakeData($conn, 'session', [
        'presentiel_session' => $presentiel_session,
        'dateDebut_session' => $dateDebut_session,
        'dateFin_session' => $dateFin_session,
        'placeMax_session' => $placeMax_session
    ]);
}

echo "SESSION inserted successfully" . "\n";

// ############################################ UTILISATEUR ######################################################
// Génération et insertion des données aléatoires pour la table utilisateur :
clearTable($conn, 'note_satisfaction');
clearTable($conn, 'tentative');
clearTable($conn, 'progression');
clearTable($conn, 'creation');
clearTable($conn, 'paiement');
clearTable($conn, 'inscription');
clearTable($conn, 'utilisateur');

// Récupération des sessions pour les assigner aux utilisateurs qui s'y inscriront
$query = $conn->query("SELECT COUNT(*) FROM session");
$sessionCount = $query->fetchColumn();

$utilisateurCount = 35;

for ($i = 0; $i < $utilisateurCount; $i++) {
    $nom_ut = $faker->lastName;
    $prenom_ut = $faker->firstName;
    $mail_ut = $faker->unique()->safeEmail;
    $session_num_session = $faker->optional()->numberBetween(1, $sessionCount);

    insertFakeData($conn, 'utilisateur', [
        'nom_ut' => $nom_ut,
        'prenom_ut' => $prenom_ut,
        'mail_ut' => $mail_ut,
        'session_num_session' => $session_num_session
    ]);
}

echo "UTILISATEUR inserted successfully" . "\n";

// ############################################ UTILISATEUR_ROLE ######################################################
// Génération et insertion des données aléatoires pour la table utilisateur_role

// Vérification de la présence de données dans la table utilisateur_role
clearTableNoIncrement($conn, 'utilisateur_role');

// Récupération des utilisateurs pour les assigner à des rôles
$query = $conn->query("SELECT COUNT(*) FROM utilisateur");
$userCount = $query->fetchColumn();

$roleDistribution = [
    'etudiant' => 0.7,
    'formateur' => 0.2,
    'createur' => 0.05,
    'administrateur' => 0.025,
    'perso_admin' => 0.025
];

$query = $conn->query("SELECT nom_role, id_role FROM role");
$roles = $query->fetchAll(PDO::FETCH_KEY_PAIR);

// Generate a list of roles based on the desired distribution
$roleList = [];
foreach ($roleDistribution as $role => $probability) {
    $count = round($probability * $userCount);
    $roleList = array_merge($roleList, array_fill(0, $count, $roles[$role]));
}

// Shuffle the list to ensure randomness
shuffle($roleList);

/*************** S'assurer qu'il y est assez d'utilisateurs avant de distribuer les roles **************/

// Insertion d'au moins un administrateur
insertFakeData($conn, 'utilisateur_role', [
    'utilisateur_num_ut' => 1,
    'role_id_role' => $roles['administrateur']
]);

// Insertion d'au moins 20 étudiants
for ($i = 2; $i <= 21; $i++) {
    insertFakeData($conn, 'utilisateur_role', [
        'utilisateur_num_ut' => $i,
        'role_id_role' => $roles['etudiant']
    ]);
}

// Insertion d'au moins 2 créateurs de cours
for ($i = 22; $i <= 23; $i++) {
    insertFakeData($conn, 'utilisateur_role', [
        'utilisateur_num_ut' => $i,
        'role_id_role' => $roles['createur']
    ]);
}

// Insertion d'au moins 3 formateurs
for ($i = 24; $i <= 26; $i++) {
    insertFakeData($conn, 'utilisateur_role', [
        'utilisateur_num_ut' => $i,
        'role_id_role' => $roles['formateur']
    ]);
}

// Insertion d'au moins 2 personnes administratives
for ($i = 27; $i <= 28; $i++) {
    insertFakeData($conn, 'utilisateur_role', [
        'utilisateur_num_ut' => $i,
        'role_id_role' => $roles['perso_admin']
    ]);
}

// Assign roles to users
for ($i = 29; $i <= $userCount; $i++) {
    $roleId = array_pop($roleList);

    insertFakeData($conn, 'utilisateur_role', [
        'utilisateur_num_ut' => $i,
        'role_id_role' => $roleId
    ]);
}

echo "UTILISATEUR_ROLE inserted successfully" . "\n";

// ############################################ COURS ######################################################
clearTable($conn, 'note_satisfaction');
clearTable($conn, 'tentative');
clearTable($conn, 'progression');
clearTable($conn, 'creation');
clearTable($conn, 'paiement');
clearTable($conn, 'inscription');
// Suppression des examens avant de supprimer les parties
clearTable($conn, 'examen');
// Suppression des parties avant de supprimer les chapitres
clearTable($conn, 'parties');
// On supprime les chapitres avant de supprimer les cours
clearTable($conn, 'chapitres');
clearTable($conn, 'cours');

// Intitulés de cours possibles :
$courseTitles = [
    'Introduction à la programmation web', 'Développement d\'applications mobiles', 'Cybersécurité',
    'Intelligence artificielle', 'Programmation', 'Réseaux informatiques', 'Systèmes d\'exploitation', 'Méthodes de génie logiciel',
    'Gestion de projet', 'Informatique décisionnelle', 'Algorithmique', 'Récherche d\'information', 'Interactions homme-machine',
    'Programmation web serveur', 'Programmation web client', 'Droit de l\'informatique', 'Mathématiques pour l\'informatique',
    'Anglais', 'Espagnol', 'Chinois', 'Japonais', 'Allemand', 'Italien', 'Russe', 'Portugais',
    'Histoire de l\'art', 'Philosophie', 'Littérature', 'Théâtre', 'Cinéma', 'Phonétique', 'Traduction', 'Civilisation', 'Langue des signes',
    'Histoire de la musique du Moyen-Âge', 'Histoire de la musique de la Renaissance', 'Histoire de la musique classique',
    'Histoire de la musique baroque', 'Histoire de la musique romantique', 'Histoire de la musique française de 1870 à 1920', 'Histoire de la musique moderne',
    'Histoire de la musique du Jazz', 'Histoire de la musique contemporaine', 'Ludomusicologie', 'Ethnomusicologie',
    'Formation Musicale', 'Analyse musicale', 'Orchestration', 'Direction de choeur et d\'orchestre',
    'Accompagnement avec instrument harmonique', 'Acoustique', 'Musique Assistée par Ordinateur', 'Choeur', 'Création musicale', 'Introduction à la recherche',
    'Biochimie', 'Structure de la matière', 'Outils fondamentaux de mathématiques pour les sciences de la nature', 'Informatique appliquée aux sciences de la vie',
    'Biologie cellulaire', 'Chimie générale', 'Chimie organique', 'Thermodynamique', 'Biostatistiques', 'Physiologie', 'Génétique', 'Immunologie',
    'Psychologie', 'Sociologie', 'Sciences cognitives', 'La recherche comme éclairage sur la posture professionnelle', 'Épistémologie des sciences de l\'éducation',
    'Didactique', 'Neurosciences', 'Culture vocale', 'Processus d’apprentissage et accessibilité aux savoirs pour tous',
    'Mathématiques', 'Formation des étoiles et des planètes', 'Astrophysique', 'Mécanique quantique', 'Physique des particules',
    'Sport', 'Natation', 'Musculation', 'Yoga', 'Gymnastique', 'Danse', 'Arts martiaux', 'Boxe', 'Escalade', 'Randonnée', 'Cyclisme', 'Course à pied',
    'Escrime', 'Zététique', 'Archéométrie', 'Femmes dans la littérature de l\'Antiquité', 'Histoire des sciences',

];

$courseBasicTitles = [
    'Écriture musicale', 'Base de données', 'Badminton', 'Naissance du médicament', 'Civilisation italienne',
];
$courseBasicDesc = [
    'Cours d\'harmonie, apprentissage des règles de composition musicale. Accords de 5tes Maj et Min, accords de 7tes de dominante et de sensible, cadences tonales et modulation.',
    'Les systèmes de gestion de base de données (SGBD), conception et modélisation de bases de données, langage SQL, requêtes, intégrité référentielle, transactions, procédures stockées, triggers, vues',
    'Cours de badminton, apprentissage des règles du jeu, des techniques de frappe, des déplacements sur le terrain, des stratégies de jeu, des tactiques de match',
    'Cours sur la naissance du médicament, découverte des molécules, des principes actifs, des excipients, des formes galéniques, des voies d\'administration, des effets secondaires. Introduction à la pharmacologie, et à la pharmacovigilance',
    'Cours sur la civilisation italienne, histoire, géographie, culture, langue, littérature, arts, politique, économie, société, gastronomie, mode, cinéma, musique, architecture, design, sport, religion, traditions, fêtes, célébrités, tourisme',
];
$courseBasicPrerequis = [
    'Savoir lire la clé de Sol et de Fa, commencer à l\'apprentissage de la clé d\'Ut 3ème ligne',
    'Connaître les bases de l\'algèbre relationnelle, et les formes de normalisation des bases de données',
    'Avoir sa propre raquette, des chaussures et une tenue de sport adaptées',
    'Aucun prérequis nécessaire',
    'Niveau B1 en italien, ou avoir suivi le cours d\'italien de niveau A2',
];
$courseBasicPrix = [
    0, 0, 20, 5, 0,
];
$courseBasicNoteSatGlob = [
    4.5, 5, 4.8, 3.2, 2.3,
];

// Cours de base pour les tests :
for ($i = 1; $i <= 5; $i++) {
    $intitule_cours = $courseBasicTitles[$i - 1];
    $desc_cours = $courseBasicDesc[$i - 1];
    $prerequis_cours = $courseBasicPrerequis[$i - 1];
    $prix_cours = $courseBasicPrix[$i - 1];
    // Gestion des dates de début et de fin optionnelles
    $dateDebut_cours = $faker->optional()->dateTimeBetween('-1 years', 'now');
    $dateFin_cours = null;
    if ($dateDebut_cours) {
        $dateDebut_cours = $dateDebut_cours->format('Y-m-d H:i:s');
        $dateFin_cours = $faker->dateTimeBetween('now', '+1 years')->format('Y-m-d H:i:s');
    }
    $noteSatGlob_cours = $courseBasicNoteSatGlob[$i - 1];
    // Récupération de l'id d'une session aléatoire
    $session_num_session = $faker->optional()->randomElement($conn->query("SELECT num_session FROM session")->fetchAll(PDO::FETCH_COLUMN));
    insertFakeData($conn, 'cours', [
        'intitule_cours' => $intitule_cours,
        'desc_cours' => $desc_cours,
        'prerequis_cours' => $prerequis_cours,
        'prix_cours' => $prix_cours,
        'dateDebut_cours' => $dateDebut_cours,
        'dateFin_cours' => $dateFin_cours,
        'noteSatGlob_cours' => $noteSatGlob_cours,
        'session_num_session' => $session_num_session
    ]);
}

// Nombre des cours restants à générer aléatoirement :
$coursCount = 15;

for ($i = 1; $i <= $coursCount; $i++) {
    $intitule_cours = $faker->randomElement($courseTitles);
    $desc_cours = $faker->paragraph;
    $prerequis_cours = $faker->sentence;
    $prix_cours = $faker->randomNumber(2);
    // Gestion des dates de début et de fin optionnelles
    $dateDebut_cours = $faker->optional()->dateTimeBetween('-1 years', 'now');
    $dateFin_cours = null;
    if ($dateDebut_cours) {
        $dateDebut_cours = $dateDebut_cours->format('Y-m-d H:i:s');
        $dateFin_cours = $faker->dateTimeBetween('now', '+1 years')->format('Y-m-d H:i:s');
    }
    $noteSatGlob_cours = $faker->optional()->randomFloat(2, 0, 5);

    // Récupération de l'id d'une session aléatoire
    $session_num_session = $faker->optional()->randomElement($conn->query("SELECT num_session FROM session")->fetchAll(PDO::FETCH_COLUMN));

    insertFakeData($conn, 'cours', [
        'intitule_cours' => $intitule_cours,
        'desc_cours' => $desc_cours,
        'prerequis_cours' => $prerequis_cours,
        'prix_cours' => $prix_cours,
        'dateDebut_cours' => $dateDebut_cours,
        'dateFin_cours' => $dateFin_cours,
        'noteSatGlob_cours' => $noteSatGlob_cours,
        'session_num_session' => $session_num_session
    ]);
}

echo "COURS inserted successfully" . "\n";

// ############################################ CHAPITRES ######################################################
// Suppression des examens avant de supprimer les parties
clearTable($conn, 'tentative');
clearTable($conn, 'progression');
clearTable($conn, 'examen');
// Suppression des parties avant de supprimer les chapitres
clearTable($conn, 'parties');
clearTable($conn, 'chapitres');

$chapitresBasicTitles = [
    'Accords de 3 sons Majeurs et Mineurs', 'Accords de 4 sons : 7ème de dominante', 'Accords de 4 sons : 7ème de sensible',
];

// Sélection du cours d'id 1 pour lui attribuer des chapitres
$cours_num_cours = 1;
// Création de 3 chapitres pour le cours d'id 1 Écriture musicale
for ($i = 1; $i <= 3; $i++) {
    $titre_chap = $chapitresBasicTitles[$i - 1];

    insertFakeData($conn, 'chapitres', [
        'titre_chap' => $titre_chap,
        'cours_num_cours' => $cours_num_cours
    ]);
}

// Titres de chapitre possibles :
$chapitresTitles = [
    'Introduction', 'Définitions', 'Historique', 'Principes fondamentaux', 'Méthodologie', 'Applications', 'Exercices', 'Cas pratiques',
    'Exemples', 'Études de cas', 'Résultats', 'Conclusions', 'Perspectives', 'Bibliographie', 'Webographie', 'Glossaire', 'Annexes', 'Résumé', 'Synthèse'
];

// Nombre de chapitres à générer :
$chapitresCount = 10;

for ($i = 1; $i <= $chapitresCount; $i++) {
    $titre_chap = $faker->randomElement($chapitresTitles);

    // Récupération de l'id d'un cours aléatoire (sauf l'id de cours 1)
    $query = $conn->query("SELECT num_cours FROM cours WHERE num_cours != 1 ORDER BY RAND() LIMIT 1");
    $cours_num_cours = $query->fetchColumn();

    // Insert the fake data into the chapitres table
    insertFakeData($conn, 'chapitres', [
        'titre_chap' => $titre_chap,
        'cours_num_cours' => $cours_num_cours
    ]);
}

echo "CHAPITRES inserted successfully" . "\n";

// ############################################ PARTIES ######################################################
clearTable($conn, 'tentative');
clearTable($conn, 'progression');
clearTable($conn, 'examen');
clearTable($conn, 'parties');

$partiesBasicTitles = [
    'La tierce Majeure et la tierce mineure', 'La quinte juste',
    'La 7ème de dominante', 'Modulation en utilisant la 7ème de dominante',
    'La 7ème de sensible et la 5te diminuée', 'Les 3 accords de sensibles',
];

// Sélection des chapitres 1 à 3 pour leur attribuer des parties
$chapitres_num_chap = 1;
for ($i = 1; $i <= 2; $i++) {
    $titre_part = $partiesBasicTitles[$i - 1];
    $contenu_part = $faker->paragraph;

    insertFakeData($conn, 'parties', [
        'titre_part' => $titre_part,
        'contenu_part' => $contenu_part,
        'chapitres_num_chap' => $chapitres_num_chap
    ]);
}
$chapitres_num_chap = 2;
for ($i = 3; $i <= 4; $i++) {
    $titre_part = $partiesBasicTitles[$i - 1];
    $contenu_part = $faker->paragraph;

    insertFakeData($conn, 'parties', [
        'titre_part' => $titre_part,
        'contenu_part' => $contenu_part,
        'chapitres_num_chap' => $chapitres_num_chap
    ]);
}
$chapitres_num_chap = 3;
for ($i = 5; $i <= 6; $i++) {
    $titre_part = $partiesBasicTitles[$i - 1];
    $contenu_part = $faker->paragraph;

    insertFakeData($conn, 'parties', [
        'titre_part' => $titre_part,
        'contenu_part' => $contenu_part,
        'chapitres_num_chap' => $chapitres_num_chap
    ]);
}

// Titres de partie possibles :
$partiesTitles = [
    'Introduction', 'Définitions', 'Historique', 'Principes fondamentaux', 'Méthodologie', 'Applications', 'Exercices', 'Cas pratiques',
    'Exemples', 'Études de cas', 'Résultats', 'Conclusions', 'Perspectives', 'Bibliographie', 'Webographie', 'Glossaire', 'Annexes', 'Résumé', 'Synthèse',
    'Partie 1', 'Partie 2', 'Partie 3', 'Partie 4', 'Partie 5', 'Partie 6', 'Partie 7', 'Partie 8', 'Partie 9', 'Partie 10', 'Partie I', 'Partie II', 'Partie III',
    'Partie IV', 'Partie V', 'Partie VI', 'Partie VII', 'Partie VIII', 'Partie IX', 'Partie X'
];

// Nombre de parties à générer :
$partiesCount = 17;

for ($i = 1; $i <= $partiesCount; $i++) {
    $titre_part = $faker->randomElement($partiesTitles);
    $contenu_part = $faker->paragraph;

    // Récupération de l'id d'un chapitre aléatoire (sauf ceux d'id 1, 2 et 3)
    $chapitres_num_chap = $faker->optional()->randomElement($conn->query("SELECT num_chap FROM chapitres WHERE num_chap NOT IN (1, 2, 3)")->fetchAll(PDO::FETCH_COLUMN));

    // Insert the fake data into the parties table
    insertFakeData($conn, 'parties', [
        'titre_part' => $titre_part,
        'contenu_part' => $contenu_part,
        'chapitres_num_chap' => $chapitres_num_chap
    ]);
}

echo "PARTIES inserted successfully" . "\n";

// ############################################ EXAMEN ######################################################
clearTable($conn, 'tentative');
clearTable($conn, 'examen');

// Titres d'examen possibles :
$examenTitles = [
    'Examen final', 'Examen de mi-parcours', 'Examen de fin de session', 'Examen de rattrapage', 'Examen blanc', 'Examen de certification',
    'Examen de validation', 'Examen de passage', 'Examen de contrôle continu', 'Examen de synthèse', 'Examen de compétences', 'Examen de connaissances',
    'Examen de pratique', 'Examen de théorie', 'Examen de travaux pratiques', 'Examen de travaux dirigés', 'Examen de travaux personnels encadrés',
    'Examen de travaux de groupe', 'Examen de travaux de recherche', 'Examen de travaux de mémoire', 'Examen de travaux de thèse', 'Examen de travaux de projet',
    'Examen de travaux de stage', 'Examen de travaux de fin d\'études', 'Examen de travaux de fin de formation', 'Examen de travaux de fin de cursus',
];

// Création spécifique d'un examen pour les parties de cours d'id 1 à 6
for ($parties_num_part = 1; $parties_num_part <= 6; $parties_num_part++) {
    $titre_exam = $faker->randomElement($examenTitles);
    $contenu_exam = $faker->paragraph;
    $scoreMin_exam = $faker->numberBetween(40, 100);

    insertFakeData($conn, 'examen', [
        'titre_exam' => $titre_exam,
        'contenu_exam' => $contenu_exam,
        'scoreMin_exam' => $scoreMin_exam,
        'parties_num_part' => $parties_num_part
    ]);
}

// Nombre d'examens à générer :
$examenCount = 10;

for ($i = 1; $i <= $examenCount; $i++) {
    $titre_exam = $faker->randomElement($examenTitles);
    $contenu_exam = $faker->paragraph;
    $scoreMin_exam = $faker->numberBetween(40, 100);

    // Récupération de l'id d'une partie aléatoire (sauf les parties d'id 1 à 6)
    $parties_num_part = $faker->randomElement($conn->query("SELECT num_part FROM parties WHERE num_part > 6")->fetchAll(PDO::FETCH_COLUMN));

    if ($parties_num_part) {
        insertFakeData($conn, 'examen', [
            'titre_exam' => $titre_exam,
            'contenu_exam' => $contenu_exam,
            'scoreMin_exam' => $scoreMin_exam,
            'parties_num_part' => $parties_num_part
        ]);
    }
}

echo "EXAMEN inserted successfully" . "\n";

// ############################################ INSCRIPTION ######################################################
clearTable($conn, 'inscription');

// L'utilisateur d'id 2 (étudiant) s'est inscrit à tous les cours (car il a payé tous les cours)
$utilisateur_num_ut = 2;
$cours = $conn->query("SELECT num_cours FROM cours")->fetchAll(PDO::FETCH_COLUMN);
foreach ($cours as $cours) {
    $date_in = $faker->dateTimeThisYear->format('Y-m-d H:i:s');

    insertFakeData($conn, 'inscription', [
        'date_in' => $date_in,
        'utilisateur_num_ut' => $utilisateur_num_ut,
        'cours_num_cours' => $cours
    ]);
}
// L'utilisateur d'id 3 (étudiant) s'est inscrit au cours d'id 1 Écriture musicale
$utilisateur_num_ut = 3;
$cours_num_cours = 1;
$date_in = $faker->dateTimeThisYear->format('Y-m-d H:i:s');

insertFakeData($conn, 'inscription', [
    'date_in' => $date_in,
    'utilisateur_num_ut' => $utilisateur_num_ut,
    'cours_num_cours' => $cours_num_cours
]);
// L'utilisateur d'id 4 (étudiant) s'est inscrit au cours d'id 2 Base de données
insertFakeData($conn, 'inscription', [
    'date_in' => $faker->dateTimeThisYear->format('Y-m-d H:i:s'),
    'utilisateur_num_ut' => 4,
    'cours_num_cours' => 2
]);
// L'utilisateur d'id 5 (étudiant) s'est inscrit à aucun cours

// Nombre d'inscriptions à générer :
$inscriptionCount = 10;

for ($i = 1; $i <= $inscriptionCount; $i++) {
    $date_in = $faker->dateTimeThisYear->format('Y-m-d H:i:s');

    // Récupération de l'id d'un utilisateur (sauf l'étudiant d'id 5) et d'un cours aléatoire
    $utilisateur_num_ut = $faker->randomElement($conn->query("SELECT num_ut FROM utilisateur WHERE num_ut != 5")->fetchAll(PDO::FETCH_COLUMN));
    $cours_num_cours = $faker->randomElement($conn->query("SELECT num_cours FROM cours")->fetchAll(PDO::FETCH_COLUMN));

    insertFakeData($conn, 'inscription', [
        'date_in' => $date_in,
        'utilisateur_num_ut' => $utilisateur_num_ut,
        'cours_num_cours' => $cours_num_cours
    ]);
}

echo "INSCRIPTION inserted successfully" . "\n";

// ############################################ PAIEMENT ######################################################
clearTable($conn, 'paiement');

$utilisateur_num_ut = 2; // Utilisateur d'id 2 (étudiant) a acheté tout les cours
$cours = $conn->query("SELECT num_cours, prix_cours FROM cours")->fetchAll(PDO::FETCH_ASSOC);
foreach ($cours as $cours) {
    $montant_paie = $cours['prix_cours'];
    $date_paie = $faker->dateTimeThisYear->format('Y-m-d H:i:s');
    $statut_paie = 'traité';

    insertFakeData($conn, 'paiement', [
        'montant_paie' => $montant_paie,
        'date_paie' => $date_paie,
        'statut_paie' => $statut_paie,
        'utilisateur_num_ut' => $utilisateur_num_ut,
        'cours_num_cours' => $cours['num_cours']
    ]);
}
// L'utilisateur d'id 3 (étudiant) a acheté le cours d'id 1 Écriture musicale
$montant_paie = $conn->query("SELECT prix_cours FROM cours WHERE num_cours = 1")->fetchColumn();
$date_paie = $faker->dateTimeThisYear->format('Y-m-d H:i:s');
$statut_paie = 'traité';

insertFakeData($conn, 'paiement', [
    'montant_paie' => $montant_paie,
    'date_paie' => $date_paie,
    'statut_paie' => $statut_paie,
    'utilisateur_num_ut' => 3,
    'cours_num_cours' => 1
]);
// L'utilisateur d'id 4 (étudiant) a acheté le cours d'id 2 Base de données
insertFakeData($conn, 'paiement', [
    'montant_paie' => $conn->query("SELECT prix_cours FROM cours WHERE num_cours = 2")->fetchColumn(),
    'date_paie' => $faker->dateTimeThisYear->format('Y-m-d H:i:s'),
    'statut_paie' => 'traité',
    'utilisateur_num_ut' => 4,
    'cours_num_cours' => 2
]);
// L'utilisateur d'id 5 (étudiant) n'a acheté aucun cours

// Define the number of paiement records to generate
$paiementCount = 10;

for ($i = 1; $i <= $paiementCount; $i++) {
    $montant_paie = $faker->numberBetween(1, 100);
    $date_paie = $faker->dateTimeThisYear->format('Y-m-d H:i:s');
    $statut_paie = $faker->randomElement(['traité', 'en cours', 'echec']);

    // Récupération de l'id d'un utilisateur (sauf l'utilisateur d'id 2 et 5) et d'un cours aléatoire
    $utilisateur_num_ut = $faker->randomElement($conn->query("SELECT num_ut FROM utilisateur WHERE num_ut != 2 AND num_ut != 5")->fetchAll(PDO::FETCH_COLUMN));
    $cours_num_cours = $faker->randomElement($conn->query("SELECT num_cours FROM cours")->fetchAll(PDO::FETCH_COLUMN));

    insertFakeData($conn, 'paiement', [
        'montant_paie' => $montant_paie,
        'date_paie' => $date_paie,
        'statut_paie' => $statut_paie,
        'utilisateur_num_ut' => $utilisateur_num_ut,
        'cours_num_cours' => $cours_num_cours
    ]);
}

echo "PAIEMENT inserted successfully" . "\n";

// ############################################ CREATION ######################################################
clearTable($conn, 'creation');

$creationCount = 20;

for ($i = 1; $i <= $creationCount; $i++) {
    $date_crea = $faker->dateTimeThisYear->format('Y-m-d H:i:s');
    $detailsModif_crea = $faker->sentence;

    // Récupération de l'id d'un utilisateur (avec le role formateur, administrateur, ou createur) et d'un cours aléatoire
    $utilisateur_num_ut = $faker->randomElement($conn->query("SELECT utilisateur.num_ut FROM utilisateur JOIN utilisateur_role
    ON utilisateur.num_ut = utilisateur_role.utilisateur_num_ut JOIN role ON utilisateur_role.role_id_role = role.id_role
    WHERE role.nom_role IN ('formateur', 'administrateur', 'createur')")->fetchAll(PDO::FETCH_COLUMN));
    $cours_num_cours = $faker->randomElement($conn->query("SELECT num_cours FROM cours")->fetchAll(PDO::FETCH_COLUMN));

    insertFakeData($conn, 'creation', [
        'date_crea' => $date_crea,
        'detailsModif_crea' => $detailsModif_crea,
        'utilisateur_num_ut' => $utilisateur_num_ut,
        'cours_num_cours' => $cours_num_cours
    ]);
}

echo "CREATION inserted successfully" . "\n";

// ############################################ PROGRESSION ######################################################
clearTable($conn, 'progression');

// L'utilisateur d'id 3 a terminé toutes les parties d'un cours :
$utilisateur_num_ut = 3;
$cours_num_cours = 1;
// L'utilisateur 5 ne peut pas avoir de progression car il n'a pas acheté de cours

$insertedCombinations = [];

// L'étudiant 3 a terminé toutes les parties du cours 1
$parties = $conn->query("SELECT num_part FROM parties WHERE chapitres_num_chap IN (SELECT num_chap FROM chapitres WHERE cours_num_cours = $cours_num_cours)")->fetchAll(PDO::FETCH_COLUMN);
foreach ($parties as $partie) {
    $partieFinie_prog = true;  // L'utilisateur a terminé la partie
    $date_prog = $faker->dateTimeThisYear->format('Y-m-d H:i:s');

    insertFakeData($conn, 'progression', [
        'partieFinie_prog' => $partieFinie_prog,
        'date_prog' => $date_prog,
        'utilisateur_num_ut' => $utilisateur_num_ut,
        'parties_num_part' => $partie
    ]);

    $insertedCombinations[$utilisateur_num_ut . '-' . $partie] = true;
}

$progressionCount = 9;

for ($i = 1; $i <= $progressionCount; $i++) {
    $partieFinie_prog = $faker->boolean;
    $date_prog = $faker->dateTimeThisYear->format('Y-m-d H:i:s');

    // Récupération de l'id d'un utilisateur (sauf l'utilisateur d'id 3 et 5) et d'une partie aléatoire
    $utilisateur_num_ut = $faker->randomElement($conn->query("SELECT num_ut FROM utilisateur WHERE num_ut !=3 AND num_ut != 5")->fetchAll(PDO::FETCH_COLUMN));
    $parties_num_part = $faker->randomElement($conn->query("SELECT num_part FROM parties")->fetchAll(PDO::FETCH_COLUMN));

    if (!isset($insertedCombinations[$utilisateur_num_ut . '-' . $parties_num_part])) {
        insertFakeData($conn, 'progression', [
            'partieFinie_prog' => $partieFinie_prog,
            'date_prog' => $date_prog,
            'utilisateur_num_ut' => $utilisateur_num_ut,
            'parties_num_part' => $parties_num_part
        ]);
    }

    $insertedCombinations[$utilisateur_num_ut . '-' . $parties_num_part] = true;
}

echo "PROGRESSION inserted successfully" . "\n";

// ############################################ TENTATIVE ######################################################
clearTable($conn, 'tentative');

// L'utilisateur 3 a fait au moins une tentative pour chaque examen de chaque partie du cours 1
$utilisateur_num_ut = 3;
$cours_num_cours = 1;
// Récupération de tous les examens du cours 1
$examens = $conn->query("SELECT num_exam, scoreMin_exam FROM examen WHERE parties_num_part IN (SELECT num_part FROM parties WHERE chapitres_num_chap IN (SELECT num_chap FROM chapitres WHERE cours_num_cours = $cours_num_cours))")->fetchAll(PDO::FETCH_ASSOC);
foreach ($examens as $examen) {
    $scoreObt_tent = $faker->numberBetween($examen['scoreMin_exam'], 100);
    $date_tent = $faker->dateTimeThisYear->format('Y-m-d H:i:s');

    insertFakeData($conn, 'tentative', [
        'scoreObt_tent' => $scoreObt_tent,
        'date_tent' => $date_tent,
        'utilisateur_num_ut' => $utilisateur_num_ut,
        'examen_num_exam' => $examen['num_exam']
    ]);
}
// L'étudiant 5 ne peut pas avoir de tentative car il n'a pas acheté de cours

$tentativeCount = 15;

for ($i = 0; $i < $tentativeCount; $i++) {
    $scoreObt_tent = rand(0, 100);
    $date_tent = $faker->dateTimeThisYear()->format('Y-m-d H:i:s');

    // Récupération de l'id d'un utilisateur et d'un examen aléatoire
    $utilisateur_num_ut = $faker->randomElement($conn->query("SELECT num_ut FROM utilisateur WHERE num_ut != 5")->fetchAll(PDO::FETCH_COLUMN));
    $examen_num_exam = $faker->randomElement($conn->query("SELECT num_exam FROM examen")->fetchAll(PDO::FETCH_COLUMN));

    insertFakeData($conn, 'tentative', [
        'scoreObt_tent' => $scoreObt_tent,
        'date_tent' => $date_tent,
        'utilisateur_num_ut' => $utilisateur_num_ut,
        'examen_num_exam' => $examen_num_exam
    ]);
}

echo "TENTATIVE inserted successfully" . "\n";

// ############################################ NOTE_SATISFACTION ######################################################
clearTable($conn, 'note_satisfaction');

$commentairePossibles = [
    'Le prof est très beau', 'Très bon cours', 'Excellent formateur', 'Contenu très intéressant', 'Je recommande', 'Cours très complet', 'Formateur très pédagogue',
    'Bon cours, mais je ne comprends pas tout', 'Cours difficile', 'Je n\'ai pas aimé', 'Formateur pas assez clair', 'Cours trop long', 'Je ne recommande pas',
    'Woah, trop bien', 'Je suis fan', 'Cours trop chargé', 'Cours trop facile', 'Merci beaucoup pour ce cours', 'Très bonne élocution', 'Cours très enrichissant',
    'Je n\'ai pas trop aimé certaines parties', 'Cours très interactif', 'Super explications', 'Sujets très intéressants !', 'Très bon feedbacks',
];

// L'utilisateur d'id 4 (étudiant) a laissé une note de satisfaction pour le cours d'id 2 Base de données
insertFakeData($conn, 'note_satisfaction', [
    'utilisateur_num_ut' => 4,
    'cours_num_cours' => 2,
    'noteSat' => 5,
    'commentaire' => $commentairePossibles[0],
]);
// L'utilisateur d'id 5 (étudiant) n'a laissé aucune note de satisfaction car il n'a pas acheté de cours

$noteSatisfactionCount = 10;

for ($i = 0; $i < $noteSatisfactionCount; $i++) {
    // Récupération de l'id d'un utilisateur (sauf l'utilisateur d'id 5) et d'un cours aléatoire
    $utilisateur_num_ut = $faker->randomElement($conn->query("SELECT num_ut FROM utilisateur WHERE num_ut != 5")->fetchAll(PDO::FETCH_COLUMN));
    $cours_num_cours = $faker->randomElement($conn->query("SELECT num_cours FROM cours")->fetchAll(PDO::FETCH_COLUMN));

    $noteSat = rand(1, 5);
    $commentaire = $faker->randomElement($commentairePossibles);

    insertFakeData($conn, 'note_satisfaction', [
        'utilisateur_num_ut' => $utilisateur_num_ut,
        'cours_num_cours' => $cours_num_cours,
        'noteSat' => $noteSat,
        'commentaire' => $commentaire
    ]);
}

echo "NOTE_SATISFACTION inserted successfully" . "\n";