<template>
  <header>
    <h1>GameGizmos</h1>
    <nav>
      <ul>
        <li><router-link to="/">Home</router-link></li>
        <li><router-link to="/about">About</router-link></li>
        <li><router-link to="/discover">Discover</router-link></li>
        <li><router-link to="/events">Events</router-link></li>
      </ul>
    </nav>
  </header>
</template>

<script setup></script>

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
  color: #100f0f;
}

header a:hover {
  text-decoration: underline;
}
</style>
