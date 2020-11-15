// Update with your config settings.
require('dotenv').config({ path: './.env' })

const environment = process.env.PLADAT_ENV;
let DBConnection;
let seedDirectory;

switch (environment) {
  case "staging": {
    DBConnection = process.env.DATABASE_URL;
    seedDirectory = "./DB/seeds/staging";
  }
  case "production": {
    DBConnection = process.env.DATABASE_URL;
    seedDirectory = "./DB/seeds/production";
    break;
  }
  case "development": {
    DBConnection = ({
      host: process.env.DEV_DB_HOST,
      database: process.env.DEV_DB_NAME,
      user: process.env.DEV_DB_USR,
      port: process.env.DEV_DB_PORT,
      password: process.env.DEV_DB_PWD
    });
    seedDirectory = "./DB/seeds/development";
    break;    
  }
}

module.exports = {
  client: 'pg',
  connection: DBConnection,
  cwd: "./DB/",
  migrations: {
    directory: './DB/migrations'
  },
  seeds: {
    directory: seedDirectory
  }
};
