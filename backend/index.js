const express = require('express');
const app = express();
const swaggerUI = require('swagger-ui-express');
const APIDocumentation = require('./docs/openapi');
const port = 3000;

app.use('/api-docs', swaggerUI.serve, swaggerUI.setup(APIDocumentation));

const studentRoute = require("./routes/studentRoute");
const majorRoute = require("./routes/majorRoute");
const institutionRoute = require("./routes/institutionRoute");
app.use('/', studentRoute);
app.use('/', majorRoute);
app.use('/', institutionRoute);

app.get('/', (req, res) => res.send('Hello World!'));
app.listen(port, () => console.log(`Example app listening on port ${port}!`));