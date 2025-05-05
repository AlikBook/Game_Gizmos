import { createRouter, createWebHistory } from "vue-router";
import Home from "../src/components/Home.vue";
import Discover from "../src/components/Discover.vue";
import Individual_game from "../Individual_game.vue";
import Events from "../src/views/Events.vue";

const routes = [
  { path: "/", name: "Home", component: Home },
  { path: "/discover", name: "Discover", component: Discover },
  { path: "/events", name: "Events", component: Events },
  { path: "/game/:id", name: "Individual_game", component: Individual_game },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;
