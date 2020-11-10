  const database = require('../DB/connection');

  module.exports = {

    getInstitutions: () => {
          return database('institutions')
              .select('id', 'name');
    }


    
};