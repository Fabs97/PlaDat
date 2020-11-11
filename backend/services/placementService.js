const majorDAO = require('../DAO/placementDAO');

module.exports = {
    getMajors: async () => {   
        const placements = await placementDAO.getPlacements();
        return placements;
    },
};