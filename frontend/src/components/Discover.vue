<template>
  <div class="discover">
    <h2>Discover</h2>
    <p>Explore our collection of games.</p>
    <FilterButton @showFilter="handleFilterToggle" />
    <FiltersList v-if="showFilters" @filterData="handleFilterData" />
    <p>{{ appliedFilters }}</p>
    <div class="game-list">
      <router-link
        v-for="game in filteredData"
        :key="game.game_id"
        :to="`/game/${game.game_id}`"
        class="game-item"
        style="text-decoration: none; color: inherit"
      >
        <h3>{{ game.game_name }}</h3>
        <p>Year: {{ game.publication_year }}</p>
        <p>Average rate: {{ game.avg_rate }}</p>
        <img :src="game.game_image" :alt="game.game_name" />
      </router-link>
    </div>
  </div>
</template>

<script setup>
import { ref, computed, onMounted } from "vue";
import FilterButton from "./FilterButton.vue";
import FiltersList from "./FiltersList.vue";

const data = ref([]);
const showFilters = ref(false);
const appliedFilters = ref({
  minimalRate: 0,
  gameName: "",
  genres: [],
  yearRange: [1900, 2025],
});

const handleFilterToggle = (value) => {
  showFilters.value = value;
};

const fetchData = async () => {
  try {
    const response = await fetch("http://localhost:3000/allgames");
    if (!response.ok) {
      throw new Error("Network response was not ok");
    }
    data.value = await response.json();
  } catch (error) {
    console.error("Error fetching data:", error);
  }
};

const handleFilterData = (filters) => {
  appliedFilters.value = filters;
  console.log("Applied Filters:", appliedFilters.value);
};

const filteredData = computed(() => {
  return data.value.filter((game) => {
    // Filtrer par année
    const isWithinYearRange =
      game.publication_year >= appliedFilters.value.yearRange[0] &&
      game.publication_year <= appliedFilters.value.yearRange[1];

    // Filtrer par note minimale
    const meetsMinimalRate = game.avg_rate >= appliedFilters.value.minimalRate;

    // Filtrer par nom (recherche partielle, insensible à la casse)
    const matchesGameName = game.game_name
      .toLowerCase()
      .includes(appliedFilters.value.gameName.toLowerCase());

    return isWithinYearRange && meetsMinimalRate && matchesGameName;
  });
});

onMounted(() => {
  fetchData();
});
</script>

<style scoped>
.discover {
  margin-top: 50px;
  padding: 20px;
}

.game-list {
  display: flex;
  flex-wrap: wrap;
  gap: 20px;
  justify-content: center;
  margin-top: 20px;
}

.game-item {
  border: 1px solid #ccc;
  padding: 10px;
  width: 150px;
  text-align: center;
  border-radius: 15px;
}
</style>
