# Propositions d'amélioration pour la base de données *AuBonDeal*

## Introduction

Pour renforcer la sécurité, améliorer la gestion des utilisateurs et optimiser les performances de la base de données *AuBonDeal*, deux améliorations clés sont proposées. Chaque proposition est accompagnée d'une explication sur la nécessité de cette amélioration et des détails sur sa mise en œuvre.

---

## 1. Ajout d'une table `Roles`

### Pourquoi améliorer ce point

Actuellement, la base de données ne distingue pas les différents types d'utilisateurs ni leurs permissions. Cette absence de distinction peut entraîner des problèmes de sécurité et complique la gestion des accès aux fonctionnalités de l'application. En introduisant une table `Roles`, il devient possible de définir clairement les niveaux d'accès et les autorisations pour chaque type d'utilisateur, comme les administrateurs, les clients ou les vendeurs.

### Proposition d'amélioration

- **Créer une table `Roles`** pour définir les différents rôles au sein du système.
- **Ajouter un champ `role_id`** à la table `Users` pour associer chaque utilisateur à un rôle spécifique.

#### Structure proposée pour la table `Roles`

| Champ         | Type        | Description                                      |
|---------------|-------------|--------------------------------------------------|
| `role_id`     | INT (PK)    | Identifiant unique du rôle                       |
| `role_name`   | VARCHAR(50) | Nom du rôle (e.g., "Admin", "Client", "Vendeur") |
| `description` | TEXT        | Description du rôle (optionnelle)                |

#### Modification de la table `Users`

- **Ajout du champ** `role_id` (INT, clé étrangère vers `Roles.role_id`).

**Avantages :**

- **Sécurité renforcée** : Contrôle précis des accès aux fonctionnalités sensibles.
- **Gestion facilitée** : Attribution claire des permissions selon le rôle de l'utilisateur.
- **Maintenance simplifiée** : Possibilité d'ajouter ou de modifier des rôles sans impact majeur sur la structure existante.

---

## 2. Mise en place d'une table d'historique des prix des produits

### Pourquoi améliorer ce point

Dans le cadre d'un site e-commerce, il est essentiel de conserver un historique des prix des produits pour diverses raisons, telles que les analyses commerciales, la gestion des promotions ou la résolution de litiges. Sans cet historique, il devient difficile de retracer les changements de prix et d'adapter les stratégies marketing en conséquence.

### Proposition d'amélioration

- **Créer une table `ProductPriceHistory`** pour enregistrer chaque modification de prix d'un produit.
- **Enregistrer les informations clés** : identifiant du produit, ancien prix, nouveau prix, date du changement.

#### Structure proposée pour la table `ProductPriceHistory`

| Champ            | Type        | Description                                     |
|------------------|-------------|-------------------------------------------------|
| `history_id`     | INT (PK)    | Identifiant unique de l'historique              |
| `product_id`     | INT (FK)    | Référence au produit concerné                   |
| `old_price`      | DECIMAL     | Prix avant la modification                      |
| `new_price`      | DECIMAL     | Prix après la modification                      |
| `change_date`    | DATETIME    | Date et heure de la modification                |
| `changed_by`     | INT (FK)    | Identifiant de l'utilisateur ayant fait le changement (optionnel) |

**Avantages :**

- **Analyse commerciale améliorée** : Suivi des tendances de prix et impact sur les ventes.
- **Gestion des promotions** : Historique clair pour planifier et évaluer les promotions.
- **Traçabilité** : Facilite la résolution de litiges liés aux prix.

---

## Conclusion

L'ajout d'une table `Roles` et la mise en place d'une table d'historique des prix des produits sont deux améliorations essentielles pour la base de données *AuBonDeal*. Elles visent à renforcer la sécurité, améliorer la gestion des utilisateurs et offrir une meilleure traçabilité des données critiques. Ces modifications contribueront à une gestion plus efficace de la plateforme et à une expérience utilisateur optimisée.

---