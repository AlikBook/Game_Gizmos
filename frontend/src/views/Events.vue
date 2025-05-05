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

<style scoped></style>
