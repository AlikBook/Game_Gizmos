const express = require("express");
const app = express();
const mysql = require("mysql2");
const cors = require("cors");
const bcrypt = require("bcrypt");
const jwt = require("jsonwebtoken");
const PORT = 3000;

require("dotenv").config();
app.use(cors({
  origin: "https://game-gizmos.vercel.app/", 
  credentials: true
}));

app.use(express.json());

const connection = mysql.createConnection({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  port: process.env.DB_PORT,
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

  const gameQuery = "SELECT * FROM GameDetails WHERE game_id = ?";
  const rateQuery = "CALL GetGameRatings(?);";

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
        rates: rateResults[0],
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

app.post("/create-event", (req, res) => {
  const {
    event_name,
    event_description,
    max_participants,
    min_participants,
    game_id,
    date
  } = req.body;

  if (
    !event_name ||
    !event_description ||
    max_participants == null ||
    min_participants == null ||
    !game_id ||
    !date
  ) {
    return res.status(400).json({ message: "Missing required fields" });
  }

  const sql = "CALL CreateEvent(?, ?, 0, ?, ?, ?, ?)";
  connection.query(
    sql,
    [
      event_name,
      event_description,
      max_participants,
      min_participants,
      game_id,
      date,
    ],
    (err, result) => {
      if (err) {
        console.error("Error creating event:", err);
        return res
          .status(500)
          .json({ message: "Server error", details: err.message });
      }

      res.status(201).json({ message: "Event created successfully" });
    }
  );
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

app.post("/register", (req, res) => {
  const { email, password } = req.body;

  if (!email || !password) {
    return res.status(400).json({ message: "Email and password are required" });
  }

  connection.query(
    "INSERT INTO Users (user_mail, password) VALUES (?, ?)",
    [email, password],
    (err, results) => {
      if (err) {
        console.error("Erreur lors de l'enregistrement :", err);

        if (err.code === "ER_SIGNAL_EXCEPTION" || err.sqlState === "45000") {
          return res.status(400).json({ message: err.sqlMessage });
        }

        return res.status(500).json({ message: "Erreur serveur" });
      }
      res.status(201).json({ message: "Utilisateur enregistré avec succès" });
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
    (err, results) => {
      if (err || results.length === 0) {
        return res.status(401).json({ message: "Identifiants invalides" });
      }

      const user = results[0];

      if (password !== user.password) {
        return res.status(401).json({ message: "Identifiants invalides" });
      }

      const token = jwt.sign(
        { user_id: user.user_id, email: user.user_mail },
        process.env.JWT_SECRET,
        { expiresIn: "1d" }
      );

      res.json({
        token,
        user_id: user.user_id,
        email: user.user_mail,
        message: "Connexion réussie",
      });
    }
  );
});

app.post("/join_event/:event_id", (req, res) => {
  const eventId = req.params.event_id;
  const { user_id, user_mail } = req.body;

  if (!user_id || !user_mail) {
    return res.status(400).json({ message: "User ID and email are required" });
  }

  const checkSql = `
    SELECT * FROM Participates 
    WHERE user_id = ? AND user_mail = ? AND event_id = ?
  `;

  connection.query(
    checkSql,
    [user_id, user_mail, eventId],
    (checkErr, checkResults) => {
      if (checkErr) {
        console.error("Error checking participation:", checkErr);
        return res.status(500).json({ message: "Server error" });
      }

      if (checkResults.length > 0) {
        return res
          .status(400)
          .json({ message: "User already joined this event" });
      }

      const joinSql = "CALL JoinEvent(?, ?, ?)";
      connection.query(
        joinSql,
        [eventId, user_id, user_mail],
        (err, results) => {
          if (err) {
            if (err.sqlState === "45000") {
              return res.status(400).json({ message: err.sqlMessage });
            }

            return res.status(500).json({ message: "Server error" });
          }

          res.json({ message: "Successfully joined the event", results });
        }
      );
    }
  );
});

app.post("/leave_event/:event_id", (req, res) => {
  const eventId = req.params.event_id;
  const { user_id, user_mail } = req.body;

  if (!user_id || !user_mail) {
    return res.status(400).json({ message: "User ID and email are required" });
  }

  const sql = "CALL LeaveEvent(?, ?, ?)"; // Assuming your stored procedure takes these 3 params

  connection.query(sql, [eventId, user_id, user_mail], (err, result) => {
    if (err) {
      console.error("Error leaving event:", err);
      return res.status(500).json({ message: "Server error" });
    }

    res.json({ message: "Successfully left the event" });
  });
});

app.get("/user_events", (req, res) => {
  const { user_id, user_mail } = req.query;

  if (!user_id || !user_mail) {
    return res.status(400).json({ message: "Missing user ID or email" });
  }

  const sql = `
    SELECT event_id FROM Participates
    WHERE user_id = ? AND user_mail = ?
  `;

  connection.query(sql, [user_id, user_mail], (err, results) => {
    if (err) {
      console.error("Error fetching user events:", err);
      return res.status(500).json({ message: "Server error" });
    }

    res.json(results);
  });
});
