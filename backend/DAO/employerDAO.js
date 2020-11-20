const database = require('../DB/connection');

module.exports = {
    getPlacementEmployer: async (employer_id) => {
        return database('employer')
           .select('name', 'location', 'urllogo')
            .where('id', employer_id);
   },

};