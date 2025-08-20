const express = require('express');
const path = require('path');
const app = express();
const PORT = 3000;

// Middleware to parse form data
app.use(express.urlencoded({ extended: true }));

// Serve index.html on root route
app.get('/', (req, res) => {
  res.sendFile(path.join(__dirname, 'views', 'register.html'));
});

// Handle registration form
app.post('/register', (req, res) => {
  const { name, email, phone } = req.body;
  res.send(`
    <html>
      <head><title>Registration Successful</title></head>
      <body style="font-family: Arial, sans-serif; max-width: 600px; margin: 40px auto;">
        <h2>Registration Successful 🎉</h2>
        <p><strong>Name:</strong> ${name}</p>
        <p><strong>Email:</strong> ${email}</p>
        <p><strong>Phone:</strong> ${phone}</p>
        <a href="/">Go back</a>
      </body>
    </html>
  `);
});

// Start server
app.listen(PORT, '0.0.0.0', () => {
  console.log(`✅ App running on http://0.0.0.0:${PORT}`);
});

