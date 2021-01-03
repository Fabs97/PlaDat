const employerDAO = require('../DAO/employerDAO');

const SuperError = require('../errors').SuperError;
const ERR_BAD_REQUEST = require('../errors').ERR_BAD_REQUEST;
const ERR_FORBIDDEN = require('../errors').ERR_FORBIDDEN;

const locationService = require('../services/locationService');
const domainOfActivityService = require('../services/domainOfActivityService');



module.exports = employerService = {
    getEmployer: (id) => {
        return employerDAO.getEmployer(id);
    },

    getLastEmployer: async () => {
        return await employerDAO.getLastEmployer();
    },

    getEmployerByUserId: (userId) => {
        return employerDAO.getEmployerByUserId(userId);
    },
    getEmployerByPlacementId: (placementId) => {
        return employerDAO.getEmployerByPlacementId(placementId);
    },
    createNewEmployer: async (details, auth) => {
        if(details && typeof(details.location.country) == 'string' && typeof(details.location.city) == 'string' && typeof(details.name) == 'string' && typeof(details.description) == 'string' && !isNaN(details.domainOfActivityId)){
            if(auth.userType !== 'EMPLOYER') {
                throw new SuperError(ERR_FORBIDDEN, 'You cannot create an employer profile from a non-employer account.')
            }
            let check = await domainOfActivityService.existsDomainOfActivity(details.domainOfActivityId);
            if(check){
                let newEmployer = await employerDAO.addNewEmployer(details, auth.id);
                if(details.location){
                    newEmployer.location = await employerService.saveEmployerLocation(newEmployer.id, details.location);
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
            throw new SuperError(ERR_INTERNAL_SERVER_ERROR, 'There has been a problem setting your student profile location. Please try again')
        }
        return location;
    },

    deleteEmployerById: async (id, auth) => {
        if(auth.employerId !== id) {
            throw new SuperError(ERR_FORBIDDEN, 'You cannot delete this employer profile');
        }
        return await employerDAO.deleteEmployerById(id);
    }
};