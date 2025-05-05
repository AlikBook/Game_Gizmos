<template>
  <button class="filter-button" @click="toggleFilters">
    <img src="../assets/filtre.png" class="filters-img" />Filters
  </button>
</template>

<script setup>
import { ref } from "vue";

const showFilters = ref(false);
const emit = defineEmits(["showFilter"]);

const toggleFilters = () => {
  showFilters.value = !showFilters.value;
  emit("showFilter", showFilters.value);
};
</script>

<style scoped>
.filter-button {
  display: flex;
  align-items: center;
  padding: 10px 20px;
  text-decoration: none;
  font-size: 16px;
  margin: 4px 2px;
  cursor: pointer;
  border-radius: 15px;
}

.filters-img {
  width: 20px;
  height: 20px;
  margin-right: 5px;
}
</style>
