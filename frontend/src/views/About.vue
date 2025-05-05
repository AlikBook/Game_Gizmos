<template>
    <div class="about">
      <h1>About Gizmos</h1>
  
      <section class="info">
        <p><strong>Website Created:</strong> April 2025</p>
  
        <p><strong>Creators:</strong> Ivan, Alexan, Gabriel and Paul</p>
      </section>
  
      <section class="more-link">
        <a href="https://green-it-vuejs.vercel.app/" target="_blank" rel="noopener">
          👉 See more about the Gizmos company
        </a>
      </section>
    </div>
  </template>
  
  <script>
  export default {
    name: "About"
  }
  </script>
  
  <style scoped>
  .about {
    max-width: 800px;
    margin: 0 auto;
    padding: 2rem;
    font-family: Arial, sans-serif;
    text-align: center;
    background-color: #f9f9f9;
    border-radius: 12px;
    box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
  }
  
  h1 {
    font-size: 2.5rem;
    margin-bottom: 1.5rem;
    color: #333;
  }
  
  .info {
    font-size: 1.2rem;
    margin-bottom: 2rem;
    line-height: 1.6;
    color: #555;
  }
  
  .more-link a {
    font-size: 1.1rem;
    color: #007BFF;
    text-decoration: none;
    font-weight: bold;
  }
  
  .more-link a:hover {
    text-decoration: underline;
  }
  </style>
  