const matchDAO = require('../DAO/matchDAO');
const { SuperError, ERR_FORBIDDEN, ERR_NOT_FOUND } = require('../errors');
const employerService = require('./employerService');
const placementService = require('./placementService');
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
    
    deleteMatch: async (studentId, placementId, auth) => {
        let student = await studentService.getStudent(studentId);
        let employer = await employerService.getEmployerByPlacementId(placementId);
        //( foo && !bar ) || ( !foo && bar )
        if (  (auth.id !== student.userId && auth.id == employer.userId) 
        || (  (auth.id == student.userId) && auth.id !== employer.userId)) {
            throw new SuperError(ERR_FORBIDDEN, 'You are not authorized to delete this match');
            return;
        }
        return await matchDAO.deleteMatch(studentId, placementId);  
    },

    getMatchesByPlacementId: async (placementId, auth) => {        
        let employer = await employerService.getEmployerByPlacementId(placementId);
        if(employer === null) {
            throw new  SuperError(ERR_NOT_FOUND, 'The placement or the employer were not found');
            return;
        }
        if (auth.id !== employer.userId) {
            throw new SuperError(ERR_FORBIDDEN, 'You are not authorized to delete this match');
            return;
        }

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
