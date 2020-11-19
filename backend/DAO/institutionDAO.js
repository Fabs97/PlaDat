  const database = require('../DB/connection');

  module.exports = {

    getInstitutions: async () => {
          return database('institutions')
              .select('id', 'name');
    },

    getInstitutionById: async (id) => {
      let institution = await database('institutions')
              .select('id', 'name')
              .where('id', id); 
      return institution[0];
    },


    
};