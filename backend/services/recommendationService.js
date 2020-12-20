const skillsService = require('./skillsService');
const placementsService = require('./placementService');
const studentService = require('./studentService');

const SuperError = require('../errors').SuperError;
const ERR_INTERNAL_SERVER_ERROR = require('../errors').ERR_INTERNAL_SERVER_ERROR;

module.exports = {

    //for employers
    getStudentRecommendationsForPlacement: async (placementID) => {
        try {
            let placementSkills = await skillsService.getPlacementSkills(placementID);
            let students = await studentService.getStudentsBySkills(placementSkills);
            return students;
        } catch(error) {
            if(error.code = ERR_INTERNAL_SERVER_ERROR){
                throw error;
            } else {
                throw new SuperError(ERR_INTERNAL_SERVER_ERROR, 'There has been a problem with your recommendations. Please try again.')
            }
        }
        
    },

    //for students
    getPlacementRecommendationsForStudent: async (studentID) => {
        
        try {
            let studentSkills = await skillsService.getStudentSkills(studentID);
            let placements = await placementsService.getPlacementsForSkills(studentSkills);
            return placements;
        } catch(error) {
            if(error.code = ERR_INTERNAL_SERVER_ERROR){
                throw error;
            } else {
                throw new SuperError(ERR_INTERNAL_SERVER_ERROR, 'There has been a problem with your recommendations. Please try again.')
            }
        }
    }
};