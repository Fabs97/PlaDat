const express = require('express');
const app = express();
const swaggerUI = require('swagger-ui-express');
const APIDocumentation = require('./docs/openapi');
const port = 3000;

app.use('/api-docs', swaggerUI.serve, swaggerUI.setup(APIDocumentation));

const studentRoute = require("./routes/studentRoute");
app.use('/', studentRoute);

app.get('/', (req, res) => res.send('Hello World!'));
app.listen(port, () => console.log(`Example app listening on port ${port}!`));