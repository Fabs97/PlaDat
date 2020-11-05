const express = require('express');
const app = express();
const port = 3000;

const studentRoute = require("routes/studentRoute");

app.use("/student", studentRoute);

app.get('/', (req, res) => res.send('Hello World!'));
app.listen(port, () => console.log(`Example app listening on port ${port}!`));