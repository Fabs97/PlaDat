const locationDAO = require('../DAO/locationDAO');

self = module.exports = {
    saveLocation: async (locationDetails) => {
        return await locationDAO.saveLocation(locationDetails);
    },

    findLocationByDetails: async (locationDetails) => {
        return await locationDAO.findLocationByDetails(locationDetails);
    },

    addNewLocationIfNeeded: async (locationDetails) => {
        let location;
        location = await locationDAO.findLocationByDetails(locationDetails);
        if(location == undefined) {
            location = await locationDAO.saveLocation(locationDetails);
        }
        
        return location;
    },

    deleteLocationById: async (id) => {
        await locationDAO.deleteLocationById(id);
    }
}