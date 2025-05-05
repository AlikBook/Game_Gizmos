<template>
  <header>
    <h1>Games</h1>
    <nav>
      <ul>
        <li><router-link to="/">Home</router-link></li>
        <li><router-link to="/about">About</router-link></li>
      </ul>
      <div class="users">
        <template v-if="isLoggedIn">
          <p>Welcome, {{ username }}!</p>
          <button @click="logout">Logout</button>
        </template>
        <template v-else>
          <div>
            <input v-model="email" type="email" placeholder="Email" />
            <input v-model="password" type="password" placeholder="Password" />
            <button @click="login">Log in</button>
            <button @click="register">Sign up</button>
          </div>
        </template>
      </div>
    </nav>
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
  padding: 20px;
  display: flex;
  justify-content: space-between;
}

header h1 {
  padding-left: 50px;
  font-size: 40px;
  margin: 0;
}

header ul {
  list-style: none;
  display: flex;
  gap: 20px;
}

header a {
  text-decoration: none;
  color: #fff;
}

header a:hover {
  text-decoration: underline;
}

.users input {
  margin-right: 10px;
  padding: 5px;
}

.users button {
  margin-right: 10px;
  padding: 5px 10px;
}
</style>
