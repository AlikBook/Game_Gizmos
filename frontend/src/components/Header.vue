<template>
  <header>
    <div class="logo">
      <h1>🎲 GameGizmos</h1>
    </div>
    <nav>
      <ul class="nav-links">
        <li><router-link to="/">Home</router-link></li>
        <li><router-link to="/about">About</router-link></li>
        <li><router-link to="/discover">Discover</router-link></li>
        <li><router-link to="/events">Events</router-link></li>
      </ul>
    </nav>
    <div class="users">
      <template v-if="isLoggedIn">
        <span class="welcome">Welcome, {{ username }}!</span>
        <button @click="logout" class="btn btn-logout">Logout</button>
      </template>
      <template v-else>
        <input v-model="email" type="email" placeholder="Email" />
        <input v-model="password" type="password" placeholder="Password" />
        <button @click="login" class="btn">Log in</button>
        <button @click="register" class="btn btn-secondary">Sign up</button>
      </template>
    </div>
  </header>
</template>

<script setup>
import { ref } from "vue";
import { useRouter } from "vue-router";
import axios from "axios";

const router = useRouter();
const isLoggedIn = ref(!!localStorage.getItem("token"));
const username = ref(localStorage.getItem("username") || "");
const email = ref("");
const password = ref("");

const login = async () => {
  try {
    const response = await axios.post("http://localhost:3000/login", {
      email: email.value,
      password: password.value,
    });
    const { token } = response.data;

    // Stocker le token et l'email dans le localStorage
    localStorage.setItem("token", token);
    localStorage.setItem("username", email.value);

    // Mettre à jour l'état
    isLoggedIn.value = true;
    username.value = email.value;

    alert("Connexion réussie !");
    router.push("/");
  } catch (error) {
    console.error("Erreur lors de la connexion :", error);
    alert("Identifiants invalides !");
  }
};

const register = async () => {
  try {
    await axios.post("http://localhost:3000/register", {
      email: email.value,
      password: password.value,
    });

    alert("Compte créé avec succès !");
    email.value = "";
    password.value = "";
  } catch (error) {
    console.error("Erreur lors de l'inscription :", error);
    alert("Erreur lors de la création du compte !");
  }
};

const logout = () => {
  localStorage.removeItem("token");
  localStorage.removeItem("username");

  isLoggedIn.value = false;
  username.value = "";

  alert("Déconnexion réussie !");
  router.push("/");
};
</script>

<style scoped>
header {
  background: #1e1e2f;
  color: white;
  padding: 20px 40px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  flex-wrap: wrap;
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.2);
}

.logo h1 {
  font-size: 28px;
  margin: 0;
}

.nav-links {
  list-style: none;
  display: flex;
  gap: 25px;
  margin: 0;
  padding: 0;
}

.nav-links a {
  color: white;
  font-weight: bold;
  text-decoration: none;
  transition: color 0.3s;
}

.nav-links a:hover {
  color: #ffd700;
}

.users {
  display: flex;
  align-items: center;
  gap: 10px;
  flex-wrap: wrap;
}

.users input {
  padding: 6px 10px;
  border-radius: 5px;
  border: none;
  outline: none;
}

.btn {
  background-color: #ffd700;
  border: none;
  padding: 6px 12px;
  border-radius: 5px;
  cursor: pointer;
  font-weight: bold;
  color: black;
  transition: background-color 0.3s;
}

.btn:hover {
  background-color: #e6c200;
}

.btn-secondary {
  background-color: #4caf50;
  color: white;
}

.btn-secondary:hover {
  background-color: #3e8e41;
}

.btn-logout {
  background-color: #e74c3c;
  color: white;
}

.btn-logout:hover {
  background-color: #c0392b;
}

.welcome {
  font-weight: bold;
  margin-right: 10px;
  padding: 5px 10px;
}
</style>
