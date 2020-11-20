const skillsService = require('./skillsService');
const placementsService = require('./placementService');
const studentService = require('./studentService');

module.exports = {

    //for employers
    getStudentRecommendationsForPlacement: async (placementID) => {   
        let placementSkills = await skillsService.getPlacementSkills(placementID);
        let students = await studentService.getStudentsBySkills(placementSkills);
        return students;
    },

    //for students
    getPlacementRecommendationsForStudent: async (studentID) => {
        let studentSkills = await skillsService.getStudentSkills(studentID);
        let placements = await placementsService.getPlacementsForSkills(studentSkills);
        return placements;
    }
};