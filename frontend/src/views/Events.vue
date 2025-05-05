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
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";

const events = ref([]);
const upcoming_events = ref([]);

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
}
.events-list {
  display: flex;
  flex-wrap: wrap;
  gap: 20px;
}
.event-card {
  background-color: #fff;
  border: 1px solid #ccc;
  border-radius: 10px;
  padding: 20px;
  box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
}
</style>
