const skillsDAO = require('../DAO/skillsDAO');
const studentDAO = require('../DAO/studentDAO');
const skillService = require('../services/skillsService')

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
        let skillIds = skills.map(skill => skill.skill_id);
        return await studentDAO.getStudentsBySkills(skillIds);
    },

    getStudentProfile: async (id) => {
        let profile = await studentDAO.getStudentById(id);
        profile = profile[0];
        let skillIds = await skillsDAO.getStudentSkillsById(profile.id);
        let skills = [];
        for(let i = 0; i < skillIds.length; i++) {
            skills[i] = await skillsDAO.getSkillById(skillIds[i].skill_id);
        }
        profile.skills =skills;
        return profile;
    }
};