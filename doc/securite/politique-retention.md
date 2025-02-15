# Politique de rétention

## 1. Objectifs de la politique

- **Assurer la continuité des activités** : Garantir que les données critiques sont disponibles en cas d'incident.

- **Protéger les données sensibles** : Prévenir les accès non autorisés et les fuites d'informations.

- **Conformité réglementaire** : Respecter les lois relatives à la protection des données personnelles, notamment le RGPD.

- **Optimiser la gestion des données** : Éviter l'accumulation de données obsolètes ou non pertinentes.

---

## 2. Portée

Cette politique s'applique à toutes les données collectées, traitées et stockées dans le cadre du projet **AuBonDeal**, y compris :

- **Données des utilisateurs** : Informations personnelles des vendeurs et acheteurs.
  
- **Données des transactions** : Détails des ventes, achats et historiques.

- **Données des produits** : Descriptions, images et caractéristiques des articles.

- **Données techniques** : Journaux système, configurations et métadonnées.

---

## 3. Fréquence des sauvegardes

- **Sauvegarde somplète quotidienne** : Une sauvegarde complète de la base de données sera effectuée chaque jour à 02h00 du matin.

- **Sauvegardes incrémentielles horaires** : Des sauvegardes incrémentielles seront réalisées toutes les heures pour capturer les modifications récentes.

- **Sauvegarde hebdomadaire** : Chaque dimanche, une sauvegarde complète sera conservée séparément comme point de restauration principal.

---

## 4. Procédures de sauvegarde

- **Automatisation** : Utilisation de scripts planifiés (`sauvegarde_automatique.sh`).
  
- **Vérification d'intégrité** : Contrôles réguliers avec `verification_integrite.sh`.

- **Journalisation** : Enregistrement des opérations de sauvegarde pour audit.

---

## 5. Procédure de restauration

### Processus de restauration :

- Identification du point de restauration nécessaire.
- Utilisation de `restauration_base_de_donnees.sh`.
- Validation post-restauration.
- Tests périodiques : Simulations trimestrielles pour assurer l'efficacité.

---

## 6. Sécurité des Données

- **Chiffrement** : Utilisation de l'AES-256 pour toutes les sauvegardes.

- **Gestion des clés** : Clés stockées en modules matériels sécurisés (HSM).

- **Contrôle d'accès** : Politiques strictes, authentification multi-facteurs.

---

## 7. Responsabilités

### Administrateur de base de données (DBA) :

- Mise en œuvre des procédures de sauvegarde et restauration.
- Surveillance et maintenance des systèmes de sauvegarde.

### Équipe de sécurité :

- Gestion des accès et permissions.
- Audits de sécurité réguliers.

### Direction technique :

- Approbation et révision de la politique.
- Allocation des ressources nécessaires.

---

## 8. Conformité et audits

- **Conformité au RGPD** : Traitement des données personnelles conformément aux droits des utilisateurs.
  
- **Audits internes** : Vérifications semestrielles de conformité.

- **Audits externes** : Audits annuels par une tierce partie indépendante.

---

## 9. Les endroits de stockage avec la règle 3-2-1

La règle 3-2-1 est une stratégie éprouvée pour la sauvegarde des données visant à minimiser les risques de perte de données :

- **3 copies des données** : Conservez au moins trois copies de vos données. Cela inclut l'originale et deux copies de sauvegarde.
  
- **2 types de supports différents** : Stockez les copies de sauvegarde sur au moins deux types de supports distincts (par exemple, disque dur interne et stockage cloud).

- **1 copie hors site** : Gardez au moins une copie de sauvegarde dans un emplacement géographiquement distinct des données originales. Cela protège vos données en cas de sinistre localisé.

### Pourquoi appliquer la règle 3-2-1 ?

- **Protection contre les défaillances matérielles** : Si un support de stockage tombe en panne, les autres copies assurent la récupération des données.
- **Sécurité en cas de sinistre** : Une copie hors site garantit que vos données sont préservées même si votre emplacement principal est compromis.
- **Prévention contre les erreurs humaines et les logiciels malveillants** : Avoir plusieurs copies réduit le risque que des erreurs ou des attaques affectent toutes les copies simultanément.

