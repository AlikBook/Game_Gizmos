<template>

<template>
  <div v-if="game">
    <div>
      <img :src="game.game_image" alt="Game image" />
      <div>
        <h2>{{ game.game_name }}</h2>
        <p>Average Rating: {{ game.avg_rate ?? 'Not rated yet' }}</p>
        <p>Published: {{ game.publication_year }}</p>
      </div>
    </div>
  </div>
  <div v-else>
    Loading...
  </div>
</template>
</template>

<script setup>
    import { ref, onMounted } from 'vue';
    import { useRoute } from 'vue-router';

    const route = useRoute();
    const game = ref(null);

    const fetchData = async () => {
    try {
        const id = route.params.id; 
        const response = await fetch(`http://localhost:3000/game/${id}`);
        if (!response.ok) {
        throw new Error("Network response was not ok");
        }
        game.value = await response.json();
    } catch (error) {
        console.error("Error fetching data:", error);
    }
    };

    onMounted(fetchData);
</script>



<style scoped>

</style>