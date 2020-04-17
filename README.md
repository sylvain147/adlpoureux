# adlpoureux
Hello maman


Couleur principale : bleu #13395d
Couleur secondaire : rose #EF476F 
Gris clair : #d4d4d4
Gris foncé : #404040


# Front-office :
## Produits : 
- id
- titre
- Description
- créateur
- Tags
- Catégories[]

## Catégories : 
- id 
- Nom
- description
- Produits

## tag :
- id
- nom

## Utilisateur : 
- id
- Nom
- Prenom
- pseudo
- Date de naissance
- pavatar
- profile

## Créateur : 
- id
- utilisateur
- produits

## Client : 
- id
- utilisateur
- Commandes

## Comandes : 
- id 
- Ligne de commande []
- Utilisateur

## Ligne de commande : 
- id
- Produit
- Nombre
- Prix
- Prix total

# Back-office :
- Générateur de facture
- CRUD produit
- Gestionnaire utilisateurs
