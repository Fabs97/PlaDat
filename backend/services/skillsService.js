const skillsDAO = require('../DAO/skillsDAO');
const studentDAO = require('../DAO/studentDAO');

const self = module.exports = {
    getAvailableSkills: async () => {
        const technicalSkills = await skillsDAO.getSkillByType('TECH');
        const softSkills =  await skillsDAO.getSkillByType('SOFT');
        const skills = {
            technicalSkills: technicalSkills,
            softSkills: softSkills
        };
        return skills;
    },

    saveOtherSkills: async (skills) =>  {
        let newSkills = [];
        for(let i=0; i<skills.length; i++) {
            let newSkill = await self.addNewOtherSkillIfNeeded(skills[i]);
            newSkills.push(newSkill);
        }
        return newSkills;
    },

    // This function check if the other skill already exist in the db adn adds it if needed, it returns the skill Id
    addNewOtherSkillIfNeeded: async (skillName) => {
        let skillID = null;
        // Aida: I commented this because the method is not implemented and it was giving me errors
        // let skillID = await skillsDAO.checkIfOtherSkillExists(skillName);
        if(skillID == null) {
            skillID = await skillsDAO.addNewOtherSkill(skillName);
        }
        return skillID[0];
        
    },

    // this look in the db for a skill, known the name and type
    getSkillByNameAndType: async (skillName, skillType) => {

        return await skillsDAO.getSkillByNameAndType(skillName, skillType);

    }
};