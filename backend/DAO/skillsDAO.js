const database = require('../DB/connection');

module.exports = {

    getSkillByType: (type) => {
        return database('skill')
            .select('id', 'name', 'type')
            .where('type', type);
    },

};