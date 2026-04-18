const express = require("express");
const app = express();
const mysql = require("mysql2");
const cors = require("cors");
const bcrypt = require("bcryptjs");
const jwt = require("jsonwebtoken");
const PORT = 3000;

require("dotenv").config();
app.use(cors()); 
app.use(express.json());

const pool = mysql.createPool({
  host: process.env.DB_HOST,
  user: process.env.DB_USER,
  port: process.env.DB_PORT,
  password: process.env.DB_PASSWORD,
  database: process.env.DB_NAME,
  waitForConnections: true,
  connectionLimit: 10,
  queueLimit: 0,
  ssl: {
    rejectUnauthorized: true
  }
});

const db = pool.promise();

pool.getConnection((err, conn) => {
  if (err) {
    console.error("Erreur de connexion a TiDB:", err.message);
  } else {
    console.log("Connexion réussie a TiDB via Pool!");
    conn.release();
  }
});

app.get("/", (req, res) => {
  res.send("Hello from the backend! ");
});

app.get("/allgames", async (req, res) => {
  try {
    const sql = "SELECT * FROM Games";
    const [results] = await db.query(sql);
    res.json(results);
  } catch (err) {
    console.error("Erreur lors de la récupération des jeux:", err);
    res.status(500).send("Erreur serveur");
  }
});

app.get("/game_rate/:id", async (req, res) => {
  try {
    const gameId = req.params.id;

    const gameQuery = "SELECT * FROM GameDetails WHERE game_id = ?";
    const rateQuery = `
      SELECT user_mail, game_name, Rate, Comments, id_rate
      FROM UserRatingHistory
      WHERE game_id = ?
    `;

    const [gameResults] = await db.query(gameQuery, [gameId]);

    if (gameResults.length === 0) {
      return res.status(404).send("Game not found");
    }

    const [rateResults] = await db.query(rateQuery, [gameId]);

    res.json({
      game: gameResults[0],
      rates: rateResults,
    });
  } catch (err) {
    console.error("Error fetching game or rates:", err);
    res.status(500).send("Server error");
  }
});

app.post("/insert_rate/:id", async (req, res) => {
  const { game_id, user_id, user_mail, rate, comments } = req.body;

  if (!game_id || !user_id || !user_mail || !rate || !comments) {
    return res.status(400).send("Missing required fields");
  }

  try {
    await db.query(
      "INSERT INTO Rates (Rate, Comments, game_id, user_id, user_mail) VALUES (?, ?, ?, ?, ?)",
      [rate, comments, game_id, user_id, user_mail]
    );

    res.json({ success: true });
  } catch (err) {
    console.error("Error saving rating:", err);
    res.status(500).send("Error saving rating");
  }
});

app.get("/events", async (req, res) => {
  try {
    const sql = "SELECT * FROM Events";
    const [results] = await db.query(sql);
    res.json(results);
  } catch (err) {
    console.error("Erreur lors de la récupération des événements:", err);
    res.status(500).send("Erreur serveur");
  }
});

app.post("/create-event", async (req, res) => {
  try {
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

    const sql = `
      INSERT INTO Events (
        event_name, event_description, nb_participants,
        max_participants, min_participants, game_id, event_date
      )
      VALUES (?, ?, 0, ?, ?, ?, ?)
    `;

    await db.query(sql, [
      event_name,
      event_description,
      max_participants,
      min_participants,
      game_id,
      date,
    ]);

    res.status(201).json({ message: "Event created successfully" });
  } catch (err) {
    console.error("Error creating event:", err);
    res.status(500).json({ message: "Server error", details: err.message });
  }
});

app.get("/upcoming_events", async (req, res) => {
  try {
    const sql = "SELECT * FROM UpcomingEvents";
    const [results] = await db.query(sql);
    res.json(results);
  } catch (err) {
    console.error(
      "Erreur lors de la récupération des événements à venir:",
      err
    );
    res.status(500).send("Erreur serveur");
  }
});

app.post("/register", async (req, res) => {
  try {
    const { email, password } = req.body;

    if (!email || !password) {
      return res.status(400).json({ message: "Email and password are required" });
    }

    await db.query(
      "INSERT INTO Users (user_mail, password) VALUES (?, ?)",
      [email, password]
    );

    res.status(201).json({ message: "Utilisateur enregistré avec succès" });
  } catch (err) {
    console.error("Erreur lors de l'enregistrement :", err);

    if (err.code === "ER_SIGNAL_EXCEPTION" || err.sqlState === "45000") {
      return res.status(400).json({ message: err.sqlMessage });
    }

    res.status(500).json({ message: "Erreur serveur" });
  }
});

