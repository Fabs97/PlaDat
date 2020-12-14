const matchDAO = require('../DAO/matchDAO');

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
    } 
};
