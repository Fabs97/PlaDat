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
        let matches = await matchDAO.getMatchesByPlacementId(placementId);
        
        let niceMatches = [];
        matches.forEach((match) => {
            let matchIndex = niceMatches.findIndex((niceMatch) => match.studentId === niceMatch.id);
            let newSkill = {id: match.id, name: match.skillName, type: match.type};

            if (matchIndex === -1) { 
                // Not an entry here
                niceMatches.push({
                    id: match.studentId,
                    name: match.studentName,
                    surname: match.surname,
                    description: match.description,
                    skills: [newSkill],
                });
            } else if(matchIndex >= 0 && matchIndex < niceMatches.length){
                // just add skills
                let matchType = match.type === "TECH" ? "technicalSkills" : "softSkills";
                niceMatches[matchIndex].skills =
                    [...niceMatches[matchIndex].skills, newSkill];
            }
        });
        return niceMatches;
    } 
};
