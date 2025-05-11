<template>
  <div id="app">
    <Header />
    <main class="main-content">
      <router-view />
    </main>
    <Footer />
  </div>
</template>

<script setup>
import Header from './components/Header.vue'
import Footer from './components/Footer.vue'
</script>

<style>

body, html, #app {
  margin: 0;
  padding: 0;
  height: 100%;
}

.main-content {
  padding-top: 100px; 
  padding-bottom: 200px; 
  min-height: calc(100vh - 200px); 
}
</style>
