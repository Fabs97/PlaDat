const institutionDAO = require('../DAO/institutionDAO');

module.exports = {
    getInstitutions: async () => {        
        const institutions =  await institutionDAO.getInstitutions();
        return institutions;
    },

    getInstitutionById: async (id) => {
        return await institutionDAO.getInstitutionById(id);
    },
};