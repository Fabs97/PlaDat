const studentDAO = require('../DAO/studentDAO');

module.exports = {
    // Here you can add all kinds of methods that manage or handle data, or do specific tasks. 
    // This is the place where the business logic is.
    getStudent: (id) => {
        // Sometimes you need data from the DB. The Services are not allowed to directly access data, 
        // but they can request it from the specific DAO (Data Access Object) component.
        return studentDAO.getStudentById(id);
    },

    createStudentAccount: (studentInfo) => {
        return studentDAO.createStudentAccount(studentInfo);
    },

    saveStudentProfile: (studentId, studentInfo) => {
        let skills = [];
        if(studentInfo.technicalSkills && studentInfo.technicalSkills.length > 0) {
            skills = [...skills, ...studentInfo.technicalSkills];
        } 
        if(studentInfo.softSkills && studentInfo.softSkills.length > 0) {
            skills = [...skills, ...studentInfo.softSkills];
        }
        return studentDAO.setStudentSkills(studentId, skills)    
        // studentDAO.createStudentSkills(studentInfo.otherSkills);
    }
};