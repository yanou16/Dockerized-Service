FROM node:18-alpine

WORKDIR /app

# Copier les fichiers package.json et package-lock.json
COPY package*.json ./

# Installer les dépendances
RUN npm install

# Copier le reste des fichiers du projet
COPY . .

# Exposer le port sur lequel le serveur s'exécute
EXPOSE 3000

# Commande pour démarrer l'application
CMD ["node", "server.js"]