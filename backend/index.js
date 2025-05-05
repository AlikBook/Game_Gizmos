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

app.get("/game_rate/:id", (req, res) => {
  const gameId = req.params.id;

  const gameQuery = "SELECT * FROM GAMES WHERE game_id = ?";
  const rateQuery = "SELECT * FROM rates WHERE game_id = ?";

  connection.query(gameQuery, [gameId], (err, gameResults) => {
    if (err) {
      console.error("Error fetching game:", err);
      return res.status(500).send("Server error while fetching game");
    }

    if (gameResults.length === 0) {
      return res.status(404).send("Game not found");
    }

    connection.query(rateQuery, [gameId], (err, rateResults) => {
      if (err) {
        console.error("Error fetching rates:", err);
        return res.status(500).send("Server error while fetching rates");
      }

      res.json({
        game: gameResults[0],
        rates: rateResults,
      });
    });
  });
});

app.post("/insert_rate/:id", (req, res) => {
  const { game_id, user_id, user_mail, rate, comments } = req.body;

  if (!game_id || !user_id || !user_mail || !rate || !comments) {
    return res.status(400).send("Missing required fields");
  }

  const sql = "CALL AddRating(?, ?, ?, ?, ?)";

  connection.query(
    sql,
    [rate, comments, game_id, user_id, user_mail],
    (err, result) => {
      if (err) {
        console.error("Error saving rating:", err);
        return res.status(500).send("Error saving rating");
      }

      res.json({ success: true, result });
    }
  );
});

app.get("/events", (req, res) => {
  const sql = "SELECT * FROM Events";
  connection.query(sql, (err, results) => {
    if (err) {
      console.error("Erreur lors de la récupération des événements:", err);
      res.status(500).send("Erreur serveur");
    } else {
      res.json(results);
    }
  });
});

app.listen(PORT, () => {
  console.log(`Backend is running on http://localhost:${PORT}`);
});
