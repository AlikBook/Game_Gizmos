const express = require("express");
const app = express();
const PORT = 3000;

// Middleware pour parser le JSON
app.use(express.json());

// Route test
app.get("/", (req, res) => {
  res.send("Hello from the backend!");
});

// Démarrer le serveur
app.listen(PORT, () => {
  console.log(`Backend is running on http://localhost:${PORT}`);
});