app.post("/login", async (req, res) => {
  try {
    const { email, password } = req.body;

    if (!email || !password) {
      return res.status(400).json({ message: "Email et mot de passe requis" });
    }

    const [results] = await db.query(
      "SELECT * FROM Users WHERE user_mail = ?",
      [email]
    );

    if (results.length === 0) {
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
  } catch (err) {
    console.error("Login error:", err);
    res.status(401).json({ message: "Identifiants invalides" });
  }
});

app.post("/join_event/:event_id", async (req, res) => {
  const eventId = req.params.event_id;
  const { user_id, user_mail } = req.body;

  if (!user_id || !user_mail) {
    return res.status(400).json({ message: "User ID and email are required" });
  }

  try {
    await db.query("START TRANSACTION");

    // Check if already joined
    const [checkResults] = await db.query(
      `SELECT 1 FROM Participates
       WHERE user_id = ? AND user_mail = ? AND event_id = ?
       LIMIT 1`,
      [user_id, user_mail, eventId]
    );

    if (checkResults.length > 0) {
      await db.query("ROLLBACK");
      return res.status(400).json({ message: "User already joined this event" });
    }

    // Check participant count
    const [countResults] = await db.query(
      "SELECT COUNT(*) AS current_count FROM Participates WHERE event_id = ?",
      [eventId]
    );

    const [eventResults] = await db.query(
      "SELECT max_participants FROM Events WHERE event_id = ?",
      [eventId]
    );

    if (eventResults.length === 0) {
      await db.query("ROLLBACK");
      return res.status(404).json({ message: "Event not found" });
    }

    const currentCount = countResults[0].current_count;
    const maxCount = eventResults[0].max_participants;

    if (currentCount >= maxCount) {
      await db.query("ROLLBACK");
      return res.status(400).json({ message: "Event is full" });
    }

    // Insert participation
    await db.query(
      "INSERT INTO Participates (event_id, user_id, user_mail) VALUES (?, ?, ?)",
      [eventId, user_id, user_mail]
    );

    // Update event participants count
    await db.query(
      `UPDATE Events
       SET nb_participants = nb_participants + 1
       WHERE event_id = ?`,
      [eventId]
    );

    await db.query("COMMIT");
    res.json({ message: "Successfully joined the event" });
  } catch (err) {
    try {
      await db.query("ROLLBACK");
    } catch (rollbackErr) {
      console.error("Error rolling back transaction:", rollbackErr);
    }
    console.error("Error joining event:", err);
    res.status(500).json({ message: "Server error" });
  }
});

app.post("/leave_event/:event_id", async (req, res) => {
  const eventId = req.params.event_id;
  const { user_id, user_mail } = req.body;

  if (!user_id || !user_mail) {
    return res.status(400).json({ message: "User ID and email are required" });
  }

  try {
    await db.query("START TRANSACTION");

    // Delete participation
    const [deleteResult] = await db.query(
      `DELETE FROM Participates
       WHERE event_id = ? AND user_id = ? AND user_mail = ?`,
      [eventId, user_id, user_mail]
    );

    if (deleteResult.affectedRows === 0) {
      await db.query("ROLLBACK");
      return res.status(404).json({ message: "Participation not found" });
    }

    // Update event participants count
    await db.query(
      `UPDATE Events
       SET nb_participants = GREATEST(nb_participants - 1, 0)
       WHERE event_id = ?`,
      [eventId]
    );

    await db.query("COMMIT");
    res.json({ message: "Successfully left the event" });
  } catch (err) {
    try {
      await db.query("ROLLBACK");
    } catch (rollbackErr) {
      console.error("Error rolling back transaction:", rollbackErr);
    }
    console.error("Error leaving event:", err);
    res.status(500).json({ message: "Server error" });
  }
});

app.get("/user_events", async (req, res) => {
  try {
    const { user_id, user_mail } = req.query;

    if (!user_id || !user_mail) {
      return res.status(400).json({ message: "Missing user ID or email" });
    }

    const [results] = await db.query(
      `SELECT event_id FROM Participates
       WHERE user_id = ? AND user_mail = ?`,
      [user_id, user_mail]
    );

    res.json(results);
  } catch (err) {
    console.error("Error fetching user events:", err);
    res.status(500).json({ message: "Server error" });
  }
});


app.listen(PORT, () => {
    console.log(`Server ready on port ${PORT}`);
});

module.exports = app;
