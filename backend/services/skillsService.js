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

    //This function check if the other skill already exist in the db adn adds it if needed
    addNewOtherSkillIfNeeded: async (skillName) => {

        let skillID = await skillsDAO.checkIfOtherSkillExists(skillName);
        if(skillID == null) {
            skillID = await skillsDAO.addNewOtherSkill(skillName);
        }
        return skillID;
        
    },
};