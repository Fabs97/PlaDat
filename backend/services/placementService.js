
const placementDAO = require('../DAO/placementDAO');
const skillService = require('./skillsService');
const majorsDAO = require('../DAO/majorDAO');
const institutionsDAO = require('../DAO/institutionDAO');
const skillsDAO = require('../DAO/skillsDAO');
const employerDAO = require('../DAO/employerDAO');

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

  

    getPlacementsForSkills: async (skills) => {
        let skillIDs = skills.map(skill => skill.id);
        return await placementDAO.getPlacementsForSkills(skillIDs);
    },

    getPlacementById: async (placementId) => {

        let placement = await placementDAO.getPlacementById(placementId);
        placement.institutions = await placementDAO.getPlacementInstitutions(placementId);
        placement.majors = await placementDAO.getPlacementMajors(placementId);
        placement.skills = await skillsDAO.getPlacementSkills(placementId);
        placement.employer = await employerDAO.getPlacementEmployer(placement.employer_id);
        return placement;
    },

};