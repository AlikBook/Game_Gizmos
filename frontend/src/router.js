import { createRouter, createWebHistory } from "vue-router";
import Home from "../src/components/Home.vue";
import Discover from "../src/components/Discover.vue";

const routes = [
  { path: "/", name: "Home", component: Home },
  { path: "/discover", name: "Discover", component: Discover },
];

const router = createRouter({
  history: createWebHistory(),
  routes,
});

export default router;
