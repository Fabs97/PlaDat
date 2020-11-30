const employerDAO = require('../DAO/employerDAO');

module.exports = {
    getEmployer: (id) => {
        return employerDAO.getEmployer(id);
    },

    getLastEmployer: async () => {
        return await employerDAO.getLastEmployer();
    }
};