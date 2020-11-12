
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
        newSkills = await placementDAO.setPlacementSkills(newPlacement[0].id, newSkills);
        let placementResult = {
            position: newPlacement[0].position,
            working_hours: newPlacement[0].working_ours,
            start_period: newPlacement[0].start_period,
            end_period: newPlacement[0].end_period, 
            salary: newPlacement[0].salary,
            description_role: newPlacement[0].description_role,
            institution: newPlacement[0].institution, 
            major: newPlacement[0].major,
            skills: placementDetails.skills
        }
        return placementResult;
    },


};