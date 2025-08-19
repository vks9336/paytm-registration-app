const express = require('express');
const path = require('path');
const app = express();
const PORT = 3000;

app.use(express.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, 'views')));

app.post('/register', (req, res) => {
    const { name, email, phone } = req.body;
    res.send(`<h2>Registration Successful</h2><p>Name: ${name}<br>Email: ${email}<br>Phone: ${phone}</p>`);
});

app.listen(PORT, () => console.log(`App running on http://localhost:${PORT}`));

