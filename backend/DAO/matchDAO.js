const database = require('../DB/connection');
const SuperError = require('../errors').SuperError;
const ERR_INTERNAL_SERVER_ERROR = require('../errors').ERR_INTERNAL_SERVER_ERROR;

module.exports = {

    getPreviousInteraction: async (studentID, placementID) => {
        let result = await database('student_has_placement')
            .select('student_id', 'placement_id', 'student_accept', 'placement_accept', 'status')
            .where('student_id', studentID)
            .andWhere('placement_id', placementID);
        return result[0];
    },

    createInteraction: async (choice) => {
        let result = await database('student_has_placement')
            .returning()
            .insert({
                student_id: choice.studentID,
                placement_id: choice.placementID,
                student_accept: choice.studentAccept,
                placement_accept: choice.placementAccept, 
                status: (choice.studentAccept === false || choice.placementAccept === false ? 'REJECTED' : 'PENDING')
            }, ['student_id', 'placement_id', 'student_accept', 'placement_accept', 'status']);
        
        return result[0];
    },

    saveInteraction:  (previousInteraction, choice) => {
        return database('student_has_placement')
            .where({ 
                student_id: choice.studentID,
                placement_id: choice.placementID
            })
            .update(previousInteraction.student_accept ? { 
                placement_accept : choice.placementAccept,
                status: choice.placementAccept === true ? 'ACCEPTED' : 'REJECTED'
            } : { 
                student_accept : choice.studentAccept,
                status: choice.studentAccept === true ? 'ACCEPTED' : 'REJECTED'
            }, ['student_id', 'placement_id', 'student_accept', 'placement_accept', 'status'])
    },

    getMatchesByStudentId: (studentId) => {
        return database('student_has_placement as shp')
            .select('shp.placement_id as placementId', 'p.position', 'p.description_role', 'p.employer_id as employerId', 'e.name as employerName')
            .leftJoin('placements as p', 'p.id', 'shp.placement_id')
            .leftJoin('employer as e', 'e.id', 'p.employer_id')
            .where('shp.status','ACCEPTED')
            .andWhere('shp.student_id', studentId)
            .catch(error => {
                if(error){
                    throw new SuperError(ERR_INTERNAL_SERVER_ERROR, 'There has been a problem retrieving your matches. Please try again')
                }
            })
    }
};