const matchDAO = require('../DAO/matchDAO');
const studentService = require('./studentService');

module.exports = {
    saveChoice: async (choice) => { 
        let previousInteraction = await matchDAO.getPreviousInteraction(choice.studentID, choice.placementID);
        let result = {};
        if(!previousInteraction) {
            result = await matchDAO.createInteraction(choice)
        } else {
            result = await matchDAO.saveInteraction(previousInteraction, choice);
        }
        return result;
    },

    getMatchesByStudentId: (studentId) => {
        return matchDAO.getMatchesByStudentId(studentId);
    },
    
    deleteMatch: async (studentId, placementId) => {
        return await matchDAO.deleteMatch(studentId, placementId);
    },

    getMatchesByPlacementId: async (placementId) => {        
        let students = await matchDAO.getMatchesByPlacementId(placementId);
        let studentProfiles = [];
        for (let i = 0; i<students.length; i++) {
            studentProfiles.push(await studentService.getStudentProfile(students[i].studentId));
        }  
        return studentProfiles;
    } 
};
