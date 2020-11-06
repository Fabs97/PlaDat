// Update with your config settings.

require('dotenv').config({ path: './.env' })

module.exports = {

  development: {
    client: 'pg',
    // connection: process.env.DB_DEV_CONNECTION
    // connection: 'postgres://postgres:csuite@localhost:5432/pladat'
    connection: ()=> ({
      host: process.env.DEV_DB_HOST,
      database: process.env.DEV_DB_NAME,
      user: process.env.DEV_DB_USR,
      port: process.env.DEV_DB_PORT,
      password: process.env.DEV_DB_PWD
    }),
    // migrations: {
    //   directory: __dirname + 'DB/migrations'
    // }
  },

  // production: {
  //   client: 'postgresql',
  //   connection: {
  //     database: 'my_db',
  //     user:     'username',
  //     password: 'password'
  //   }
  // }

};
