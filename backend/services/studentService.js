
const studentDAO = require('../DAO/studentDAO');
const skillService = require('../services/skillsService')
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

            if(studentInfo.skills) {
                studentProfile.skills = await self.saveStudentSkills(studentProfile.id, studentInfo.skills);
            }
            if(studentInfo.work) {
                studentProfile.work = await workService.saveStudentWork(studentProfile.id, studentInfo.work);
            }
            // studentProfile.education = await educationService.saveStudentWork(studentProfile.id, studentInfo.education);
    
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
    }
};