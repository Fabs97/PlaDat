
const placementDAO = require('../DAO/placementDAO');
const skillService = require('./skillsService');
const majorsDAO = require('../DAO/majorDAO');
const institutionsDAO = require('../DAO/institutionDAO');
const skillsDAO = require('../DAO/skillsDAO');

module.exports = {

    
    getAllPlacementsIds: async () => {

        return await placementDAO.getAllPlacementsIds();

    },

    savePlacementPage: async (placementDetails) => {

        let newPlacement = await placementDAO.createNewPlacement(placementDetails);

        newPlacement.institutions = await placementDAO.setPlacementInstitutions(newPlacement.id, placementDetails.institutions);
        newPlacement.majors = await placementDAO.setPlacementMajors(newPlacement.id, placementDetails.majors);

        let placementInfos = placementDetails.skills;

        let newSkills = [];
        if(placementInfos.technicalSkills && placementInfos.technicalSkills.length > 0) {
            newSkills = [...newSkills, ...placementInfos.technicalSkills];
        } 
        if(placementInfos.softSkills && placementInfos.softSkills.length > 0) {
            newSkills = [...newSkills, ...placementInfos.softSkills];
        }
        if(placementInfos.otherSkills && placementInfos.otherSkills.length > 0) {
            const otherSkills = await skillService.saveOtherSkills(placementInfos.otherSkills);
            newSkills = [...newSkills, ...otherSkills];  
        }
        newPlacement.skills = await placementDAO.setPlacementSkills(newPlacement.id, newSkills);
        
        return newPlacement;
    },

    getPlacementSkills: async (placementID) => {
        return await placementDAO.getPlacementSkillsByID(placementID);
    },

    getPlacementsForSkills: async (skills) => {
        let skillIDs = skills.map(skill => skill.skill_id);
        return placementDAO.getPlacementsForSkills(skillIDs);
    },

    getPlacementMajorsDetails: async  (id) => {
        let majorIds = await placementDao.getPlacementMajorsId(id);
        let majors = [];
        for(i = 0; i < majorIds.length(); i++){
            majors[i] = await majorsDAO.getMajorById(majorIds[i]);
        }
        return majors;
    },

    getPlacementInstitutionsDetails: async (id) => {
        let institutionIds = await placementDAO.getPlacementInstitutionsId(id);
        let institutions = [];
        for(i = 0; i < institutionIds.length(); i++){
            institutions[i] = await institutuionsDAO.getInstitututionById(institututionIds[i]);
        }
        return institututions;
    },

    getPlacementById: async (placementId) => {

        let placement = await placementDAO.getPlacementById(placementId);
        let institutionIds = await placementDAO.getPlacementInstitutionsId(placementId);
        let institutions = [];
        for(i = 0;i < institutionIds.length; i++){
            institutions[i] = await institutionsDAO.getInstitutionById(institutionIds[i].institution_id);
        }
        placement.institutions = institutions;
        let majorIds = await placementDAO.getPlacementMajorsId(placementId);
        let majors = [];
        for(i = 0; i < majorIds.length; i++){
            majors[i] = await majorsDAO.getMajorById(majorIds[i].major_id);
        }
        placement.majors = majors;
        skillIds = await placementDAO.getPlacementSkillsByID(placementId);
        let skills = [];
        for(i = 0; i < skillIds.length; i++){
            skills[i] = await skillsDAO.getSkillById(skillIds[i].skill_id);
        }
        placement.skills = skills;
        return placement;
    },



    getPlacementSkills: async (placementID) => {
        return await placementDAO.getPlacementSkillsById(placementID);
    },

};