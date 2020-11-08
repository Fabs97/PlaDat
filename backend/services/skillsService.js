const skillsDAO = require('../DAO/skillsDAO');
const studentDAO = require('../DAO/studentDAO');

module.exports = {
    getAvailableSkills: async () => {
        const technicalSkills = await skillsDAO.getSkillByType('TECH');
        const softSkills =  await skillsDAO.getSkillByType('SOFT');
        const skills = {
            technicalSkills: technicalSkills,
            softSkills: softSkills
        };
        return skills;
    },
};