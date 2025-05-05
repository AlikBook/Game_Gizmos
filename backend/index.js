const express = require("express");
const app = express();
const mysql = require("mysql2");
const cors = require("cors");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
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

app.get("/upcoming_events", (req, res) => {
  const sql = "SELECT * FROM UpcomingEvents";
  connection.query(sql, (err, results) => {
    if (err) {
      console.error(
        "Erreur lors de la récupération des événements à venir:",
        err
      );
      res.status(500).send("Erreur serveur");
    } else {
      res.json(results);
    }
  });
});

app.listen(PORT, () => {
  console.log(`Backend is running on http://localhost:${PORT}`);
});

app.post("/register", async (req, res) => {
  const { email, password } = req.body;

  if (!email || !password) {
    return res.status(400).json({ message: "Email and password are required" });
  }

  // Vérifier si l'email existe déjà
  connection.query(
    "SELECT * FROM Users WHERE user_mail = ?",
    [email],
    async (err, results) => {
      if (err) {
        console.error("Erreur lors de l'enregistrement :", err);
        return res.status(500).json({ message: "Erreur serveur" });
      }

      if (results.length > 0) {
        return res.status(400).json({ message: "L'email existe déjà" });
      }

      try {
        const hashedPassword = await bcrypt.hash(password, 10);

        // Insérer le nouvel utilisateur dans la base de données
        connection.query(
          "INSERT INTO Users (user_mail, password) VALUES (?, ?)",
          [email, hashedPassword],
          (err, results) => {
            if (err) {
              console.error("Erreur lors de l'enregistrement :", err);
              return res.status(500).json({ message: "Erreur serveur" });
            }
            res.status(201).json({ message: "Utilisateur enregistré avec succès" });
          }
        );
      } catch (hashError) {
        console.error("Erreur lors du hashage du mot de passe :", hashError);
        res.status(500).json({ message: "Erreur serveur" });
      }
    }
  );
});

app.post("/login", (req, res) => {
  const { email, password } = req.body;

  if (!email || !password) {
    return res.status(400).json({ message: "Email et mot de passe requis" });
  }

  connection.query(
    "SELECT * FROM Users WHERE user_mail = ?",
    [email],
    async (err, results) => {
      if (err || results.length === 0) {
        return res.status(401).json({ message: "Identifiants invalides" });
      }

      const user = results[0];
      try {
        const match = await bcrypt.compare(password, user.password);

        if (!match) {
          return res.status(401).json({ message: "Identifiants invalides" });
        }

        // Générer un token JWT
        const token = jwt.sign(
          { user_id: user.user_id, email: user.user_mail },
          process.env.JWT_SECRET,
          { expiresIn: "1d" }
        );

        res.json({ token, message: "Connexion réussie" });
      } catch (compareError) {
        console.error("Erreur lors de la comparaison des mots de passe :", compareError);
        res.status(500).json({ message: "Erreur serveur" });
      }
    }
  );
});
