const database = require('../DB/connection')

module.exports = {
    getPlacementById: (id) => {
        return database('placements')
            .select('*')
            .where('id', id);
    },

};