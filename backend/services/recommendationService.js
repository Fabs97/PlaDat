const skillsService = require('./skillsService');
const placementsService = require('./placementService');

module.exports = {

    //for employers
    // getStudentRecommendationsForPlacement: async (placementID) => {   
    //     let placementSkills = await placementService.getPlacementSkills(placementID);
    //     let students = await studentService.getStudentsBySkills(placementSkills);
    //     return students;
    // },

    //for students
    getPlacementRecommendationsForStudent: async (studentID) => {
        let studentSkills = await skillsService.getStudentSkills(studentID);
        let placements = await placementsService.getPlacementsForSkills(studentSkills);
        return placements;

    }
};