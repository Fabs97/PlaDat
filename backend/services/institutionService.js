const institutionDAO = require('../DAO/institutionDAO');

module.exports = {
    getInstitution: async () => {        
        const institutions =  await institutionDAO.getIstitutions();
        return institutions;
    },
};