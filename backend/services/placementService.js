
const placementDAO = require('../DAO/placementDAO');
const skillService = require('./skillsService');

module.exports = {


    // this service gets the data of a placement from the dao, knowing the placement's id
    getPlacementById: async (placementId) => {

        return await placementDAO.getPlacementById(placementId);

    },

    getAllPlacementsIds: async () => {

        return await placementDAO.getAllPlacementsIds();

    },

    savePlacementPage: async (placementDetails) => {

        let newPlacement = await placementDAO.createNewPlacement(placementDetails);
        //newPlacement = newPlacement[0];

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
        return await placementDAO.getPlacementSkillsById(placementID);
    },

};