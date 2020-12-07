const workDAO = require('../DAO/workDAO');

module.exports = {

    saveStudentWork: async (studentID, work) => {   
        let workExperiences = await workDAO.createWorkExperiences(studentID,work);
        return workExperiences;
    },
};