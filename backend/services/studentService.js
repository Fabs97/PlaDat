
const studentDAO = require('../DAO/studentDAO');
const skillService = require('../services/skillsService')
const locationService = require('../services/locationService');
const SuperError = require('../errors').SuperError;
const ERR_BAD_REQUEST = require('../errors').ERR_BAD_REQUEST;


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

    saveStudentProfile: async (studentId, studentInfo) => {
        let skills = [];
        if(studentInfo.technicalSkills && studentInfo.technicalSkills.length > 0) {
            skills = [...skills, ...studentInfo.technicalSkills];
        } 
        if(studentInfo.softSkills && studentInfo.softSkills.length > 0) {
            skills = [...skills, ...studentInfo.softSkills];
        }
        if(studentInfo.otherSkills && studentInfo.otherSkills.length > 0) {
            const otherSkills = await skillService.saveOtherSkills(studentInfo.otherSkills);
            skills = [...skills, ...otherSkills];  
        }
        return studentDAO.setStudentSkills(studentId, skills)    
    },

    getStudentsBySkills: async (skills) => {
        let skillIds = skills.map(skill => skill.id);
        return await studentDAO.getStudentsBySkills(skillIds);
    },

    getStudentProfile: async (id) => {
        let profile = await studentDAO.getStudentById(id);
        profile.skills = await skillService.getStudentSkills(profile.id);
        return profile;
    },

    getLastStudent: async () => {
        return await studentDAO.getLastStudent();
    },

    deleteStudentById: (id) => {
        return studentDAO.deleteStudentById(id);
    },

    saveStudentLocation: async (id, details) => {
        let student = await studentDAO.getStudentById(id);
        if (student == undefined){
            throw new SuperError(ERR_BAD_REQUEST, 'The student account does not exists. Please try again.');
        }
        let location = await locationService.addNewLocationIfNeeded(details);
        let result = await studentDAO.setStudentLocation(id, location.id)
        return location;
    },
};