<template>
  <div class="events-container">
    <h1>Events</h1>
    <div class="events-list">
      <div class="event-card" v-for="event in events" :key="event.event_id">
        <img
          :src="event.game_image"
          :alt="event.game_name"
          class="event-image"
        />
        <h2>{{ event.event_name }}</h2>
        <div class="event-details">
          <p><strong>Description:</strong> {{ event.event_description }}</p>
          <p><strong>Participants:</strong> {{ event.nb_participants }}</p>
          <p>
            <strong>Min/Max:</strong> {{ event.min_participants }} -
            {{ event.max_participants }}
          </p>
          <p>
            <strong>Game:</strong> {{ event.game_name }} (ID:
            {{ event.game_id }})
          </p>
          <p><strong>Event Date:</strong> {{ formatDate(event.event_date) }}</p>
          <p><strong>Event ID:</strong> {{ event.event_id }}</p>
        </div>
        <button
          v-if="!event.joined"
          @click="joinEvent(event.event_id)"
          class="join-button"
        >
          Join
        </button>
        <button v-else @click="leaveEvent(event.event_id)" class="leave-button">
          Leave
        </button>
      </div>
    </div>

    <h1>Upcoming Events</h1>
    <div class="events-list">
      <div
        class="event-card"
        v-for="event in upcoming_events"
        :key="event.event_id"
      >
        <img
          :src="event.game_image"
          :alt="event.game_name"
          class="event-image"
        />
        <h2>{{ event.event_name }}</h2>
        <div class="event-details">
          <p><strong>Description:</strong> {{ event.event_description }}</p>
          <p>
            <strong>Participants:</strong> {{ event.current_participants }} /
            {{ event.max_participants }}
          </p>
          <p><strong>Game:</strong> {{ event.game_name }}</p>
          <p><strong>Event Date:</strong> {{ formatDate(event.event_date) }}</p>
        </div>
        <button
          v-if="!event.joined"
          @click="joinEvent(event.event_id)"
          class="join-button"
        >
          Join
        </button>
        <button v-else @click="leaveEvent(event.event_id)" class="leave-button">
          Leave
        </button>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";

const events = ref([]);
const upcoming_events = ref([]);
const allGames = ref([]);

const user_id = ref(localStorage.getItem("user_id"));
const user_mail = ref(localStorage.getItem("username"));

const joinEvent = async (eventId) => {
  if (!user_id.value || !user_mail.value) {
    alert("Please log in to join an event.");
    return;
  }

  try {
    const response = await fetch(
      `http://localhost:3000/join_event/${eventId}`,
      {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          user_id: user_id.value,
          user_mail: user_mail.value,
        }),
      }
    );

    const data = await response.json();
    if (!response.ok) throw new Error(data.message || "Could not join event.");

    alert("You have successfully joined the event!");
    fetchData(); // Refresh after joining
  } catch (error) {
    console.error("Error joining event:", error);
    alert(`Could not join event: ${error.message}`);
  }
};

const formatDate = (dateString) => {
  const date = new Date(dateString);
  return date.toLocaleDateString("fr-FR", {
    day: "2-digit",
    month: "2-digit",
    year: "numeric",
  });
};

const leaveEvent = async (eventId) => {
  try {
    const response = await fetch(
      `http://localhost:3000/leave_event/${eventId}`,
      {
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          user_id: user_id.value,
          user_mail: user_mail.value,
        }),
      }
    );

    const data = await response.json();
    if (!response.ok) throw new Error(data.message || "Could not leave event.");

    alert("You have successfully left the event.");
    fetchData(); // Refresh after leaving
  } catch (error) {
    console.error("Error leaving event:", error);
    alert(`Could not leave event: ${error.message}`);
  }
};

const fetchAllGames = async () => {
  const res = await fetch("http://localhost:3000/allgames");
  return res.ok ? await res.json() : [];
};

const fetchData = async () => {
  try {
    const [games, resEvents, resUpcoming] = await Promise.all([
      fetchAllGames(),
      fetch("http://localhost:3000/events"),
      fetch("http://localhost:3000/upcoming_events"),
    ]);

    allGames.value = games;

    const enrichEvents = async (list) => {
      const joinedEvents = await fetchJoinedEvents();

      return list.map((event) => {
        const game = games.find((g) => g.game_id === event.game_id);
        return {
          ...event,
          game_image: game?.game_image || "",
          game_name: game?.game_name || "Unknown Game",
          joined: joinedEvents.includes(event.event_id),
        };
      });
    };

    if (!resEvents.ok || !resUpcoming.ok)
      throw new Error("Failed to fetch events");

    events.value = await enrichEvents(await resEvents.json());
    upcoming_events.value = await enrichEvents(await resUpcoming.json());
    console.log("upcoming_events", upcoming_events.value);
  } catch (error) {
    console.error("Error fetching data:", error);
  }
};

const fetchJoinedEvents = async () => {
  if (!user_id.value || !user_mail.value) return [];

  try {
    const res = await fetch(
      `http://localhost:3000/user_events?user_id=${user_id.value}&user_mail=${user_mail.value}`
    );
    const data = await res.json();
    return Array.isArray(data) ? data.map((e) => e.event_id) : [];
  } catch {
    return [];
  }
};

onMounted(() => {
  fetchData();
});
</script>

<style scoped>
.events-container {
  padding: 20px;
  background-color: #f4f4f9;
}

.events-list {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(320px, 1fr));
  gap: 24px;
  margin-top: 50px;
}

.event-card {
  background-color: white;
  border-radius: 12px;
  box-shadow: 0 6px 12px rgba(0, 0, 0, 0.1);
  padding: 20px;
  transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.event-card:hover {
  transform: translateY(-4px);
  box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
}

.event-image {
  width: 100%;
  height: 180px;
  object-fit: cover;
  border-radius: 10px;
  margin-bottom: 16px;
}

.event-card h2 {
  font-size: 1.6em;
  margin-bottom: 12px;
  color: #333;
}

.event-details p {
  margin: 6px 0;
  font-size: 1em;
  color: #555;
}

.event-details strong {
  color: #222;
}

button {
  margin-top: 16px;
  padding: 10px 16px;
  border-radius: 6px;
  border: none;
  font-weight: bold;
  font-size: 1em;
  cursor: pointer;
  transition: background-color 0.3s ease;
}

.join-button {
  background-color: #007bff;
  color: white;
}

.join-button:hover {
  background-color: #0056b3;
}

.leave-button {
  background-color: #dc3545;
  color: white;
}

.leave-button:hover {
  background-color: #c82333;
}
</style>
