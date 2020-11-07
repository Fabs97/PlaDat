const skillsDAO = require('../DAO/skillsDAO');
const studentDAO = require('../DAO/studentDAO');

module.exports = {
    getAvailableSkills: async () => {
        let technicalSkills = await skillsDAO.getSkillByType('TECH');
        let softSkills =  await skillsDAO.getSkillByType('SOFT');
        let skills = [...technicalSkills, ...softSkills];
        return skills;
    },
};