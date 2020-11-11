
const placementDAO = require('../DAO/placementDAO');

module.exports = {

    // this service forwards the data of a new placement to the dao
    savePlacementPage: async (placementDetails) => {

        return await placementDAO.createNewPlacement(placementDetails);

    },

    // this service gets the data of a placement from the dao, knowing the placement's id
    getPlacementById: async (placementId) => {

        return await placementDAO.getPlacementById(placementId);

    },

    getAllPlacementsIds: async () => {

        return await placementDAO.getAllPlacementsIds();

    },

};