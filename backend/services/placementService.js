const placementDAO = require('../DAO/placementDAO');

module.exports = {
    
    getPlacementById: (id) => {        
        return placementDAO.getPlacementById(id);
    },
};