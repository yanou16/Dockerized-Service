const express = require('express');
const dotenv = require('dotenv');
const auth = require('basic-auth');

// Charger les variables d'environnement
dotenv.config();

const app = express();
const PORT = process.env.PORT || 3000;

// Route principale
app.get('/', (req, res) => {
  res.send('Hello, world!');
});

// Route protégée par Basic Auth
app.get('/secret', (req, res) => {
  const credentials = auth(req);
  
  // Vérifier les identifiants
  if (!credentials || 
      credentials.name !== process.env.AUTH_USERNAME || 
      credentials.pass !== process.env.AUTH_PASSWORD) {
    res.statusCode = 401;
    res.setHeader('WWW-Authenticate', 'Basic realm="Accès restreint"');
    return res.send('Accès refusé: Identifiants incorrects');
  }
  
  // Si les identifiants sont corrects, renvoyer le message secret
  res.send(process.env.SECRET_MESSAGE);
});

// Démarrer le serveur
app.listen(PORT, () => {
  console.log(`Serveur démarré sur le port ${PORT}`);
});