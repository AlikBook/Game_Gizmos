<template>
  <div class="events-container">
    <h1>Events</h1>
    <div class="events-list">
      <div class="event-card" v-for="event in events" :key="event.id">
        <h2>{{ event.event_name }}</h2>
        <p>{{ event.event_description }}</p>
        <p><strong>Number participants:</strong> {{ event.nb_participants }}</p>
        <p>From {{ event.min_participants }} to {{ event.max_participants }}</p>
        <p>Game ID: {{ event.game_id }}</p>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";

const events = ref([]);

const fetchdata = async () => {
  try {
    const response = await fetch("http://localhost:3000/events");
    if (!response.ok) {
      throw new Error("Network response was not ok");
    }
    events.value = await response.json();
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
  grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); /* Pour une grille réactive */
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
