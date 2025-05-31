<template>
  <div v-if="game" class="game_container">
    <div class="game_container_details">
      <img :src="game.game_image" alt="Game image" />
      <div class="game_description">
        <h1>{{ game.game_name }}</h1>

        <p><u>Published</u> : {{ game.publication_year }}</p>
        <p><u>Game Artist</u> : {{ game.artist_name }}</p>
        <p><u>Game Designer</u> : {{ game.designer_name }}</p>
        <p><u>Publisher</u> : {{ game.publisher_name }}</p>
        <p>
          <u>Description:</u><br />
          {{ game.game_description }}
        </p>
      </div>
      <div class="game_rating_section">
        <p>Rating:</p>
        <p class="game_rating">{{ game.avg_rate ?? "Not rated yet" }} / 10</p>
      </div>
    </div>

    <div class="comment_insert" v-if="isLoggedIn">
      <input
        class="comment_insert_ipt_1"
        v-model="userInput"
        type="text"
        placeholder="Give us your opinion"
      />
      <input
        type="number"
        v-model="rating"
        min="0"
        max="10"
        step="0.1"
        placeholder="5.1"
      />
      <button @click="save_comment">Save</button>
    </div>
    <h2 id="User_comment_title">Comments</h2>
    <div class="User_comments">
      <div v-for="rate in rates">
        <h4>{{ rate.user_mail }}</h4>
        <p>{{ rate.Comments }} | Rate: {{ rate.Rate }} /10</p>
      </div>
    </div>
  </div>

  <div v-else>Loading...</div>
</template>

<script setup>
import { ref, onMounted } from "vue";
import { useRoute } from "vue-router";
import { API_BASE_URL } from "../config.js"; 

const isLoggedIn = ref(!!localStorage.getItem("token"));

const user_mail = localStorage.getItem("username");
const user_id = localStorage.getItem("user_id");
console.log(user_id);

const rating = ref(0);

const route = useRoute();
const game = ref(null);
const rates = ref(null);

const userInput = ref("");
async function save_comment() {
  const game_id = route.params.id;
  const body = {
    game_id,
    user_id,
    user_mail,
    rate: Number(rating.value.toFixed(1)),
    comments: userInput.value,
  };

  try {
    const res = await fetch(`${API_BASE_URL}/insert_rate/${game_id}`, {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
      },
      body: JSON.stringify(body),
    });

    if (!res.ok) throw new Error("Failed to submit rating");

    const data = await res.json();
    console.log("Success:", data);
    window.location.reload();
  } catch (err) {
    console.error("Error submitting rating:", err);
  }
}

const fetchData = async () => {
  try {
    const id = route.params.id;
    const response = await fetch(`${API_BASE_URL}/game_rate/${id}`);
    if (!response.ok) throw new Error("Network response was not ok");

    const data = await response.json();
    game.value = data.game;
    rates.value = data.rates;
  } catch (error) {
    console.error("Error fetching game and rates:", error);
  }
};

onMounted(fetchData);
</script>

<style scoped>
.game_container {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  width: 100%;
  padding-bottom: 20px;
  background-color: #f7f7f7;
  padding-top: 20px;
}
.game_container_details {
  width: 90%;
  padding: 30px;
  background-color: black;
  border-radius: 30px;
  display: flex;
  justify-content: space-evenly;
  color: white;
  gap: 10px;
}
.game_description {
  width: 50%;
  display: flex;
  flex-direction: column;
  gap: 6px;
}
.game_rating_section {
  width: 30%;
  text-align: center;
  margin: auto 0;
}
.game_rating {
  font-size: 78px;
}

.comment_insert {
  display: flex;
  justify-content: center;
  align-items: center;
  gap: 20px;
  width: 90%;
  margin-top: 10px;
  height: 60px;
  background-color: rgb(96, 96, 96);
  border-radius: 20px;
}

.comment_insert input {
  padding-left: 10px;
  padding-right: 10px;
  border-radius: 10px;
  height: 40px;
  border: none;
}
.comment_insert_ipt_1 {
  width: 80%;
}
.comment_insert button {
  height: 40px;
  background-color: #ff4d4d;
  border-radius: 10px;
  padding: 10px;
  border: none;
}
#User_comment_title {
  margin-top: 10px;
}
.User_comments {
  margin-top: 10px;
  width: 90%;
  background-color: rgb(229, 229, 229);
  padding: 20px;
  border-radius: 10px;
}

.User_comments h4 {
  margin-left: 5px;
}
.User_comments p {
  background-color: white;
  padding: 10px;
  margin-top: 5px;
  margin-bottom: 10px;
  border-radius: 10px;
}
</style>
