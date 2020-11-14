const studentService = require('./studentService');
const placementService = require('./placementService');

module.exports = {

    //for employers
    getStudentRecommendationsForPlacement: async (placementID) => {   
        let placementSkills = await placementService.getPlacementSkills(placementID);
        let students = await studentService.getStudentsBySkills(placementSkills);
        return students;
    },

    //for students
    getPlacementMaches: async (student) => {

    }
};