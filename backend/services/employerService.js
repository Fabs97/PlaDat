const employerDAO = require('../DAO/employerDAO');

module.exports = {
    getEmployer: (id) => {
        return employerDAO.getEmployer(id);
    },
};