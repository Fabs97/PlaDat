
const placementDAO = require('../DAO/placementDAO');
//This line is needed when integrated with the skill module
//const skillService = require('../services/skillService');

module.exports = {

    // this service forwards the data of a new placement to the dao
    savePlacementPage: async (placementDetails) => {

        return await placementDAO.createNewPlacement(placementDetails);

    },

    // this service gets the data of a placement from the dao, knowing the placement's id
    getPlacementById: async (placementId) => {

        return await placementDAO.getPlacementById(placementId);

    },

    getAllPlacementsIds: async () => {

        return await placementDAO.getAllPlacementsIds();

    },

    addSkillsToPlacement: async (placementId, placementInfos) => {

        let newSkills = [];
        if(placementInfos.technicalSkills && placementInfos.technicalSkills.length > 0) {
            newSkills = [...newSkills, ...placementInfos.technicalSkills];
        } 
        if(placementInfos.softSkills && placementInfos.softSkills.length > 0) {
            newSkills = [...newSkills, ...placementInfos.softSkills];
        }
        if(placementInfos.otherSkills && placementInfos.otherSkills.length > 0) {
            //this module is needed when integrated with the skill module
            //const otherSkills = await skillService.saveOtherSkills(placementInfos.otherSkills);
            newSkills = [...newSkills, ...otherSkills];  
        }
        return placementDAO.setPlacementSkills(placementId, newSkills)  

    },


};