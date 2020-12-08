
const placementDAO = require('../DAO/placementDAO');
const skillService = require('./skillsService');
const skillsService = require('./skillsService');
const employerService = require('./employerService');
const matchService = require('./matchService');
const SuperError = require('../errors').SuperError;
const ERR_INTERNAL_SERVER_ERROR = require('../errors').ERR_INTERNAL_SERVER_ERROR;

module.exports = {

    
    getAllPlacementsIds: async () => {

        return await placementDAO.getAllPlacementsIds();

    },

    savePlacementPage: async (placementDetails) => {

        let newPlacement = {};

        try {

            newPlacement = await placementDAO.createNewPlacement(placementDetails);

            if(placementDetails.institutions) {
                newPlacement.institutions = await placementDAO.setPlacementInstitutions(newPlacement.id, placementDetails.institutions);
            }
            if(placementDetails.majors) {
                newPlacement.majors = await placementDAO.setPlacementMajors(newPlacement.id, placementDetails.majors);
            }

            if(placementDetails.skills) {
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

            }

        } catch(error) {
            if(!error.code) {
                throw new SuperError(ERR_INTERNAL_SERVER_ERROR, error.message || "Server Error");
            }
            throw error; 
        }
        
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
        placement.skills = await skillsService.getPlacementSkills(placementId);
        placement.employer = await employerService.getEmployer(placement.employer_id);
        return placement;
    },

    getPlacementsByEmployerId: (employerId) => {
        return placementDAO.getPlacementsByEmployerId(employerId);
    },

    deletePlacementById: (id) => {
        return placementDAO.deletePlacementById(id);
    },

    getPlacementsMatchWithStudent: (studentId) => {
        return matchService.getMatchesByStudentId(studentId);
    }
};