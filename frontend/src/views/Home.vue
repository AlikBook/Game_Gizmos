<template>
  <div class="home">
    <h1>Welcome to <span class="highlight">GameGizmos</span> 🎮</h1>
    <p class="subtitle">Your gateway to the best games out there!</p>

    <div class="nav-links">
      <router-link to="/discover" class="nav-card">🎯 Discover</router-link>
      <router-link to="/events" class="nav-card">📅 Events</router-link>
      <router-link to="/about" class="nav-card">📖 About</router-link>
    </div>

    <div class="top-games">
      <h2>🔥 Top Games of the Moment</h2>
      <div class="game-cards">
        <router-link
          v-for="game in topGames"
          :key="game.game_id"
          :to="`/game/${game.game_id}`"
          class="game-card"
        >
          <img :src="game.game_image" :alt="game.game_name" />
          <h3>{{ game.game_name }}</h3>
          <p>⭐ {{ game.avg_rate }}</p>
        </router-link>
      </div>
    </div>

    <div class="upcoming-events">
      <h2>📆 Upcoming Events</h2>
      <div class="event-cards">
        <div
          class="event-card"
          v-for="event in events"
          :key="event.event_id"
        >
          <img :src="event.game_image" :alt="event.game_name" />
          <h3>{{ event.event_name }}</h3>
          <p>{{ event.event_description }}</p>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ref, onMounted } from "vue";

const topGames = ref([]);
const events = ref([]);  
const allGames = ref([]); 

const fetchTopGames = async () => {
  try {
    const response = await fetch("http://localhost:3000/allgames");
    const games = await response.json();
    allGames.value = games;
    topGames.value = games
      .sort((a, b) => b.avg_rate - a.avg_rate)
      .slice(0, 2);
  } catch (error) {
    console.error("Error fetching top games:", error);
  }
};


const fetchEvents = async () => {
  try {
    const response = await fetch("http://localhost:3000/upcoming_events");
    const eventData = await response.json();

    events.value = eventData.map(event => {
      const matchingGame = allGames.value.find(game => game.game_id === event.game_id);
      return {
        ...event,
        game_image: matchingGame?.game_image || "", 
        game_name: matchingGame?.game_name || "Unknown Game"
      };
    });
  } catch (error) {
    console.error("Error fetching upcoming events:", error);
  }
};



onMounted(async () => {
  await fetchTopGames(); 
  fetchEvents();         
});

</script>

<style scoped>
.home {
  padding: 100px 30px;
  text-align: center;
  background-color: #f9f9f9;
  color: #222;
  min-height: 100vh;
  font-family: 'Segoe UI', sans-serif;
}

h1 {
  font-size: 3rem;
  margin-bottom: 10px;
}

.highlight {
  color: #ff4d4d;
}

.subtitle {
  font-size: 1.2rem;
  color: #555;
  margin-bottom: 40px;
}

.nav-links {
  display: flex;
  justify-content: center;
  gap: 40px;
  margin-bottom: 60px;
  flex-wrap: wrap;
}

.nav-card {
  font-size: 1.3rem;
  padding: 20px 40px;
  background-color: #ff4d4d;
  color: white;
  border-radius: 15px;
  text-decoration: none;
  font-weight: bold;
  box-shadow: 0 4px 8px rgba(0,0,0,0.1);
  transition: transform 0.3s, background-color 0.3s;
}

.nav-card:hover {
  transform: translateY(-5px);
  background-color: #e63e3e;
}

.top-games {
  margin-top: 30px;
}

.top-games h2 {
  font-size: 2rem;
  margin-bottom: 30px;
}

.game-cards {
  display: flex;
  justify-content: center;
  gap: 30px;
  flex-wrap: wrap;
}

.game-card {
  width: 220px;
  background: white;
  color: #333;
  padding: 15px;
  border-radius: 12px;
  box-shadow: 0 4px 12px rgba(0,0,0,0.1);
  transition: transform 0.3s;
  text-decoration: none;
  text-align: center;
}

.game-card:hover {
  transform: scale(1.05);
}

.game-card img {
  width: 100%;
  height: 180px;
  object-fit: cover;
  border-radius: 8px;
  margin-bottom: 10px;
}

.game-card h3 {
  font-size: 1.1rem;
  margin-bottom: 5px;
  white-space: nowrap;
  overflow: hidden;
  text-overflow: ellipsis;
}

.upcoming-events {
  margin-top: 60px;
}

.upcoming-events h2 {
  font-size: 2rem;
  margin-bottom: 30px;
}

.event-cards {
  display: flex;
  justify-content: center;
  gap: 30px;
  flex-wrap: wrap;
}

.event-card {
  width: 220px;
  background: #fff;
  color: #333;
  padding: 15px;
  border-radius: 12px;
  box-shadow: 0 4px 12px rgba(0,0,0,0.1);
  transition: transform 0.3s;
  text-align: center;
}

.event-card:hover {
  transform: scale(1.05);
}

.event-card img {
  width: 100%;
  height: 150px;
  object-fit: cover;
  border-radius: 8px;
  margin-bottom: 10px;
}

.event-card h3 {
  font-size: 1.1rem;
  margin-bottom: 5px;
}

.event-card p {
  color: #888;
}

</style>
