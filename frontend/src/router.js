import { createRouter, createWebHistory } from "vue-router";
import Home from "../src/views/Home.vue";
import Discover from "../src/views/Discover.vue";
import Individual_game from "../src/views/Individual_game.vue";
import Events from "../src/views/Events.vue";
import About from "../src/views/About.vue";


const routes = [
  { path: "/", name: "Home", component: Home },
  { path: "/discover", name: "Discover", component: Discover },
  { path: "/events", name: "Events", component: Events },
  { path: "/game/:id", name: "Individual_game", component: Individual_game },
  {
    path: '/about',
    name: 'About',
    component: About 
  }
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;
