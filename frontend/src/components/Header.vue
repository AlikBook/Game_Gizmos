<template>
  <header>
    <div class="logo">
      <h1>🎲 GameGizmos</h1>
    </div>
    <nav>
      <ul class="nav-links">
        <li><router-link to="/">Home</router-link></li>

        <li><router-link to="/discover">Discover</router-link></li>
        <li><router-link to="/events">Events</router-link></li>
        <li><router-link to="/about">About</router-link></li>
      </ul>
    </nav>
    <div class="users">
      <template v-if="isLoggedIn">
        <span class="welcome">Welcome, {{ username }}!</span>
        <button @click="logout" class="btn btn-logout">Logout</button>
        <button @click="openCreateEventModal" class="btn btn-secondary">Create Event</button>
      </template>
      <template v-else>
        <input v-model="email" type="email" placeholder="Email" />
        <input v-model="password" type="password" placeholder="Password" />
        <button @click="login" class="btn">Log in</button>
        <button @click="register" class="btn btn-secondary">Sign up</button>
      </template>
    </div>
  </header>
  <div v-if="showModal" class="modal">
    <div class="modal-content">
      <h2>Create an Event</h2>
      <form @submit.prevent="createEvent">
        <div>
          <label for="eventName">Event Name:</label>
          <input v-model="eventName" id="eventName" type="text" required />
        </div>
        <div>
          <label for="eventDescription">Description:</label>
          <textarea v-model="eventDescription" id="eventDescription" required></textarea>
        </div>
        <div>
          <label for="maxParticipants">Max Participants:</label>
          <input v-model="maxParticipants" id="maxParticipants" type="number" required />
        </div>
        <div>
          <label for="minParticipants">Min Participants:</label>
          <input v-model="minParticipants" id="minParticipants" type="number" required />
        </div>
        <div>
          <label for="gameId">Game ID:</label>
          <input v-model="gameId" id="gameId" type="text" required />
        </div>
        <div>
          <label for="date">Date:</label>
          <input v-model="date" id="date" type="date" required />
        </div>
        <button type="submit" class="btn btn-secondary">Create Event</button>
        <button @click="closeModal" class="btn btn-logout">Cancel</button>
      </form>
    </div>
  </div>
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
const showModal = ref(false);
const eventName = ref("");
const eventDescription = ref("");
const maxParticipants = ref(0);
const minParticipants = ref(0);
const gameId = ref("");
const date = ref("");

const login = async () => {
  try {
    const response = await axios.post("http://localhost:3000/login", {
      email: email.value,
      password: password.value,
    });
    const { token, user_id } = response.data;

    localStorage.setItem("token", token);
    localStorage.setItem("user_id", user_id);
    localStorage.setItem("username", email.value);
    localStorage.setItem("user_id", user_id);

    isLoggedIn.value = true;
    username.value = email.value;

    alert("Connexion réussie !");
    router.push("/");
  } catch (error) {
    console.error("Error during the connection:", error);
    alert("invalid logins!");
  }
};

const register = async () => {
  try {
    await axios.post("http://localhost:3000/register", {
      email: email.value,
      password: password.value,
    });

    alert("Account created successfully !");
    email.value = "";
    password.value = "";
  } catch (error) {
    console.error("Registration error :", error);

    const errorMessage = error.response?.data?.message || "Account creation error !";
    alert(errorMessage);
  }
};

const logout = () => {
  localStorage.removeItem("token");
  localStorage.removeItem("username");
  localStorage.removeItem("user_id");

  isLoggedIn.value = false;
  username.value = "";

  email.value = "";
  password.value = "";

  alert("Successful disconnection !");
  router.push("/");
};

const openCreateEventModal = () => {
  showModal.value = true; 
};

const closeModal = () => {
  showModal.value = false; 
};

const createEvent = async () => {
  try {
    const response = await axios.post("http://localhost:3000/create-event", {
      event_name: eventName.value,
      event_description: eventDescription.value,
      max_participants: maxParticipants.value,
      min_participants: minParticipants.value,
      game_id: gameId.value,
      date: date.value,
    });

    alert("Event created successfully!");
    closeModal(); 
    eventName.value = "";
    eventDescription.value = "";
    maxParticipants.value = 0;
    minParticipants.value = 0;
    gameId.value = "";
    date.value = "";
  } catch (error) {
    console.error("Error creating event:", error);
    alert("Failed to create event.");
  }
};
</script>

<style scoped>
header {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  background: #1e1e2f;
  color: white;
  padding: 20px 40px;
  display: flex;
  align-items: center;
  justify-content: space-between;
  flex-wrap: wrap;
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.2);
  z-index: 1000;
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

.modal {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  background-color: rgba(0, 0, 0, 0.7);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: 100;
}

.modal-content {
  background: linear-gradient(135deg, #ffffff, #f9f9f9); 
  padding: 30px;
  border-radius: 12px;
  width: 500px;
  max-width: 90%; 
  box-shadow: 0 8px 20px rgba(0, 0, 0, 0.3); 
  animation: fadeIn 0.3s ease-out; 
}

.modal-content h2 {
  text-align: center;
  font-size: 24px;
  margin-bottom: 20px;
  color: #333;
}

.modal-content form div {
  margin-bottom: 15px;
}

.modal-content label {
  display: block;
  font-weight: bold;
  margin-bottom: 5px;
  color: #555;
}

.modal-content input,
.modal-content textarea {
  width: 100%;
  padding: 10px;
  border: 1px solid #ddd;
  border-radius: 6px;
  font-size: 14px;
  transition: border-color 0.3s;
}

.modal-content input:focus,
.modal-content textarea:focus {
  border-color: #4caf50; 
  outline: none;
}

.modal-content textarea {
  width: 100%;
  padding: 10px;
  border: 1px solid #ddd;
  border-radius: 6px;
  font-size: 14px;
  transition: border-color 0.3s;
  resize: none; 
}

.modal-content textarea:focus {
  border-color: #4caf50; 
  outline: none;
}

.modal-content button {
  display: block;
  width: 100%;
  padding: 12px;
  margin-top: 10px;
  font-size: 16px;
  font-weight: bold;
  border: none;
  border-radius: 6px;
  cursor: pointer;
  transition: background-color 0.3s;
}

.modal-content .btn-secondary {
  background-color: #4caf50;
  color: white;
}

.modal-content .btn-secondary:hover {
  background-color: #3e8e41;
}

.modal-content .btn-logout {
  background-color: #e74c3c;
  color: white;
}

.modal-content .btn-logout:hover {
  background-color: #c0392b;
}

@keyframes fadeIn {
  from {
    opacity: 0;
    transform: scale(0.9);
  }
  to {
    opacity: 1;
    transform: scale(1);
  }
}
</style>
