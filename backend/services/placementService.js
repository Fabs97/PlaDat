
const placementDAO = require('../DAO/placementDAO');

module.exports = {

    // this service forwards the data of a new placement to the dao
    savePlacementPage: async (placementDetails) => {

        const details = JSON.parse(placementDetails);
        return await placementDAO.createNewPlacement(details);

    },

    // this service gets the data of a placement from the dao, knowing the placement's id
    getPlacementById: async (placementId) => {

        return await placementDAO.getPlacementById(placementId);

    },

};