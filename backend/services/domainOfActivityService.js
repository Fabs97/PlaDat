const domainOfActivityDAO = require('../DAO/domainOfActivityDAO');

module.exports = {

    getAllDomainsOfActivity: () => {
        return domainOfActivityDAO.getAllDomainsOfActivity();
    },

    existsDomainOfActivity: (id) => {
        return domainOfActivityDAO.existsDomainOfActivity(id);
    }

}