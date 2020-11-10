const express = require('express');
const app = express();
const swaggerUI = require('swagger-ui-express');
const APIDocumentation = require('./docs/openapi');
const cors = require('cors');
const port = process.env.PORT || 3000;

const originWhitelist = [
    'http://127.0.0.1:8200',
    'http://localhost:8200',
];


app.use('/api-docs', swaggerUI.serve, swaggerUI.setup(APIDocumentation));

const studentRoute = require("./routes/studentRoute");
const majorRoute = require("./routes/majorRoute");
const institutionRoute = require("./routes/institutionRoute");
app.use('/', studentRoute);
app.use('/', majorRoute);
app.use('/', institutionRoute);

app.use(express.json());

app.use(cors({
    origin: (origin, callback) => {
        if (originWhitelist.indexOf(origin) !== -1) {
            callback(null, true)
        } else {
            callback(new Error('Not allowed by CORS'))
        }
    },   
    optionsSuccessStatus: 200,
}));

app.get('/', (req, res) => res.send('Hello World!'));
app.listen(port, () => console.log(`Example app listening on port ${port}!`));