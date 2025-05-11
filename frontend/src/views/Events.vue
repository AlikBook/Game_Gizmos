<template>
  <div class="events-container">
    <h1>Events</h1>
    <div class="events-list">
      <div class="event-card" v-for="event in events" :key="event.id">
        <h2>{{ event.event_name }}</h2>
        <p>{{ event.event_description }}</p>
        <p>Number participants: {{ event.nb_participants }}</p>
        <p>From {{ event.min_participants }} to {{ event.max_participants }}</p>
        <p>Game ID: {{ event.game_id }}</p>
        <p>Event ID: {{ event.event_id }}</p>
        <button @click="joinEvent(event.event_id)">Join</button>
      </div>
    </div>

    <h2>Upcoming events</h2>
    <div class="events-list">
      <div class="event-card" v-for="event in upcoming_events" :key="event.id">
        <h2>{{ event.event_name }}</h2>
        <p>{{ event.event_description }}</p>
        <p>
          Current Participants: {{ event.current_participants }} /
          {{ event.max_participants }}
        </p>
        <p>Event ID : {{ event.event_id }}</p>
        <button @click="joinEvent(event.event_id)">Join</button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";

const events = ref([]);
const upcoming_events = ref([]);
const user_id = ref(localStorage.getItem("user_id"));
const user_mail = ref(localStorage.getItem("username"));

const joinEvent = async (eventId) => {
  console.log(user_id.value, user_mail.value);

  if (!user_id.value || !user_mail.value) {
    alert("Please log in to join an event.");
    return;
  }
  try {
    const response = await fetch(
      `http://localhost:3000/join_event/${eventId}`,
      {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
        },
        body: JSON.stringify({
          event_id: eventId,
          user_id: user_id.value,
          user_mail: user_mail.value,
        }),
      }
    );
    if (!response.ok) {
      throw new Error("Network response was not ok");
    }
    const data = await response.json();
    console.log("Joined event:", data);
  } catch (error) {
    console.error("Error joining event:", error);
  }
};

const fetchdata = async () => {
  try {
    const response_events = await fetch("http://localhost:3000/events");
    const response_upcoming_events = await fetch(
      "http://localhost:3000/upcoming_events"
    );
    if (!response_events.ok || !response_upcoming_events.ok) {
      throw new Error("Network response was not ok");
    }
    events.value = await response_events.json();
    upcoming_events.value = await response_upcoming_events.json();
  } catch (error) {
    console.error("Error fetching data:", error);
  }
};

onMounted(() => {
  fetchdata();
});
</script>

<style scoped>
.events-container {
  padding: 20px;
  background-color: #f4f4f9;
}

.events-list {
  display: grid;
  grid-template-columns: repeat(
    auto-fill,
    minmax(300px, 1fr)
  ); /* Pour une grille réactive */
  gap: 20px;
  margin-top: 100px;
}

.event-card {
  background-color: white;
  border-radius: 8px;
  box-shadow: 0 4px 6px rgba(0, 0, 0, 0.1);
  padding: 20px;
  transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.event-card:hover {
  transform: translateY(-5px);
  box-shadow: 0 6px 10px rgba(0, 0, 0, 0.2);
}

.event-card h2 {
  font-size: 1.5em;
  margin-bottom: 10px;
}

.event-card p {
  font-size: 1em;
  color: #555;
}

.event-card strong {
  font-weight: bold;
  color: #333;
}
</style>
