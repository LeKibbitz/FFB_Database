# FFB Database - Projet Bridge

Base de données pour la Fédération Française de Bridge (FFB) utilisant Prisma et Supabase.

## 🚀 Configuration

### 1. Installation des dépendances
```bash
npm install
```

### 2. Configuration de l'environnement
Copiez le fichier `.env.example` vers `.env` et configurez vos variables d'environnement :

```env
# === SUPABASE ===
SUPABASE_URL=https://votre-projet.supabase.co
SUPABASE_ANON_KEY=votre-clé-anon
SUPABASE_SERVICE_ROLE_KEY=votre-clé-service

# === POSTGRESQL ===
DATABASE_URL="postgresql://postgres:votre-mot-de-passe@votre-host:5432/postgres"
```

### 3. Génération du client Prisma
```bash
npm run db:generate
```

## 📊 Modèles de données

### Club
- Informations de base (nom, code, adresse, etc.)
- Relations avec joueurs, rôles et agréments

### Joueur
- Informations personnelles (nom, prénom, licence, etc.)
- Relation avec le club d'appartenance
- Relations avec rôles et agréments

### Role
- Définition des rôles/fonctions
- Relations avec joueurs et clubs

### Agrement
- Définition des agréments/autorisations
- Relations avec joueurs et clubs

## 🔧 Scripts disponibles

### Base de données
```bash
# Générer le client Prisma
npm run db:generate

# Récupérer le schéma de la base
npm run db:pull

# Créer une migration
npm run db:migrate

# Ouvrir Prisma Studio
npm run db:studio
```

### Import/Export
```bash
# Importer les données CSV
npm run import:data

# Tester la connexion
npm run test:connection
```

## 📁 Structure du projet

```
FFB_Database/
├── prisma/
│   └── schema.prisma          # Schéma de la base de données
├── scripts/
│   ├── import-data.js         # Script d'import CSV
│   └── test-connection.js     # Script de test
├── clubs.csv                  # Données des clubs
├── players.csv                # Données des joueurs
└── .env                       # Variables d'environnement
```

## 🚨 Résolution des problèmes

### Problème de connexion
Si vous obtenez une erreur de connexion :
1. Vérifiez que votre projet Supabase est actif
2. Vérifiez les variables d'environnement dans `.env`
3. Testez la connexion avec `npm run test:connection`

### Problème d'import
Si l'import échoue :
1. Vérifiez que les fichiers CSV sont dans le bon format
2. Vérifiez que la base de données est accessible
3. Consultez les logs d'erreur

## 📝 Notes

- Les fichiers `.env`, `.gitignore` et `.cursorignore` sont ignorés par Git
- Le client Prisma est généré automatiquement après modification du schéma
- Les scripts d'import gèrent automatiquement les relations entre les tables
