<template>
  <div class="filters-list">
    <h3>Filters</h3>
    <div class="filter-option">
      <div class="slider-container">
        <label for="year-slider">Year</label>
        <Slider
          v-model="filters.yearRange"
          :min="1900"
          :max="2025"
          :step="1"
          :range="true"
          class="custom-slider"
        />
      </div>

      <p>
        Selected Range: {{ filters.yearRange[0] }} - {{ filters.yearRange[1] }}
      </p>
      <label for="Rate">Minimal Rate: </label>
      <input
        type="range"
        id="Rate"
        min="0"
        max="10"
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
import { ref, watch } from "vue";
import Slider from "@vueform/slider";
import "@vueform/slider/themes/default.css";

const filters = ref({
  minimalRate: 0,
  gameName: "",
  genres: [],
  yearRange: [1900, 2025],
});

const emit = defineEmits(["filterData"]);

watch(
  filters,
  (newFilters) => {
    emit("filterData", newFilters);
  },
  { deep: true }
);
</script>

<style>
.filters-list {
  padding: 20px;
  border: 1px solid #ccc;
  border-radius: 10px;
  margin-top: 20px;
}

.slider-container {
  display: flex;
  gap: 50px;
}

.custom-slider {
  width: 250px;
  margin: 10px 0;
  z-index: 100;

  --slider-height: 8px;

  --slider-handle-height: 20px;
  --slider-handle-width: 20px;

  --slider-connect-bg: #2e3e7d;
  --slider-handle-bg: #2e3e7d;

  --slider-handle-border: 2px solid #2e3e7d;
  --slider-handle-radius: 50%;

  --slider-tooltip-bg: #2e3e7d;
}

.custom-slider .slider-touch-area {
  height: 0;
  width: 0;
}
</style>
