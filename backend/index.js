const express = require('express');
const app = express();
const swaggerUI = require('swagger-ui-express');
const APIDocumentation = require('./docs/openapi');
const cors = require('cors');
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
const majorRoute = require("./routes/majorRoute");
const institutionRoute = require("./routes/institutionRoute");
const placementRoute = require("./routes/placementRoute");
const recommendationRoute = require('./routes/RecommendationRoute');
app.use('/', studentRoute);
app.use('/', majorRoute);
app.use('/', institutionRoute);
app.use('/', placementRoute);
app.use('/', recommendationRoute);



const skillsRoute = require("./routes/skillsRoute");
app.use('/', skillsRoute);


app.get('/', (req, res) => res.send('Hello World!'));
app.listen(port, () => console.log(`Example app listening on port ${port}!`));

module.exports = app;