**Exemple d'application de la règle 3-2-1** :

- **Original** : Les données sur votre ordinateur de travail.
- **Première sauvegarde locale** : Une copie sur un disque dur externe connecté à votre ordinateur.
- **Deuxième sauvegarde hors site** : Une sauvegarde automatique vers un service de stockage en cloud sécurisé.

---

## 10. Emplacements de stockage

### Stockage principal (local)

- **Description** : Serveurs internes sécurisés avec redondance RAID.
  
- **Sécurité** : Accès restreint, pare-feu, chiffrement des données au repos.

### Stockage secondaire (Support externe)

- **Description** : Disques durs externes chiffrés, stockés dans un coffre-fort sécurisé.
  
- **Sécurité** : Chiffrement, accès physique contrôlé.

### Stockage hors site (Cloud sécurisé)

- **Description** : Services cloud conformes aux normes de sécurité (AWS S3, Azure).
  
- **Sécurité** : Chiffrement de bout en bout, conformité RGPD, redondance géographique.

---

## 11. Durées de rétention des données

### Données des utilisateurs

- **Durée de conservation** : Les données personnelles sont conservées pendant la durée de la relation contractuelle, puis archivées pendant **3 ans** après la dernière activité.

- **Destruction** : Suppression sécurisée après la période de conservation légale.

### Données des transactions

- **Durée de conservation** : Conservées pendant **10 ans** conformément aux obligations comptables et fiscales.

- **Destruction** : Suppression sécurisée après expiration des obligations légales.

### Données des produits

- **Durée de conservation** : Conservées tant que le produit est actif sur la plateforme, puis archivées pendant **2 ans** après désactivation ou suppression du produit.

- **Destruction** : Suppression après la période d'archivage.

### Données techniques

- **Journaux système** : Conservés pendant **6 mois**.

- **Configurations** : Conservées indéfiniment ou jusqu'à modification.

---

## 12. Pour lutter contre quelles menaces ? 

Cette politique de rétention est conçue pour protéger contre plusieurs types de menaces liées à la sécurité des données. Voici les attaques spécifiques contre lesquelles cette politique vise à lutter :

### 1. **Pertes de données accidentelles**
- **Menace** : Suppression ou modification erronée des données par un utilisateur ou un employé.
- **Contre-mesures** : 
  - Sauvegardes régulières pour garantir la récupération des données perdues.
  - Utilisation de la règle 3-2-1 pour éviter la perte de données locales.
  - Vérifications d'intégrité des sauvegardes pour éviter les erreurs.

### 2. **Corruption de données**
- **Menace** : Corruption des données suite à des défaillances matérielles (ex : disque dur défectueux), des erreurs logicielles ou des attaques malveillantes.
- **Exemples d'attaques** : **Injections SQL**, **pannes de disque dur**.
- **Contre-mesures** : 
  - Sauvegardes régulières et tests de restauration pour vérifier l'intégrité des données.
  - Chiffrement des données pour éviter l'altération non autorisée.

### 3. **Attaques ransomware**
- **Menace** : Chiffrement des données par des attaquants afin d'exiger une rançon pour leur décryptage.
- **Exemple d'attaque** : **Chiffrement des données par un ransomware**.
- **Contre-mesures** : 
  - Sauvegardes incrémentielles horaires pour minimiser la perte de données avant l'attaque.
  - Stockage des sauvegardes dans des endroits hors ligne (par exemple, stockage cloud sécurisé) pour empêcher l'attaque d'affecter toutes les copies.
  - Chiffrement des sauvegardes pour éviter qu'elles ne soient corrompues ou effacées.

### 4. **Catastrophes naturelles**
- **Menace** : Sinistres physiques (incendies, inondations) qui pourraient affecter les installations où les données sont stockées localement.
- **Exemple de menaces** : **Incendie**, **inondation**, **vol**.
- **Contre-mesures** : 
  - Utilisation de la règle 3-2-1 pour garantir qu'au moins une copie des données est conservée hors site.
  - Stockage des données dans des environnements géographiquement distincts, comme le cloud sécurisé.
  - Chiffrement des sauvegardes pour garantir leur sécurité, même en cas d'accès physique non autorisé.