<template>
  <div v-if="game">
    <div>
      <img :src="game.game_image" alt="Game image" />
      <div>
        <h2>{{ game.game_name }}</h2>
        <p>Average Rating: {{ game.avg_rate ?? 'Not rated yet' }}</p>
        <p>Published: {{ game.publication_year }}</p>
        <p>Description {{ game.game_description }}</p>

        <div v-for="rate in rates">
          <p>{{ rate.Comments }} {{ rate.Rate }}</p>
        </div>

        <input v-model="userInput" type="text" placeholder="Type something" />
        <input type="number" v-model="rating" min="0" max="10" step="0.1" placeholder="5.1"/>
        <button @click="save_comment">Save rate</button>

        
      </div>
    </div>
  </div>
  <div v-else>
    Loading...
  </div>

</template>

<script setup>
    import { ref, onMounted } from 'vue';
    import { useRoute } from 'vue-router';
    
    const user_id = 4; 
    const user_mail = "guest@example.com";
    
    const rating = ref(0);

    const route = useRoute();
    const game = ref(null);
    const rates = ref(null)

    const userInput = ref('');
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
        const res = await fetch(`http://localhost:3000/insert_rate/${game_id}`, {
          method: 'POST',
          headers: {
            'Content-Type': 'application/json',
          },
          body: JSON.stringify(body),
        });

        if (!res.ok) throw new Error('Failed to submit rating');

        const data = await res.json();
        console.log('Success:', data);
      } catch (err) {
        console.error('Error submitting rating:', err);
      }
    }



    

    const fetchData = async () => {
      try {
        const id = route.params.id;
        const response = await fetch(`http://localhost:3000/game_rate/${id}`);
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

</style>