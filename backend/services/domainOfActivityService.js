const domainOfActivityDAO = require('../DAO/domainOfActivityDAO');

module.exports = {

    getAllDomainsOfActivity: async () => {
        return await domainOfActivityDAO.getAllDomainsOfActivity();
    },

    existsDomainOfActivity: async (id) => {
        return await domainOfActivityDAO.existsDomainOfActivity(id);
    }

}