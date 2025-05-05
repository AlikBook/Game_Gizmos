<template>
  <div class="home">
    <section class="hero">
      <h1>Welcome to GameGizmos 🎲</h1>
      <p>Your hub for discovering, sharing and enjoying board games.</p>
    </section>

    <section class="cards">
      <router-link to="/discover" class="card discover">
        <h2>Discover</h2>
        <p>Explore our collection of the most iconic board games.</p>
      </router-link>

      <router-link to="/events" class="card events">
        <h2>Events</h2>
        <p>Join local and global board game events happening near you.</p>
      </router-link>

      <router-link to="/about" class="card about">
        <h2>About</h2>
        <p>Learn more about the creators and the mission of GameGizmos.</p>
      </router-link>
    </section>
  </div>
</template>

<script setup>
// No script needed for this basic layout
</script>

<style scoped>
.home {
  padding: 60px 20px;
  text-align: center;
  font-family: 'Segoe UI', sans-serif;
  background: linear-gradient(to right, #f7f7f7, #ffffff);
  min-height: 100vh;
}

.hero {
  margin-bottom: 50px;
}

.hero h1 {
  font-size: 48px;
  margin-bottom: 10px;
  color: #1e1e1e;
}

.hero p {
  font-size: 20px;
  color: #555;
}

.cards {
  display: flex;
  justify-content: center;
  gap: 30px;
  flex-wrap: wrap;
}

.card {
  background-color: white;
  border-radius: 20px;
  padding: 30px;
  width: 250px;
  height: 200px;
  text-align: left;
  box-shadow: 0 6px 20px rgba(0, 0, 0, 0.1);
  text-decoration: none;
  color: #000;
  transition: transform 0.3s ease, box-shadow 0.3s ease;
}

.card h2 {
  font-size: 24px;
  margin-bottom: 10px;
}

.card p {
  font-size: 16px;
  color: #555;
}

.card:hover {
  transform: translateY(-8px);
  box-shadow: 0 12px 24px rgba(0, 0, 0, 0.2);
}

/* Specific color accents */
.card.discover {
  border-left: 6px solid #0077cc;
}

.card.events {
  border-left: 6px solid #ff9933;
}

.card.about {
  border-left: 6px solid #66bb6a;
}
</style>
