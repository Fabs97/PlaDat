const majorDAO = require('../DAO/majorDAO');

module.exports = {
    getMajors: async () => {   
        const majors = await majorDAO.getMajors();
        return majors;
    },
};