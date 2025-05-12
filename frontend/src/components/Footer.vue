<template>
    <footer>
      <div class="footer-content">
        <div class="description">
          <h2>🎲 GameGizmos</h2>
          <p>GameGizmos est votre plateforme pour découvrir, organiser et partager des événements autour des jeux de société modernes.</p>
        </div>
        <div class="contact">
          <p><strong>Contact us:</strong></p>
          <p>📞 +33 1 23 45 67 89</p>
          <p>✉️ contact@gamegizmos.com</p>
        </div>
      </div>
      <div class="copyright">
        &copy; 2025 GameGizmos. All rights reserved.
      </div>
    </footer>
  </template>
  
  <script setup>
  </script>
  
  <style scoped>
  footer {
    
    bottom: 0;
    left: 0;
    width: 100%;
    background: #1e1e2f;
    color: white;
    padding: 20px 40px;
    box-shadow: 0 -2px 6px rgba(0, 0, 0, 0.2);
    z-index: 1000;
    display: flex;
    flex-direction: column;
    gap: 10px;
  }
  
  .footer-content {
    display: flex;
    justify-content: space-between;
    flex-wrap: wrap;
  }
  
  .description h2 {
    margin: 0 0 8px;
    font-size: 22px;
  }
  
  .description p,
  .contact p {
    margin: 5px 0;
    font-size: 14px;
    color: #ddd;
  }
  
  .contact {
    text-align: right;
  }
  
  .contact strong {
    font-size: 15px;
  }
  
  .description {
    max-width: 60%;
  }
  
  .contact {
    max-width: 35%;
  }
  
  @media (max-width: 768px) {
    .footer-content {
      flex-direction: column;
      align-items: flex-start;
    }
  
    .contact {
      text-align: left;
      margin-top: 10px;
    }
  }
  
  copyright {
    text-align: center;
    font-size: 13px;
    color: #aaa;
    margin-top: 10px;
  }
  </style>
  