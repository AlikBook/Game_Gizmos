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
import FilterButton from "../components/FilterButton.vue";
import FiltersList from "../components/FiltersList.vue";

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

    const meetsMinimalRate = game.avg_rate >= appliedFilters.value.minimalRate;

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
  text-align: center;
  font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
}

h2 {
  font-size: 32px;
  margin-bottom: 5px;
}

p {
  font-size: 16px;
  color: #555;
}

.game-list {
  display: grid;
  grid-template-columns: repeat(auto-fill, minmax(180px, 1fr));
  gap: 25px;
  margin-top: 30px;
}

.game-item {
  border: 1px solid #ccc;
  border-radius: 16px;
  padding: 15px;
  background-color: #fafafa;
  transition: transform 0.2s ease, box-shadow 0.2s ease;
}

.game-item:hover {
  transform: translateY(-5px);
  box-shadow: 0 4px 12px rgba(0, 0, 0, 0.1);
}

.game-item h3 {
  font-size: 18px;
  margin-bottom: 8px;
  color: #333;
}

.game-item p {
  font-size: 14px;
  margin: 4px 0;
  color: #666;
}

.game-item img {
  width: 100%;
  height: 180px;
  object-fit: cover;
  border-radius: 8px;
  margin-top: 10px;
}

.game-item h3 {
  font-size: 18px;
  margin-bottom: 8px;
  color: #333;
  display: -webkit-box;
  -webkit-line-clamp: 2;     
  -webkit-box-orient: vertical;
  overflow: hidden;
  text-overflow: ellipsis;
  height: 2.8em;               
}

</style>
