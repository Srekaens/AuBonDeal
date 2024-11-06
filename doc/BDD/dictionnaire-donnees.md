# Dictionnaire de données

## Table: `Users`
Contient les informations sur les utilisateurs inscrits sur la plateforme.

| Champ          | Type              | Contraintes                                     | Description                                 |
|----------------|-------------------|-------------------------------------------------|---------------------------------------------|
| `user_UUID`    | `UUID`            | `PRIMARY KEY`, `DEFAULT gen_random_uuid()`      | Identifiant unique de l'utilisateur         |
| `user_pseudo`  | `VARCHAR(50)`     | `NOT NULL`                                      | Pseudonyme de l'utilisateur                 |
| `username`     | `VARCHAR(100)`    | `NOT NULL`                                      | Nom de connexion ou email de l'utilisateur  |
| `user_password`| `VARCHAR(255)`    | `NOT NULL`                                      | Mot de passe hashé de l'utilisateur         |
| `created_at`   | `TIMESTAMP`       | `DEFAULT CURRENT_TIMESTAMP`                     | Date de création du compte                  |

## Table: `Products`
Contient les informations sur les produits disponibles à la vente sur la plateforme.

| Champ               | Type              | Contraintes                                     | Description                                 |
|---------------------|-------------------|-------------------------------------------------|---------------------------------------------|
| `product_UUID`      | `UUID`            | `PRIMARY KEY`, `DEFAULT gen_random_uuid()`      | Identifiant unique du produit               |
| `product_name`      | `VARCHAR(100)`    | `NOT NULL`                                      | Nom du produit                              |
| `product_description`| `TEXT`           | -                                               | Description détaillée du produit            |
| `product_price`     | `DECIMAL(10, 2)`  | `NOT NULL`, `CHECK (product_price >= 0)`        | Prix unitaire du produit                    |
| `product_quantity`  | `INTEGER`         | `NOT NULL`, `CHECK (product_quantity >= 0)`     | Quantité en stock du produit                |
| `created_at`        | `TIMESTAMP`       | `DEFAULT CURRENT_TIMESTAMP`                     | Date d'ajout du produit                     |
| `updated_at`        | `TIMESTAMP`       | `DEFAULT CURRENT_TIMESTAMP`                     | Date de dernière mise à jour du produit     |

## Table: `Orders`
Contient les informations sur les commandes effectuées par les utilisateurs.

| Champ                | Type              | Contraintes                                     | Description                                 |
|----------------------|-------------------|-------------------------------------------------|---------------------------------------------|
| `order_number`       | `SERIAL`          | `PRIMARY KEY`                                   | Identifiant unique de la commande           |
| `order_total_cost_ht`| `DECIMAL(10, 2)`  | `CHECK (order_total_cost_ht >= 0)`              | Coût total de la commande hors taxe         |
| `order_total_quantity`| `INTEGER`        | `NOT NULL`, `CHECK (order_total_quantity >= 0)` | Quantité totale d'articles dans la commande |
| `created_at`         | `TIMESTAMP`       | `DEFAULT CURRENT_TIMESTAMP`                     | Date de création de la commande             |
| `deliver_at`         | `TIMESTAMP`       | -                                               | Date prévue de livraison                    |
