// const environment = 'development';
// const config = require('../knexfile');
// const environmentConfig = config[environment];
const environmentConfig = require('../knexfile');
const knex = require('knex');
const connection = knex(environmentConfig);

module.exports = connection;