const majorDAO = require('../DAO/majorDAO');
const institutionDAO = require('../DAO/institutionDAO');
const degreeDAO = require('../DAO/degreeDAO');

module.exports = {
    getMajors: () => {   
        return majorDAO.getMajors();
    },
    getMajorById: (id) => {
        return majorDAO.getMaiorById(id); 
    },
    getInstitutions: () => {        
        return institutionDAO.getInstitutions();
    },
    getInstitutionById: (id) => {
        return institutionDAO.getInstitutionById(id);
    },
    getDegrees: () => {
        return degreeDAO.getDegrees();
    },
    getDegreeById: (id) => {
        return degreeDAO.getDegreeById(id);
    },
};