
const studentDAO = require('../DAO/studentDAO');
const skillService = require('../services/skillsService')
const locationService = require('../services/locationService');
const SuperError = require('../errors').SuperError;
const ERR_INTERNAL_SERVER_ERROR = require('../errors').ERR_INTERNAL_SERVER_ERROR;
const educationService = require('../services/educationService')
const workService = require('../services/workService')

self = module.exports = {
    // Here you can add all kinds of methods that manage or handle data, or do specific tasks. 
    // This is the place where the business logic is.
    getStudent: (id) => {
        // Sometimes you need data from the DB. The Services are not allowed to directly access data, 
        // but they can request it from the specific DAO (Data Access Object) component.
        return studentDAO.getStudentById(id);
    },

    createStudentAccount: async (studentInfo) => {
        let studentProfile = {};

        try {
            studentProfile = await studentDAO.createStudentAccount(studentInfo);

            if(studentInfo.location){
                studentProfile.location = await self.saveStudentLocation(studentProfile.id, studentInfo.location);
            }

            if(studentInfo.skills) {
                studentProfile.skills = await self.saveStudentSkills(studentProfile.id, studentInfo.skills);
            }
            if(studentInfo.work && studentInfo.work.length > 0) {
                studentProfile.work = await workService.saveStudentWork(studentProfile.id, studentInfo.work);
            }
            if(studentInfo.education && studentInfo.education.length > 0){
                studentProfile.education = await educationService.saveStudentEducations(studentProfile.id, studentInfo.education);
            }
    
        } catch(error) {
            throw error;
        }
       
        return studentProfile;
    },

    saveStudentSkills: async (studentId, studentInfo) => {
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
        return studentDAO.setStudentSkills(studentId, skills);  
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
        let location = await locationService.addNewLocationIfNeeded(details);
        let result = await studentDAO.setStudentLocation(id, location.id)
        if (result != 1){
            locationService.deleteLocationById(location.id);
            throw new SuperError(ERR_INTERNAL_SERVER_ERROR, 'There has been a problem setting your student profile location. Please try again')
        }
        return location;
    },
};