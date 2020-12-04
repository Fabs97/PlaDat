const database = require('../DB/connection');

module.exports = {
    getEmployer: async (employer_id) => {
        let result = await database('employer')
            .select('name', 'location', 'urllogo')
            .where('id', employer_id);
        return result[0];
    },

    getLastEmployer: async () => {
        let result = await database("employer")
            .select("id")
            .orderBy("id", "desc")
            .limit(1);
        return result[0];
    },

};