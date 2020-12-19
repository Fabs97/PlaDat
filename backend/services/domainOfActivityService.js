const domainOfActivityDAO = require('../DAO/domainOfActivityDAO');

module.exports = {

    getAllDomainsOfActivity: async () => {
        return await domainOfActivityDAO.getAllDomainsOfActivity();
    }

}