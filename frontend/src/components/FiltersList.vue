<template>
  <div class="filters-list">
    <h3>Filters</h3>
    <div class="filter-option">
      <label for="year-slider">Year</label><br />
      <Slider
        v-model="filters.yearRange"
        :min="1900"
        :max="2025"
        :step="1"
        :range="true"
        class="custom-slider"
      />
      <p>
        Selected Range: {{ filters.yearRange[0] }} - {{ filters.yearRange[1] }}
      </p>
      <label for="Rate">Minimal Rate: </label>
      <input
        type="range"
        id="Rate"
        min="0"
        max="5"
        step="0.5"
        v-model="filters.minimalRate"
      />{{ filters.minimalRate }} <br />
      <label for="Genre"></label>
      <label for="Name">Name: </label>
      <input
        type="text"
        id="Name"
        placeholder="Game Name"
        v-model="filters.gameName"
      /><br />
    </div>
  </div>
</template>

<script setup>
import { ref } from "vue";
import Slider from "@vueform/slider";
import "@vueform/slider/themes/default.css";

const filters = ref({
  minimalRate: 0,
  gameName: "",
  genres: [],
  yearRange: [1900, 2025],
});

const emit = defineEmits(["filterData"]);
</script>

<style scoped>
.filters-list {
  padding: 20px;
  border: 1px solid #ccc;
  border-radius: 10px;
  margin-top: 20px;
}

.custom-slider {
  width: 250px;
  margin: 10px 0;
}
</style>

<style>
:root {
  --slider-color: #4c56af;
  --slider-thumb-color: #4c56af;
  --slider-bg: #e0e0e0;
  --slider-thumb-border-color: #4c56af;
  --slider-thumb-size: 50px;
}
</style>
