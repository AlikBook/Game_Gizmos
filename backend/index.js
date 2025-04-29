const express = require("express");
const app = express();
const mysql = require("mysql2");
const cors = require("cors");
const PORT = 3000;

require("dotenv").config();
app.use(cors());

// Middleware pour parser le JSON
app.use(express.json());

const connection = mysql.createConnection({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
});

connection.connect((err) => {
  if (err) {
    console.error("Erreur de connexion à la base de données:", err.stack);
    return;
  }
  console.log(
    "Connexion réussie à la base de données avec l'ID",
    connection.threadId
  );
});

// Route test
app.get("/", (req, res) => {
  res.send("Hello from the backend!");
});

app.get("/allgames", (req, res) => {
  const sql = "SELECT * FROM Games";
  connection.query(sql, (err, results) => {
    if (err) {
      console.error("Erreur lors de la récupération des jeux:", err);
      res.status(500).send("Erreur serveur");
    } else {
      res.json(results);
    }
  });
});


app.get("/game/:id", (req, res) => {
  const sql = "SELECT * FROM GAMES WHERE game_id = ?";
  const gameId = req.params.id;

  connection.query(sql, [gameId], (err, results) => {
    if (err) {
      console.error("Erreur lors de la récupération du jeu:", err);
      res.status(500).send("Erreur serveur");
    } else {
      if (results.length > 0) {
        res.json(results[0]);  
      } else {
        res.status(404).send("Jeu non trouvé");
      }
    }
  });
});


app.listen(PORT, () => {
  console.log(`Backend is running on http://localhost:${PORT}`);
});
