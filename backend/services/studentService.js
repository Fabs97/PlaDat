const studentDAO = require('../DAO/studentDAO');

module.exports = {
    getStudent: (id) => {

        return studentDAO.getStudentById(id);

    },
};