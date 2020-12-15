const workDAO = require('../DAO/workDAO');

module.exports = {

    saveStudentWork: (studentID, work) => {   
        return workDAO.createWorkExperiences(studentID,work);
    },
};