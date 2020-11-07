// Update with your config settings.

require('dotenv').config({ path: './.env' })

module.exports = {

  development: {
    client: 'pg',
    connection: ()=> ({
      host: process.env.DEV_DB_HOST,
      database: process.env.DEV_DB_NAME,
      user: process.env.DEV_DB_USR,
      port: process.env.DEV_DB_PORT,
      password: process.env.DEV_DB_PWD
    }),
    cwd: "./DB/migrations",
    migrations: {
      directory: './DB/migrations'
    }
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
