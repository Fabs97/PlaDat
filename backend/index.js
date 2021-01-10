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

var options = {
    swaggerOptions: {
      authAction :{ JWT: {name: "JWT", schema: {type: "apiKey", in: "header", name: "Authorization", description: ""}, value: "Bearer <JWT>"} }
    }
  };
app.use('/', swaggerUI.serve, swaggerUI.setup(APIDocumentation, options));

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
const domainOfActivityRoute = require('./routes/domainOfActivityRoute');
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
app.use('/', authMiddleware, domainOfActivityRoute);

app.listen(port, () => console.log(`PlaDat backend listening on port ${port}!`));

module.exports = app;
