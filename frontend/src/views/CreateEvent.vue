<template>
  <div class="create-event">
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
      <button type="submit" class="btn btn-secondary">Create Event</button>
    </form>
  </div>
</template>

<script setup>
import { ref } from "vue";
import { useRouter } from "vue-router";
import axios from "axios";
import { API_BASE_URL } from "../config.js";

const router = useRouter();

const eventName = ref("");
const eventDescription = ref("");
const maxParticipants = ref(0);
const minParticipants = ref(0);
const gameId = ref("");

const createEvent = async () => {
  try {
    const response = await axios.post(`${API_BASE_URL}/create-event`, {
      event_name: eventName.value,
      event_description: eventDescription.value,
      max_participants: maxParticipants.value,
      min_participants: minParticipants.value,
      game_id: gameId.value,
    });

    alert("Event created successfully!");
    router.push("/events"); 
  } catch (error) {
    console.error("Error creating event:", error);
    alert("Failed to create event.");
  }
};
</script>

<style scoped>
.create-event {
  max-width: 600px;
  margin: 0 auto;
  padding: 20px;
  background-color: #f9f9f9;
  border-radius: 8px;
  box-shadow: 0 2px 6px rgba(0, 0, 0, 0.1);
}

h2 {
  text-align: center;
  margin-bottom: 20px;
}

form div {
  margin-bottom: 15px;
}

label {
  display: block;
  font-weight: bold;
  margin-bottom: 5px;
}

input,
textarea {
  width: 100%;
  padding: 8px;
  border: 1px solid #ccc;
  border-radius: 4px;
}

button {
  display: block;
  width: 100%;
  padding: 10px;
  background-color: #4caf50;
  color: white;
  border: none;
  border-radius: 4px;
  font-size: 16px;
  cursor: pointer;
}

button:hover {
  background-color: #45a049;
}
</style>