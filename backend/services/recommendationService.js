const skillsService = require('./skillsService');
const placementsService = require('./placementService');
const studentService = require('./studentService');

module.exports = {

    //for employers
    getStudentRecommendationsForPlacement: async (placementID) => {   
        let placementSkills = await skillsService.getPlacementSkills(placementID);
        let studentIds = await studentService.getStudentsBySkills(placementSkills);
        let students =  [];
        for(let i = 0; i < studentIds.length; i++) {
            let student = await studentService.getStudentProfile(studentIds[i].student_id);
            students.push(student);
        }
        return students;
    },

    //for students
    getPlacementRecommendationsForStudent: async (studentID) => {
        let studentSkills = await skillsService.getStudentSkills(studentID);
        let placementIds = await placementsService.getPlacementsForSkills(studentSkills);
        let placements = [];
        for(let i = 0; i < placementIds.length; i++){
            let placement = await placementsService.getPlacementById(placementIds[i].id);
            placements.push(placement);
        }
        return placements;
    }
};