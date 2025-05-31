# 🎲 Game Rating Website: **GameGizmos**

**GameGizmos** is a platform where users can **rate board games** and **join community events**.  
It provides a simple experience for browsing games and engaging with fellow board game enthusiasts.

---

## 👥 User Roles & Features

### 👤 Guest
- Can browse board games
- Cannot rate games or participate in events

### 🧑‍💻 Registered User
- Can rate games
- Can join and participate in events

### 🔐 Authentication
- Simple login system to unlock interactive features

---

# ⚙️ Project Setup Instructions

Follow the steps below to run the project locally.

---

## 📁 Install Dependencies

Run the following in **both** the `frontend` and `backend` folders:

```bash
npm install
```

---

## 🗄️ Database Setup

1. Open **MySQL Workbench** (or any SQL tool).
2. Create the database by executing the contents of the `database.sql` file.

---

## 🚀 Running the Project

### ▶️ Frontend

In the `frontend` folder, start the development server:

```bash
npm run dev
```

### 🖥️ Backend

In the `backend` folder, start the backend server:

Crete an .env file with the information from your database like
```bash
DB_HOST=127.0.0.1
DB_USER=root
DB_PORT=3306
DB_PASSWORD="12345"
DB_NAME=game_gizmos
JWT_SECRET=your_key
```

```bash
npm start
```

---

✅ **GameGizmos** is now running locally!  
You can browse, rate, and enjoy the world of board games 🎯
