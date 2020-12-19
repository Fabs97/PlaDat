const employerDAO = require('../DAO/employerDAO');

const SuperError = require('../errors').SuperError;
const ERR_BAD_REQUEST = require('../errors').ERR_BAD_REQUEST;

const locationService = require('../services/locationService');
const domainOfActivityService = require('../services/domainOfActivityService');



module.exports = self = {
    getEmployer: (id) => {
        return employerDAO.getEmployer(id);
    },

    getLastEmployer: async () => {
        return await employerDAO.getLastEmployer();
    },

    createNewEmployer: async (details) => {
        if(details && typeof(details.location.country) == 'string' && typeof(details.location.city) == 'string' && typeof(details.name) == 'string' && typeof(details.description) == 'string' && !isNaN(details.domainOfActivityId)){
            let check = await domainOfActivityService.existsDomainOfActivity(details.domainOfActivityId);
            if(check){
                let newEmployer = await employerDAO.addNewEmployer(details);
                if(details.location){
                    newEmployer.location = await self.saveEmployerLocation(newEmployer.id, details.location);
                }
                return newEmployer;
            } else {
                throw new SuperError(ERR_BAD_REQUEST, 'The domain of activity does not exists. Please try again.')
            }
        } else {
            throw new SuperError(ERR_BAD_REQUEST, 'Your request does not contain all the correct informations. Please try again');
        }
    },

    saveEmployerLocation: async (id, details) => {
        let location = await locationService.addNewLocationIfNeeded(details);
        let result = await employerDAO.setEmployerLocation(id, location.id)
        if (result != 1){
            locationService.deleteLocationById(location.id);
            throw new SuperError(ERR_INTERNAL_SERVER_ERROR, 'There has been a problem setting your student profile location. Please try again')
        }
        return location;
    },

    deleteEmployerById: async (id) => {
        await employerDAO.deleteEmployerById(id);
    }
};