const skillsService = require('./skillsService');
const placementsService = require('./placementService');
const studentService = require('./studentService');
const employerService = require('./employerService');
const SuperError = require('../errors').SuperError;
const ERR_INTERNAL_SERVER_ERROR = require('../errors').ERR_INTERNAL_SERVER_ERROR;
const ERR_FORBIDDEN = require('../errors').ERR_FORBIDDEN;

module.exports = {

    //for employers
    getStudentRecommendationsForPlacement: async (placementID, auth) => {
        let employer = await employerService.getEmployerByPlacementId(placementID);
        if(auth.employerId !== employer.id) {
            throw new SuperError(ERR_FORBIDDEN, 'You cannot see the recommendations for this placement.')
        }

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
    getPlacementRecommendationsForStudent: async (studentID, auth) => {

        if(auth.studentId !== studentID) {
            throw new SuperError(ERR_FORBIDDEN, 'You cannot see the recommendations for other students.')
        }
        
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