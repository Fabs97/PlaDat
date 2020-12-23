const express = require('express');
const app = express();
const swaggerUI = require('swagger-ui-express');
const APIDocumentation = require('./docs/openapi');
const cors = require('cors');
const jwt = require("jsonwebtoken");
const {authMiddleware} = require('./services/middlewareService')

const port = process.env.PORT || 3000;

const originWhitelist = [
    'http://127.0.0.1:8200/#/',
    'http://localhost:8200/#/',
];

// DO NOT DEFINE ROUTES ABOVE THIS LINE. THEY WON'T WORK. SIMPLE AS THAT
app.use(cors()); 


app.use('/api-docs', swaggerUI.serve, swaggerUI.setup(APIDocumentation));

app.use(express.json());

const studentRoute = require("./routes/studentRoute");
const placementRoute = require("./routes/placementRoute");
const skillsRoute = require("./routes/skillsRoute");
const recommendationRoute = require('./routes/recommendationRoute');
const matchRoute = require('./routes/matchRoute');
const employerRoute = require('./routes/employerRoute');
const locationRoute = require('./routes/locationRoute');
const registrationRoute = require('./routes/registrationRoute');
const messageRoute = require('./routes/messageRoute');
const educationRoute = require('./routes/educationRoute');
app.use('/', authMiddleware,studentRoute);
app.use('/', authMiddleware, placementRoute);
app.use('/', authMiddleware, skillsRoute);
app.use('/', authMiddleware, recommendationRoute);
app.use('/', authMiddleware, matchRoute);
app.use('/', authMiddleware, employerRoute);
app.use('/', authMiddleware, locationRoute);
app.use('/', authMiddleware, registrationRoute);
app.use('/', authMiddleware, educationRoute);
app.use('/', authMiddleware, messageRoute);

app.get('/', (req, res) => res.send('Hello World!'));
app.listen(port, () => console.log(`Example app listening on port ${port}!`));

module.exports = app;
